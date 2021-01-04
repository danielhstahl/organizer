import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HouseObjectEntity extends Equatable {
  final String objectLabel;
  final String objectLocation;
  final String id;
  const HouseObjectEntity(this.id, this.objectLabel, this.objectLocation);

  Map<String, Object> toJson() {
    return {
      "objectLabel": objectLabel,
      "objectLocation": objectLocation,
      "id": id
    };
  }

  @override
  List<Object> get props => [id, objectLabel, objectLocation];

  @override
  String toString() {
    return 'HouseObjectEntity { id: $id, objectLabel: $objectLabel, objectLocation: $objectLocation}';
  }

  static HouseObjectEntity fromJson(Map<String, String> json) {
    return HouseObjectEntity(
      json["id"] as String,
      json["objectLabel"] as String,
      json["objectLocation"] as String,
    );
  }

  static HouseObjectEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    return HouseObjectEntity(
      snap.id,
      data['objectLabel'],
      data['objectLocation'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "objectLabel": objectLabel,
      "objectLocation": objectLocation,
    };
  }
}
