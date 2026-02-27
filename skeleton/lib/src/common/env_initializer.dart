import 'package:flutter/widgets.dart';
import 'env_config.dart';

/// Global environment configuration instance
late EnvironmentConfig appConfig;

/// Initialize environment configuration
Future<EnvironmentConfig> initializeEnvironment() async {
  // Get environment from --dart-define
  const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  final env = Environment.fromString(environment);
  
  // Load configuration for this environment
  final config = await EnvironmentConfig.load(env);
  
  // Store globally for easy access
  appConfig = config;
  
  // Log environment info
  debugPrint('═══════════════════════════════════════');
  debugPrint('🌍 Environment Initialization');
  debugPrint('Environment: ${config.environment.displayName}');
  debugPrint('Base URL: ${config.baseUrl}');
  debugPrint('═══════════════════════════════════════');
  
  return config;
}

/// Easy accessor for global config
String getBaseUrl() => appConfig.baseUrl;
Environment getCurrentEnvironment() => appConfig.environment;
