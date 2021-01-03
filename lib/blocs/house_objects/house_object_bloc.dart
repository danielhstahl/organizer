import 'package:organizer/models/house_object.dart';

import 'house_object_events.dart';
import 'house_object_state.dart';
import '../../services/firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HouseObjectBloc extends Bloc<HouseObjectEvent, HouseObjectState> {
  final HouseObjectRepository repository;

  HouseObjectBloc({@required this.repository}) : super(HouseObjectLoading()) {
    repository.objects().listen((data) => add(HouseObjectDataEvent(data)));
  }
  @override
  HouseObjectState get initialState => HouseObjectLoading();

  @override
  Stream<HouseObjectState> mapEventToState(HouseObjectEvent event) async* {
    if (event is HouseObjectDataEvent) {
      yield HouseObjectData(event.data);
    }
  }

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
