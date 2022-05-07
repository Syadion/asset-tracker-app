import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
      body: Container(
        child: Padding(
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

                //QR code widget
                BarcodeWidget(
                    data: qrController.trim(), barcode: Barcode.qrCode()),
                const SizedBox(
                  height: 50,
                ),

                Text(qrController),
              ],
            ),
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

    print(res);

    setState(() {
      qrController = res;
    });
  }
}
