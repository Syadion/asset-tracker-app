import 'package:assettrackerapp/model/asset.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssetRegistrationScreen extends StatefulWidget {
  const AssetRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<AssetRegistrationScreen> createState() =>
      _AssetRegistrationScreenState();
}

class _AssetRegistrationScreenState extends State<AssetRegistrationScreen> {
  FirebaseFirestore assetData = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _assetIdController = TextEditingController();
  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _assetLocationController =
      TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();
  final Asset _asset = Asset();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Register Asset'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //asset ID
              TextFormField(
                controller: _assetIdController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Asset ID",
                ),
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
              ),
              const SizedBox(
                height: 18.0,
              ),
              //Enquires input
              TextFormField(
                controller: _assetTypeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Asset Type",
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _saveAsset();
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
    );
  }

  void _saveAsset() async {
    _asset.assetId = _assetIdController.text;
    _asset.assetName = _assetNameController.text;
    _asset.assetType = _assetTypeController.text;
    _asset.assetLocation = _assetLocationController.text;

    await FirebaseFirestore.instance
        .collection('assetData')
        .add(_asset.toJson());
  }
}
