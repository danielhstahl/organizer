import '../../models/house_object.dart';

import 'package:equatable/equatable.dart';

abstract class HouseObjectState extends Equatable {
  const HouseObjectState();

  @override
  List<Object> get props => [];
}

class HouseObjectLoadFailure extends HouseObjectState {}

class HouseObjectLoadInProgress extends HouseObjectState {}

class HouseObjectLoadSuccess extends HouseObjectState {
  final List<HouseObject> data;
  const HouseObjectLoadSuccess([this.data = const []]);
}
