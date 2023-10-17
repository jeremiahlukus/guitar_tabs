// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/routes/app_router.dart';
import 'package:joyful_noise/search/shared/providers.dart';

// coverage:ignore-start
// Most of this is implementing the material_floating_search_bar
// I feel ok just black boxing it
// I am going to rewite this file without material_floating_search_bar
// So i dont want to waste the time.
class SearchBar extends ConsumerStatefulWidget {
  final Widget body;
  final String title;
  final String hint;
  final void Function(String searchTerm) onShouldNavigateToResultPage;
  final void Function() onSignOutButtonPressed;

  const SearchBar({
    required this.body,
    required this.title,
    required this.hint,
    required this.onShouldNavigateToResultPage,
    required this.onSignOutButtonPressed,
    super.key,
  });

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends ConsumerState<SearchBar> /*with ConsumerStateMixin*/ {
  late FloatingSearchBarController _controller;
  static const signOutButtonKey = ValueKey('signOutButtonKey');
  static const searchKey = ValueKey('searchKey');

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void pushPageAndPutFirstInHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(searchTerm);
      _controller.close();
    }

    void pushPageAndAddToHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(searchTerm);
      _controller.close();
    }

    return FloatingSearchBar(
      key: searchKey,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      controller: _controller,
      height: 65,
      body: FloatingSearchBarScrollNotifier(
        child: Padding(
          // padding for scroll bar is 56
          padding: const EdgeInsets.only(top: 60),
          child: widget.body,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          AutoSizeText(
            'Tap to search 👆',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      hint: widget.hint,
      automaticallyImplyBackButton: false,
      leadingActions: [
        if (AutoRouter.of(context).canPop() && (Platform.isIOS || Platform.isMacOS))
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            splashRadius: 18,
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          )
        else if (AutoRouter.of(context).canPop())
          IconButton(
            icon: const Icon(Icons.arrow_back),
            splashRadius: 18,
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          ),
      ],
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        FloatingSearchBarAction(
          child: IconButton(
            key: signOutButtonKey,
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            splashRadius: 18,
            onPressed: () {
              widget.onSignOutButtonPressed();
            },
          ),
        ),
      ],
      onQueryChanged: (query) {
        ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms(filter: query);
      },
      onSubmitted: pushPageAndAddToHistory,
      builder: (context, transition) {
        return Material(
          color: Theme.of(context).cardColor,
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.hardEdge,
          child: Consumer(
            builder: (context, ref, child) {
              final searchHistoryState = ref.watch(searchHistoryNotifierProvider);
              return searchHistoryState.map(
                data: (history) {
                  if (_controller.query.isEmpty && history.value.isEmpty) {
                    return Container(
                      height: 56,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  } else if (history.value.isEmpty) {
                    return ListTile(
                      title: Text(_controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        pushPageAndAddToHistory(_controller.query);
                      },
                    );
                  }
                  return Column(
                    children: history.value
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                ref
                                    .read(
                                      searchHistoryNotifierProvider.notifier,
                                    )
                                    .deleteSearchTerm(term);
                              },
                            ),
                            onTap: () {
                              pushPageAndPutFirstInHistory(term);
                            },
                          ),
                        )
                        .toList(),
                  );
                },
                loading: (_) => const ListTile(
                  title: LinearProgressIndicator(),
                ),
                error: (_) => ListTile(
                  title: Text(
                    'Very unexpected error ${_.error}. Please screenshot and report this to jeremiahlukus1@gmail.com',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
// coverage:ignore-end
