import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssetQrGenerator extends StatefulWidget {
  const AssetQrGenerator({Key? key}) : super(key: key);

  @override
  State<AssetQrGenerator> createState() => _AssetQrGeneratorState();
}

class _AssetQrGeneratorState extends State<AssetQrGenerator> {
  final _formKey = GlobalKey<FormState>();

  Future<DocumentSnapshot> specificAssetData =
      FirebaseFirestore.instance.collection('assetData').doc('uid').get();

  String qrController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Register Asset'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImage(
                  data: qrController.trim(),
                  size: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                //qr generator text
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "uid",
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAssetData() async {
    DocumentSnapshot specificAssetData = await FirebaseFirestore.instance
        .collection('assetData')
        .doc('uid')
        .get();
  }
}
