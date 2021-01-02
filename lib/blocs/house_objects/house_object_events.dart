import '../../models/house_object.dart';

abstract class HouseObjectEvent {}

class HouseObjectDataEvent extends HouseObjectEvent {
  final List<HouseObject> data;

  HouseObjectDataEvent(this.data);
}
