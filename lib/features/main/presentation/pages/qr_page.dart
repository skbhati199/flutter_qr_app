import 'package:flutter/material.dart';
import 'package:qr_app/features/main/presentation/pages/qr_details_page.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:wifi_iot/wifi_iot.dart';

class QRPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => QRPage(),
      );
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
          QRCodeDartScanView(
            scanInvertedQRCode: true,
            typeScan: TypeScan.live,
            // if TypeScan.takePicture will try decode when click to take a picture(default TypeScan.live)
            intervalScan: const Duration(seconds: 2),
            // onResultInterceptor: (old,newResult){
            // //  do any rule to controll onCapture.
            // },
            // takePictureButtonBuilder: (context, controller, isLoading) {
            //   // if typeScan == TypeScan.takePicture you can customize the button.
            //   if (isLoading) return CircularProgressIndicator();
            //   return ElevatedButton(
            //     onPressed: controller.takePictureAndDecode,
            //     child: Text('Take a picture'),
            //   );
            // },
            resolutionPreset: QRCodeDartScanResolutionPreset.high,
            // formats: const [
            //   BarcodeFormat.qrCode,
            //   BarcodeFormat.aztec,
            //   BarcodeFormat.dataMatrix,
            //   BarcodeFormat.pdf417,
            //   BarcodeFormat.code39,
            //   BarcodeFormat.code93,
            //   BarcodeFormat.code128,
            //   BarcodeFormat.ean8,
            //   BarcodeFormat.ean13,
            // ],
            onCapture: (Result? result) async {
              if (result!.text.contains("WIFI:")) {
                // Write a logic connect wifi here
                print(result.toString());
                RegExp keyValueRegex = RegExp(r"(\w+):(.+?)(;|$)");

                // Extract key-value pairs
                Map<String, String> configMap = {};
                keyValueRegex
                    .allMatches(result.text.replaceAll("WIFI:", ""))
                    .forEach((match) {
                  configMap[match.group(1)!] = match.group(2)!.trim();
                });

                print(configMap);

                // Access extracted information
                String ssid = configMap['S']!;
                String password = configMap['P']!;
                String encryptionType = configMap['T']!;

               
                await WiFiForIoTPlugin.connect(
                  ssid,
                  password: password,
                  joinOnce: true,
                  security: NetworkSecurity.WPA,
                );
                return;
              } else if (result.text.isNotEmpty) {
                Navigator.of(context).pushAndRemoveUntil(
                  QRDetailsPage.route(result),
                  (route) => false,
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
