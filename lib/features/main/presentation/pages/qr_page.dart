import 'package:flutter/material.dart';
import 'package:qr_app/features/main/presentation/pages/qr_details.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('QR Page'),
          QRCodeDartScanView(
            scanInvertedQRCode: true,
            typeScan: TypeScan.takePicture,
            // if TypeScan.takePicture will try decode when click to take a picture(default TypeScan.live)
            // intervalScan: const Duration(seconds:1)
            // onResultInterceptor: (old,newResult){
            // //  do any rule to controll onCapture.
            // },
            takePictureButtonBuilder: (context, controller, isLoading) {
              // if typeScan == TypeScan.takePicture you can customize the button.
              if (isLoading) return CircularProgressIndicator();
              return ElevatedButton(
                onPressed: controller.takePictureAndDecode,
                child: Text('Take a picture'),
              );
            },
            resolutionPreset: QRCodeDartScanResolutionPreset.medium,
            formats: const [
              BarcodeFormat.qrCode,
              BarcodeFormat.aztec,
              BarcodeFormat.dataMatrix,
              BarcodeFormat.pdf417,
              BarcodeFormat.code39,
              BarcodeFormat.code93,
              BarcodeFormat.code128,
              BarcodeFormat.ean8,
              BarcodeFormat.ean13,
            ],
            onCapture: (Result? result) {
              if (result != null) {
                Navigator.of(context).push(
                  QRDetailsPage.route(result),
                );
              }
              // do anything with result
              // result.text
              // result.rawBytes
              // result.resultPoints
              // result.format
              // result.numBits
              // result.resultMetadata
              // result.time
            },
          ),
        ],
      )),
    );
  }
}
