import 'package:flutter/material.dart';
import 'package:qr_app/features/main/presentation/pages/qr_page.dart';
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
    return PopScope(
      onPopInvoked: (bool value) async {
        Navigator.of(context).pushAndRemoveUntil(
          QRPage.route(),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context)
                .pushAndRemoveUntil(QRPage.route(), (route) => false),
          ),
          title: const Text('QR Details'),
        ),
        body: Center(
          child: Text(result.toString()),
        ),
      ),
    );
  }
}
