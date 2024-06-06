import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'merge_pdf_method_channel.dart';

abstract class MergePdfPlatform extends PlatformInterface {
  /// Constructs a MergePdfPlatform.
  MergePdfPlatform() : super(token: _token);

  static final Object _token = Object();

  static MergePdfPlatform _instance = MethodChannelMergePdf();

  /// The default instance of [MergePdfPlatform] to use.
  ///
  /// Defaults to [MethodChannelMergePdf].
  static MergePdfPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MergePdfPlatform] when
  /// they register themselves.
  static set instance(MergePdfPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> mergeMultiplePDFFiles({
    required String outputPath,
    required List<String> pdfPaths,
  });
}
