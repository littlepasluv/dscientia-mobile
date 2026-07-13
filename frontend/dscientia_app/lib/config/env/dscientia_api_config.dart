class DscientiaApiConfig {
  const DscientiaApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'DSCIENTIA_API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api',
  );
}
