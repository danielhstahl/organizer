import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'house_object_item.dart';
import '../models/house_object.dart';

class HouseSelection extends StatelessWidget {
  final List<String> houseSelections;

  const HouseSelection({Key key, @required this.houseSelections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: houseSelections
            .map((item) => ListTile(
                  title: Text(item),
                  subtitle: Text(item),
                ))
            .toList());
  }
}
