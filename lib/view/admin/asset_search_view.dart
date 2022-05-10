import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminAssetSearchScreen extends StatefulWidget {
  const AdminAssetSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminAssetSearchScreen> createState() => _AdminAssetSearchScreenState();
}

class _AdminAssetSearchScreenState extends State<AdminAssetSearchScreen> {
  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _assetLocationController =
      TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('assetData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Search & Update Asset'),
        ),
        body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var doc = snapshot.data!.docs[index];
                  return ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _assetNameController.text = doc['asset name'];
                        _assetLocationController.text = doc['asset location'];
                        _assetTypeController.text = doc['asset type'];

                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      children: <Widget>[
                                        _buildTextField(
                                            _assetNameController, 'Asset Name'),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            _assetLocationController,
                                            'Asset Location'),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            _assetTypeController, 'Asset Name'),
                                        const SizedBox(height: 20),
                                        MaterialButton(
                                          color: const Color(0xFF0069FE),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Text(
                                              'Update asset details'),
                                          onPressed: () async {
                                            snapshot.data!.docs[index].reference
                                                .update({
                                              'asset name': _assetNameController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                              'asset location':
                                                  _assetLocationController.text
                                                      .trim()
                                                      .toString(),
                                              'asset type': _assetTypeController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                            }).whenComplete(() =>
                                                    Navigator.pop(context));
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        MaterialButton(
                                          color: const Color(0xFF0069FE),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Text('Delete asset'),
                                          onPressed: () async {
                                            snapshot.data!.docs[index].reference
                                                .delete()
                                                .whenComplete(() =>
                                                    Navigator.pop(context));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                    ),
                    title: Text(doc['asset name']),
                    subtitle:
                        Text('${doc['asset location']} (${doc['asset type']})'),
                  );
                }),
              );
            } else {
              return const Text('');
            }
          },
        ));
  }
}
