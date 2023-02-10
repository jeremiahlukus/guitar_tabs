import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:joyful_noise/main_development.dart' as main_dart;
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      //dotenv.testLoad(fileInput: File('.env').readAsStringSync());
      main_dart.main();
      // Replace later with your app's main widget
      await $.pumpAndSettle();
      await $(#signInButtonKey).tap();

      expect($('app'), findsOneWidget);
      await $.native.pressHome();
    },
    nativeAutomation: true,
  );
}
