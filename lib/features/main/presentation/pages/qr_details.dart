import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QRDetailsPage extends StatelessWidget {
  static route(Result value) => MaterialPageRoute(
        builder: (context) => QRDetailsPage(
          result: value,
        ),
      );
  final Result result;
  const QRDetailsPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Details'),
      ),
      body: Center(
        child: Text(result.toString()),
      ),
    );
  }
}
