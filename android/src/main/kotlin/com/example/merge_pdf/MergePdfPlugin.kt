package com.example.merge_pdf

import com.tom_roush.pdfbox.multipdf.PDFMergerUtility
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** MergePdfPlugin */
class MergePdfPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "merge_pdf")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method){
      "pathsInfo" -> {
        val arguments = call.arguments as HashMap<*, *>
        if(arguments.containsKey("pdfPaths") && arguments.containsKey("outputPath")){

          val paths = arguments["pdfPaths"] as  List<String>
          val outputDirPath = arguments["outputPath"] as String

          mergePDFs(outputDirPath, paths)

          result.success(true)
        }else{
          result.error("invalid_argument", "argument pathsInfo not found", null)
        }
      }
      else -> result.notImplemented()
    }

  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun mergePDFs(outputPath: String, pdfPaths: List<String>) {
    val merger = PDFMergerUtility()
    merger.destinationFileName = outputPath

    for (pdfPath in pdfPaths) {
      merger.addSource(File(pdfPath))
    }

    merger.mergeDocuments(null)
  }
}
