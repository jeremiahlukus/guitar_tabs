lcov --remove coverage/lcov.info '**/*freezed.dart' '**/*g.dart' '**/*gr.dart' '**/providers.dart' 'lib/core/presentation/bootstrap.dart' 'lib/core/infrastructure/remote_response.dart' 'lib/core/infrastructure/network_exceptions.dart' '**/*_dto.dart' 'lib/core/infrastructure/sembast_database.dart' -o coverage/new_lcov.info
genhtml coverage/new_lcov.info --output=coverage
