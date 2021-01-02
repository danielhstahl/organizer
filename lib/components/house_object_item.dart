import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/house_object.dart';

class HouseObjectItem extends StatelessWidget {
  final HouseObject houseObject;

  const HouseObjectItem({Key key, @required this.houseObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FullNoteScreen(
                  tip: tip,
                ))),
        splashColor: Theme.of(context).accentColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            leading: Icon(Icons.description),
            title: Text(
              tip.tipName,
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(tip.shortTipText),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}
