import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:mammory_project/views/login/Report/component/pdf_view_report.dart';
import 'package:mammory_project/views/login/userprofile.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReportPage extends StatefulWidget {
  final String accountId;
  final String riskFactor;
  final String message;
  final String lesion;
  final String classType;
  final String reportUrl;

  const ReportPage({
    Key? key,
    required this.accountId,
    required this.riskFactor,
    required this.message,
    required this.lesion,
    required this.classType,
    required this.reportUrl,
  }) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // get classType => null;

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfView(
            file: file,
            url: url,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      appBar: AppBar(
        backgroundColor: Color(0xff8440fa),
        centerTitle: true,
        title: Text(
          "${widget.classType} Result",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: Column(children: [
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 380.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff352c56).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.riskFactor} %",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6b649e),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff352c56),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Lesion Type: ${widget.lesion}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6b649e),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    LinearPercentIndicator(
                      width: 270,
                      lineHeight: 20.0,
                      animation: true,
                      animationDuration: 5000,
                      percent: double.parse(widget.riskFactor) / 100,
                      barRadius: Radius.circular(10),
                      backgroundColor: Color(0xfff3edf9),
                      progressColor: Color(0xff8440fa),
                      center: Text(
                        'Risk factor: ${widget.riskFactor} %',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(310, 45),
                          backgroundColor: Color(0xff8440fa),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: (() async {
                        // url = widget.reportUrl;
                        final file = await loadPdfFromNetwork(widget.reportUrl);
                        openPdf(context, file, widget.reportUrl);
                      }),
                      child: const Text(
                        'View Report',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
