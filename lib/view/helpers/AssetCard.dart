import 'package:assettrackerapp/model/asset.dart';
import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final Asset _asset;

  const AssetCard(this._asset, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(_asset.assetName),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(_asset.assetLocation),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
