import '../models/house_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

abstract class HouseObjectRepository {
  Stream<List<HouseObject>> objects();
  void dispose();
  void refresh();
}

class HouseObjectRepositoryFirestore extends HouseObjectRepository {
  final _loadedData = StreamController<List<HouseObject>>();

  final List<HouseObject> _cache = [];

  @override
  void dispose() {
    _loadedData.close();
  }

  @override
  void refresh() {
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('house_objects')
          .snapshots()
          .listen((techniques) {
        _cache.clear();
        techniques.docs.forEach((houseObject) {
          final doc = houseObject.data();
          _cache.add(HouseObject(doc["objectLabel"], doc["objectLocation"]));
        });

        _loadedData.add(_cache);
      });
    }
  }

  @override
  Stream<List<HouseObject>> objects() => _loadedData.stream;
}
