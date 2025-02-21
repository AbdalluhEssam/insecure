import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PDFViewerPage({super.key, required this.pdfUrl, required this.title});

  @override
  State<StatefulWidget> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfFromUrl();
  }

  // Download PDF file from URL and save locally
  Future<void> _loadPdfFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/${widget.title}.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load PDF: $e")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: Get.width * 0.65,
            child: const Center(child: CircularProgressIndicator()))
        : localPath != null
            ? SizedBox(
                height: Get.width * 0.65,
                child: PDFView(
                  filePath: localPath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  onError: (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error loading PDF: $e")),
                    );
                  },
                  onRender: (pages) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onPageError: (page, e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error on page $page: $e")),
                    );
                  },
                ),
              )
            : const Center(child: Text("Failed to load PDF"));
  }
}

class PDFViewerFullPage extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PDFViewerFullPage(
      {super.key, required this.pdfUrl, required this.title});

  @override
  State<StatefulWidget> createState() => _PDFViewerFullPageState();
}

class _PDFViewerFullPageState extends State<PDFViewerFullPage> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfFromUrl();
  }

  // Download PDF file from URL and save locally
  Future<void> _loadPdfFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/${widget.title}.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load PDF: $e")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : localPath != null
                ? PDFView(
                    filePath: localPath,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    onError: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error loading PDF: $e")),
                      );
                    },
                    onRender: (pages) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onPageError: (page, e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error on page $page: $e")),
                      );
                    },
                  )
                : const Center(child: Text("Failed to load PDF")));
  }
}
