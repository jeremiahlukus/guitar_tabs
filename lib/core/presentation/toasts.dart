// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flash/flash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> showNoConnectionToast(
  String message,
  BuildContext context,
) async {
  await showFlash(
    duration: const Duration(seconds: 2),
    context: context,
    builder: (context, controller) {
      return Flash<dynamic>(
        controller: controller,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.7),
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          height: 200,
          child: Column(
            children: [
              const Icon(
                FontAwesomeIcons.pooStorm,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showHelpToast(
  String message,
  BuildContext context,
  int seconds,
) async {
  await showFlash(
    duration: Duration(seconds: seconds),
    context: context,
    builder: (context, controller) {
      return Align(
        child: Material(
          child: Flash<dynamic>(
            controller: controller,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black54.withOpacity(0.7),
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              height: 250,
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.info,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    textScaleFactor: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showHelpDialog(
  String message,
  BuildContext context,
) async {
  await showFlash(
    context: context,
    barrierColor: Colors.black54,
    barrierDismissible: true,
    builder: (context, controller) => FadeTransition(
      opacity: controller.controller,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(),
        ),
        contentPadding: const EdgeInsets.only(left: 24, top: 16, right: 24, bottom: 16),
        title: Text(
          'Favorite Songs',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: controller.dismiss,
            child: const Text('Ok'),
          ),
        ],
      ),
    ),
  );
}
