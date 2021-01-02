import '../../models/house_object.dart';

abstract class HouseObjectState {}

class HouseObjectLoading extends HouseObjectState {}

class HouseObjectData extends HouseObjectState {
  final List<HouseObject> data;

  HouseObjectData(this.data);
}
