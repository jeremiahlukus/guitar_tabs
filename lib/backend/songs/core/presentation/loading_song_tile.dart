// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// Package imports:
import 'package:shimmer/shimmer.dart';

class LoadingSongTile extends StatelessWidget {
  const LoadingSongTile({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1600),
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.grey),
            height: 14,
            width: 100,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.grey),
            height: 14,
            width: 250,
          ),
        ),
        leading: const CircleAvatar(),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star_border),
            Text(
              '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
