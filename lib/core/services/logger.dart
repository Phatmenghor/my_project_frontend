import 'package:logger/logger.dart';

class CustomLogger {
  static final CustomLogger _instance = CustomLogger._internal();
  factory CustomLogger() => _instance;
  CustomLogger._internal();

  static CustomLogger get instance => _instance;

  final Logger _logger = Logger(
    filter: _CustomLogFilter(),
    printer: _CustomLogPrinter(),
  );

  void i(String message) => _logger.i(message);
  void e(String message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

class _CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >=
        Level.info.index; // Adjust logging level as needed
  }
}

class _CustomLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = _getColor(event.level);
    final message = '${event.level}: ${event.message}';
    return ['$color$message\x1B[0m'];
  }

  String _getColor(Level level) {
    switch (level) {
      case Level.error:
        return '\x1B[31m'; // Red
      case Level.warning:
        return '\x1B[33m'; // Yellow
      default:
        return '\x1B[0m'; // Default
    }
  }
}
