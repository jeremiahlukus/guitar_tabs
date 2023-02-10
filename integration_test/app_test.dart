import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:joyful_noise/main_staging.dart' as main_dart;

void main() {
  dotenv.testLoad(fileInput: File('.env.staging').readAsStringSync());
  patrolTest(
    'counter state is the same after going to home and switching apps',
    nativeAutomation: true,
    ($) async {
      main_dart.main();
      await $.pumpAndSettle();
      await $.pumpAndSettle();
      expect($('app'), findsOneWidget);
      await $.native.pressHome();
    },
  );
}
