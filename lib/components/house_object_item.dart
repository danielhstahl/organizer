import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/house_object.dart';

class HouseObjectItem extends StatelessWidget {
  final HouseObject houseObject;

  const HouseObjectItem({Key key, @required this.houseObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(houseObject.objectLabel),
      subtitle: Text(houseObject.objectLocation),
    );
  }
}
