import 'package:meta/meta.dart';
import '../entities/house_object_entity.dart';

@immutable
class HouseObject {
  final String id;
  final String objectLabel;
  final String objectLocation;
  HouseObject(this.id, this.objectLabel, this.objectLocation);
  HouseObject copyWith({String id, String objectLabel, String objectLocation}) {
    return HouseObject(
      id,
      objectLabel,
      objectLocation,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ objectLabel.hashCode ^ objectLocation.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseObject &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          objectLabel == other.objectLabel &&
          objectLocation == other.objectLocation;

  @override
  String toString() {
    return 'HouseObject { id: $id, objectLabel: $objectLabel, objectLocation: $objectLocation}';
  }

  HouseObjectEntity toEntity() {
    return HouseObjectEntity(id, objectLabel, objectLocation);
  }

  static HouseObject fromEntity(HouseObjectEntity entity) {
    return HouseObject(
      entity.id,
      entity.objectLabel,
      entity.objectLocation,
    );
  }
}
