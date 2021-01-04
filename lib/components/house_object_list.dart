import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'house_object_item.dart';
import '../models/house_object.dart';

class HouseObjectList extends StatelessWidget {
  final List<HouseObject> houseObjects;

  const HouseObjectList({Key key, @required this.houseObjects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: houseObjects
            .map((item) => HouseObjectItem(houseObject: item))
            .toList());
  }
}
