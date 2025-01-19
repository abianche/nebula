import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:nebula/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logger Tests', () {
    test('MyFilter should log only events with level >= specified level', () {
      final filter = MyFilter();
      filter.level = Level.warning;

      final shouldLogWarning = filter.shouldLog(LogEvent(Level.warning, 'Test warning'));
      final shouldLogError = filter.shouldLog(LogEvent(Level.error, 'Test error'));
      final shouldLogInfo = filter.shouldLog(LogEvent(Level.info, 'Test info'));

      expect(shouldLogWarning, isTrue);
      expect(shouldLogError, isTrue);
      expect(shouldLogInfo, isFalse);
    });

    test('SimpleLogPrinter formats log correctly', () {
      final printer = SimpleLogPrinter('TestComponent');
      final event = LogEvent(Level.info, 'This is a test message');
      final output = printer.log(event);

      expect(output.length, 1);
      expect(output.first, contains('[INFO]'));
      expect(output.first, contains('[TestComponent]'));
      expect(output.first, contains('This is a test message'));
    });

    test('SimpleLogPrinter handles error properly', () {
      final printer = SimpleLogPrinter('TestComponent');
      final error = Exception('Test error');
      final event = LogEvent(Level.error, 'Error occurred', error: error);
      final output = printer.log(event);

      expect(output.first, contains(error.toString()));
    });

    test('SimpleLogPrinter handles stack trace properly', () {
      final printer = SimpleLogPrinter('TestComponent');
      final stackTrace = StackTrace.current;
      final event = LogEvent(Level.error, 'Error occurred', stackTrace: stackTrace);
      final output = printer.log(event);

      expect(output.first, contains(stackTrace.toString()));
    });

    test('SimpleLogPrinter handles error and stack trace properly', () {
      final printer = SimpleLogPrinter('TestComponent');
      final error = Exception('Test error');
      final stackTrace = StackTrace.current;
      final event = LogEvent(Level.error, 'Error occurred', error: error, stackTrace: stackTrace);
      final output = printer.log(event);

      expect(output.first, contains(error.toString()));
      expect(output.first, contains(stackTrace.toString()));
    });

    test('getLogger returns a Logger instance with correct component', () {
      final logger = getLogger('TestComponent');
      expect(logger, isA<Logger>());
    });

    test('configureLogger sets correct level in release mode', () {
      configureLogger();
      if (!kDebugMode) {
        expect(Logger.level, Level.warning);
      } else {
        expect(Logger.level, Level.trace); // Default in debug mode
      }
    });
  });
}
