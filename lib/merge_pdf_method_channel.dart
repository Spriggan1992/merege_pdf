import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'merge_pdf_platform_interface.dart';

/// An implementation of [MergePdfPlatform] that uses method channels.
class MethodChannelMergePdf extends MergePdfPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('merge_pdf');

  @override
  Future<bool> mergeMultiplePDFFiles({
    required String outputPath,
    required List<String> pdfPaths,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('pathsInfo', {
        'outputPath': outputPath,
        'pdfPaths': pdfPaths,
      });

      return result ?? false;
    } on PlatformException catch (e) {
      log(
        'Не удалось объединить PDF-файлы: ${e.message}',
        name: 'PlatformException',
        error: e,
      );
      return false;
    } catch (e) {
      log(
        'Не удалось объединить PDF-файлы: ${e.toString()}',
        name: 'PlatformException',
        error: e,
      );
      return false;
    }
  }
}
