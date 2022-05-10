import 'package:assettrackerapp/model/asset.dart';
import 'package:assettrackerapp/services/asset_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssetRegistrationScreen extends StatefulWidget {
  const AssetRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<AssetRegistrationScreen> createState() =>
      _AssetRegistrationScreenState();
}

class _AssetRegistrationScreenState extends State<AssetRegistrationScreen> {
  final FirebaseFirestore assetData = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _assetIdController = TextEditingController();
  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _assetLocationController =
      TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();

  bool isLoading = false;

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
                //qr generator
                QrImage(
                  data: _assetIdController.text.toString(),
                  size: 200,
                ),

                //asset ID
                TextFormField(
                  controller: _assetIdController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset ID",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter name';
                    }
                    return null;
                  },
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
                  height: 18.0,
                ),
                //Asset Name
                TextFormField(
                  controller: _assetNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Name",
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                //Asset Location
                TextFormField(
                  controller: _assetLocationController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Location",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Location';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18.0,
                ),
                //Asset Type
                TextFormField(
                  controller: _assetTypeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Type",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Type';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18.0,
                ),
                MaterialButton(
                  color: const Color(0xFF0069FE),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      DatabaseService service = DatabaseService();
                      Asset asset = Asset(
                        assetId: _assetIdController.text.trim(),
                        assetName: _assetNameController.text.trim(),
                        assetType: _assetTypeController.text.trim(),
                        assetLocation: _assetLocationController.text.trim(),
                      );
                      setState(() {
                        isLoading = true;
                      });
                      await service.addAsset(asset);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void _saveAsset() async {
    _asset.assetName = _assetNameController.text;
    _asset.assetType = _assetTypeController.text;
    _asset.assetLocation = _assetLocationController.text;

    await FirebaseFirestore.instance
        .collection('assetData')
        .add(_asset.toJson());
  }*/
}
