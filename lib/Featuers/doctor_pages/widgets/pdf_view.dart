import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatelessWidget {
  final String filePath;

  const PdfViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true, // Enable horizontal swipe navigation
        swipeHorizontal:
            true, // Set to true to enable horizontal swipe navigation
      ),
    );
  }
}
