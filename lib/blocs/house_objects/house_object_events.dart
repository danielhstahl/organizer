import '../../models/house_object.dart';

import 'package:equatable/equatable.dart';

abstract class HouseObjectEvents extends Equatable {
  const HouseObjectEvents();

  @override
  List<Object> get props => [];
}

//class HouseObjectLoadSuccess extends HouseObjectEvents {}

class HouseObjectLoad extends HouseObjectEvents {}

class HouseObjectAdded extends HouseObjectEvents {
  final HouseObject houseObject;

  const HouseObjectAdded(this.houseObject);

  @override
  List<Object> get props => [houseObject];

  @override
  String toString() => 'HouseObjectAdded { houseObject: $houseObject }';
}

class HouseObjectLoaded extends HouseObjectEvents {
  final List<HouseObject> houseObjects;

  const HouseObjectLoaded(this.houseObjects);

  @override
  List<Object> get props => [houseObjects];

  @override
  String toString() => 'HouseObjectLoad { houseObjects }';
}

class HouseObjectUpdated extends HouseObjectEvents {
  final HouseObject houseObject;

  const HouseObjectUpdated(this.houseObject);

  @override
  List<Object> get props => [houseObject];

  @override
  String toString() => 'HouseObjectUpdated { houseObject: $houseObject }';
}

class HouseObjectDeleted extends HouseObjectEvents {
  final HouseObject houseObject;

  const HouseObjectDeleted(this.houseObject);

  @override
  List<Object> get props => [houseObject];

  @override
  String toString() => 'HouseObjectDeleted { houseObject: $houseObject }';
}
