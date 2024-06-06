import 'merge_pdf_platform_interface.dart';

class MergePdf {
  Future<bool> mergeMultiplePDFFiles({
    required String outputPath,
    required List<String> pdfPaths,
  }) {
    return MergePdfPlatform.instance.mergeMultiplePDFFiles(
      outputPath: outputPath,
      pdfPaths: pdfPaths,
    );
  }
}
