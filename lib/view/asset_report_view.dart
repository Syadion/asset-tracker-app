import 'package:assettrackerapp/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnquiriesScreen extends StatefulWidget {
  const EnquiriesScreen({Key? key}) : super(key: key);

  @override
  State<EnquiriesScreen> createState() => _EnquiriesScreenState();
}

class _EnquiriesScreenState extends State<EnquiriesScreen> {
  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _assetLocationController =
      TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();

  final TextEditingController _reportController = TextEditingController();
  final Report _report = Report();

  CollectionReference ref = FirebaseFirestore.instance.collection('assetData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Report Asset'),
        ),
        body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var doc = snapshot.data!.docs[index];
                  return Center(
                      child: Column(
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _assetNameController.text = doc['asset name'];
                            _assetLocationController.text =
                                doc['asset location'];
                            _assetTypeController.text = doc['asset type'];
                          },
                        ),
                        title: Text(doc['asset name']),
                        subtitle: Text(
                            '${doc['asset location']} (${doc['asset type']})'),
                      )
                    ],
                  ));
                }),
              );
            } else {
              return const Text('');
            }
          },
        ));
  }

  void _saveReport() async {
    _report.report = _reportController.text;
    _report.reportDate = DateTime.now();

    await FirebaseFirestore.instance
        .collection('reports')
        .add(_report.toJson());
  }
}
