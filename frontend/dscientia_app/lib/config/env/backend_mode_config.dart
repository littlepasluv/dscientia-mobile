class BackendModeConfig {
  const BackendModeConfig._();

  static const bool useBackendApi = bool.fromEnvironment(
    'DSCIENTIA_USE_BACKEND_API',
    defaultValue: false,
  );
}
