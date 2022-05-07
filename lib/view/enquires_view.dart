import 'package:assettrackerapp/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnquiriesScreen extends StatefulWidget {
  const EnquiriesScreen({Key? key}) : super(key: key);

  @override
  State<EnquiriesScreen> createState() => _EnquiriesScreenState();
}

class _EnquiriesScreenState extends State<EnquiriesScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reportController = TextEditingController();
  final Report _report = Report();

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
                maxLines: null,
                controller: _reportController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Report issue here",
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
                    _saveReport();
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

  void _saveReport() async {
    _report.report = _reportController.text;
    _report.reportDate = DateTime.now();

    await FirebaseFirestore.instance
        .collection('reports')
        .add(_report.toJson());
  }
}
