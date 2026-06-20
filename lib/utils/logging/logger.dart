import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TLoggerHelper {
  static const String _divider = '-----------------------------------------------------------------------------------------';

  static String _timestamp() {
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final M = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    final ms = now.millisecond.toString().padLeft(3, '0');
    return '$y-$M-$d $h:$m:$s.$ms';
  }

  static String _extractAndFormatData(dynamic data) {
    if (data == null) return 'No Data Found / Empty';

    dynamic extractedData;

    try {
      if (data is DocumentSnapshot) {
        if (!data.exists || data.data() == null) {
          return 'No Data Found / Empty';
        }
        extractedData = data.data();
      } else if (data is QuerySnapshot) {
        if (data.docs.isEmpty) {
          return 'No Data Found / Empty';
        }
        extractedData = data.docs.map((doc) {
          final docData = doc.data();
          if (docData is Map) {
            return {'id': doc.id, ...docData as Map<String, dynamic>};
          }
          return docData;
        }).toList();
      } else if (data is DocumentReference) {
        extractedData = {'id': data.id, 'path': data.path};
      } else {
        extractedData = data;
      }

      if (extractedData is String) {
        try {
          final parsed = jsonDecode(extractedData);
          return JsonEncoder.withIndent('  ').convert(parsed);
        } catch (_) {
          return extractedData;
        }
      } else {
        return JsonEncoder.withIndent('  ').convert(extractedData);
      }
    } catch (e) {
      return data.toString();
    }
  }

  static String _formatKey(String key) {
    return key.padRight(11, ' ');
  }

  static void logRequest({
    required String service,
    required String operation,
    String? path,
    dynamic payload,
  }) {
    if (!kDebugMode) return;
    
    final header = '[⌛ TIMEOUT/INFO] ${_timestamp()} | [FIREBASE REQUEST]';
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln(_divider);
    buffer.writeln('${_formatKey('Service:')}$service');
    buffer.writeln('${_formatKey('Operation:')}$operation');
    if (path != null) buffer.writeln('${_formatKey('Path:')}$path');
    if (payload != null) {
      buffer.writeln('${_formatKey('Payload:')}');
      buffer.writeln(_extractAndFormatData(payload));
    }
    buffer.writeln(_divider);
    print(buffer.toString());
  }

  static void logResponse({
    required String service,
    required String operation,
    required Duration duration,
    dynamic data,
  }) {
    if (!kDebugMode) return;

    final header = '[✅ SUCCESS]      ${_timestamp()} | [FIREBASE RESPONSE]';
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln(_divider);
    buffer.writeln('${_formatKey('Service:')}$service');
    buffer.writeln('${_formatKey('Operation:')}$operation');
    buffer.writeln('${_formatKey('Duration:')}${duration.inMilliseconds}ms');
    buffer.writeln('${_formatKey('Data:')}');
    buffer.writeln(_extractAndFormatData(data));
    buffer.writeln(_divider);
    print(buffer.toString());
  }

  static void logError({
    required String service,
    required String operation,
    required dynamic error,
    Duration? duration,
  }) {
    if (!kDebugMode) return;

    final header = '[❌ ERROR]        ${_timestamp()} | [FIREBASE ERROR]';
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln(_divider);
    buffer.writeln('${_formatKey('Service:')}$service');
    buffer.writeln('${_formatKey('Operation:')}$operation');
    if (duration != null) {
      buffer.writeln('${_formatKey('Duration:')}${duration.inMilliseconds}ms');
    }
    buffer.writeln('${_formatKey('Error:')}$error');
    buffer.writeln(_divider);
    print(buffer.toString());
  }

  /// Wraps a Firestore Future call with standardized logging.
  static Future<T> wrapFirestoreCall<T>(String requestName, Future<T> request, {String? payload}) async {
    logRequest(service: 'Firestore', operation: requestName, payload: payload);
    final startTime = DateTime.now();
    try {
      final response = await request;
      final duration = DateTime.now().difference(startTime);
      logResponse(
        service: 'Firestore',
        operation: requestName,
        duration: duration,
        data: response,
      );
      return response;
    } catch (e) {
      final duration = DateTime.now().difference(startTime);
      logError(
        service: 'Firestore',
        operation: requestName,
        error: e,
        duration: duration,
      );
      rethrow;
    }
  }

  // Fallback simplified methods for backward compatibility
  static void debug(String message) {
    if (kDebugMode) print('[DEBUG] $message');
  }

  static void info(String message) {
    if (kDebugMode) print('[INFO] $message');
  }

  static void warning(String message) {
    if (kDebugMode) print('[WARNING] $message');
  }

  static void error(String message, [dynamic err]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (err != null) print(err.toString());
    }
  }
}
