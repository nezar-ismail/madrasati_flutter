import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class LocalPDFViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('App Guide & Description'), backgroundColor: Colors.green, centerTitle: true, foregroundColor: Colors.white,),
      body: PdfView(
        controller: PdfController(
          document: PdfDocument.openAsset('asset/static/pdf/UI-UX.pdf'),
          initialPage: 2,
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}