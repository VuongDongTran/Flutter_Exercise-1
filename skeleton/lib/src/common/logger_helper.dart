import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger _logEvent = Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true),
      output: ConsoleOutput());

  static void d(String messages) {
    _logEvent.d(messages);
  }

  static void i(String messages) {
    _logEvent.i(messages);
  }

  static void v(String messages) {
    _logEvent.v(messages);
  }

  static void w(String messages) {
    _logEvent.w(messages);
  }

  static void e(String messages) {
    _logEvent.e(messages);
  }
}
