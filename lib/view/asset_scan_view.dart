import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssetScanScreen extends StatefulWidget {
  const AssetScanScreen({Key? key}) : super(key: key);

  @override
  State<AssetScanScreen> createState() => _AssetScanScreenState();
}

class _AssetScanScreenState extends State<AssetScanScreen> {
  String qrController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Scan Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    label: Text('enter text to generate')),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      qrController = '';
                    });
                  } else {
                    setState(() {
                      qrController = value;
                    });
                  }
                },
              ),

              const SizedBox(
                height: 30.0,
              ),

              //QR code widget (QR generator)
              QrImage(
                data: qrController.trim(),
                size: 200,
              ),
              const SizedBox(
                height: 50,
              ),

              Text(qrController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            scanCode();
          },
          label: const Text('Scan Qrcode')),
    );
  }

  void scanCode() async {
    String res = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'Cancel', true, ScanMode.QR);

    setState(() {
      qrController = res;
    });
  }
}
