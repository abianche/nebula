import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Get a logger for the given `component`.
///
/// The `component` is the name of the class or file that is using the logger.
///
/// Example:
/// ```dart
/// final logger = getLogger('main');
/// logger.i('App started');
/// ```
///
Logger getLogger(String component) {
  return Logger(
    printer: SimpleLogPrinter(component),
    filter: MyFilter(),
  );
}

/// Configure the logger to only log warnings and errors in release mode.
void configureLogger() {
  if (!kDebugMode) {
    Logger.level = Level.warning;
  }
}

/// A custom filter that only logs messages with a level greater than or equal to the specified level.
class MyFilter extends LogFilter {
  @override
  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >= (level?.index ?? Level.trace.index);
  }
}

/// A custom log printer that prints log messages in a simple format.
class SimpleLogPrinter extends LogPrinter {
  final String component;
  SimpleLogPrinter(this.component);

  /// Get the string representation of the log level.
  static String getLevelString(Level level) {
    return Level.values.contains(level) ? level.toString().split('.').last.toUpperCase() : 'UNKNOWN';
  }

  /// Get the current time in the format `HH:MM:SS.mmm`.
  String getTime() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    final sec = now.second.toString().padLeft(2, '0');
    final ms = now.millisecond.toString().padLeft(3, '0');
    return '$h:$min:$sec.$ms';
  }

  /// Log the given `event`.
  ///
  /// The log message is formatted as follows:
  ///
  /// ```
  /// [LEVEL] TIME [COMPONENT] - MESSAGE
  /// STACKTRACE
  /// ```
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final time = getTime();
    final level = getLevelString(event.level);
    final message = event.message;
    final error = event.error.toString();
    final stackTrace = event.stackTrace?.toString() ?? '';

    String formattedMessage = '[$level] $time [$component] - $message';
    if (error.isNotEmpty && error != 'null') {
      formattedMessage += ' - $error';
    }
    if (stackTrace.isNotEmpty) {
      formattedMessage += '\n$stackTrace';
    }

    /// Workaround for an issue with the logger package on iOS.
    /// see: https://github.com/leisim/logger/issues/1
    if (Platform.isIOS || color == null) {
      return [formattedMessage];
    }

    return [color(formattedMessage)];
  }
}
