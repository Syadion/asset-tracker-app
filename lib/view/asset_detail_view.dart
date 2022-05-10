import 'package:flutter/material.dart';

class AssetDetailScreen extends StatefulWidget {
  const AssetDetailScreen({Key? key}) : super(key: key);

  @override
  State<AssetDetailScreen> createState() => _AssetDetailScreenState();
}

//final _formKey = GlobalKey<FormState>();

final TextEditingController _assetIdController = TextEditingController();
final TextEditingController _assetNameController = TextEditingController();
final TextEditingController _assetLocationController = TextEditingController();
final TextEditingController _assetTypeController = TextEditingController();

class _AssetDetailScreenState extends State<AssetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Asset Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _assetIdController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Name",
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
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
                TextFormField(
                  controller: _assetLocationController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Name",
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                TextFormField(
                  controller: _assetTypeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Asset Name",
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
