import '../entities/house_object_entity.dart';
import '../models/house_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

abstract class HouseObjectRepository {
  Stream<List<HouseObject>> objects();
  Future<void> addNewObject(HouseObject object);
  Future<void> deleteObject(HouseObject object);
  Future<void> updateObject(HouseObject object);
}

class HouseObjectRepositoryFirestore extends HouseObjectRepository {
  final houseObjectConnection =
      FirebaseFirestore.instance.collection('house_objects');

  @override
  Future<void> addNewObject(HouseObject object) {
    houseObjectConnection.add(object.toEntity().toDocument());
  }

  @override
  Future<void> deleteObject(HouseObject object) {
    houseObjectConnection.doc(object.id).delete();
  }

  @override
  Future<void> updateObject(HouseObject object) {
    houseObjectConnection.doc(object.id).update(object.toEntity().toDocument());
  }

  @override
  Stream<List<HouseObject>> objects() {
    return houseObjectConnection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              HouseObject.fromEntity(HouseObjectEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
