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
                size: 96,
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
                color: Colors.black.withOpacity(0.7),
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              height: seconds == 2 ? 200 : 300,
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.info,
                    size: 96,
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
          ),
        ),
      );
    },
  );
}
