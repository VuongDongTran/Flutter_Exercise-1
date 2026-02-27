import 'package:flutter/services.dart';
import 'dart:convert';

enum Environment {
  dev('dev', 'development'),
  uat('uat', 'staging'),
  prod('prod', 'production');

  final String value;
  final String displayName;
  
  const Environment(this.value, this.displayName);

  static Environment fromString(String? env) {
    return Environment.values.firstWhere(
      (e) => e.value == env?.toLowerCase(),
      orElse: () => Environment.dev,
    );
  }
}

class EnvironmentConfig {
  final Environment environment;
  final String baseUrl;

  EnvironmentConfig({
    required this.environment,
    required this.baseUrl,
  });

  factory EnvironmentConfig.fromJson(Map<String, dynamic> json) {
    return EnvironmentConfig(
      environment: Environment.dev,
      baseUrl: json['baseUrl'] as String,
    );
  }

  static Future<EnvironmentConfig> load(Environment env) async {
    try {
      final configPath = 'assets/config/server_${env.value}.json';
      final jsonString = await rootBundle.loadString(configPath);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      return EnvironmentConfig(
        environment: env,
        baseUrl: jsonData['baseUrl'] as String,
      );
    } catch (e) {
      throw Exception('Failed to load config for ${env.value}: $e');
    }
  }

  @override
  String toString() => 'EnvironmentConfig(env: ${environment.displayName}, url: $baseUrl)';
}
