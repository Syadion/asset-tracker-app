import 'package:assettrackerapp/view/admin/asset_search_view.dart';
import 'package:assettrackerapp/view/asset_registration_view.dart';
import 'package:assettrackerapp/view/asset_scan_view.dart';
import 'package:assettrackerapp/view/asset_search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({Key? key}) : super(key: key);

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

final user = FirebaseAuth.instance.currentUser!;

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('user:' + user.email!),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          children: [
            //Search asset tile
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssetSearchScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 65, 64, 64),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Search Or Report Asset',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            //Scan Asset Tile
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssetScanScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 65, 64, 64),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Scan Asset',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            //Asset registration tile
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssetRegistrationScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 65, 64, 64),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Register Asset',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            //Asset Search & Update
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminAssetSearchScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 65, 64, 64),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Search & Update Asset',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
        ),
      ),
    );
  }
}
