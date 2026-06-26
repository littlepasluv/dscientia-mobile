import 'environment.dart';

class AppConfig {
final Environment environment;

const AppConfig({
required this.environment,
});

String get appName => 'DscienTia';

String get apiBaseUrl {
switch (environment) {
case Environment.development:
return 'http://localhost:8000/api';

  case Environment.staging:
    return 'https://staging-api.dscientia.dev/api';

  case Environment.production:
    return 'https://api.dscientia.dev/api';
}

}

bool get enableLogging {
return environment != Environment.production;
}
}
