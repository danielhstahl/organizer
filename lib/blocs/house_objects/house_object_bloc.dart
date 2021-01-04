import 'house_object_events.dart';
import 'house_object_state.dart';
import '../../services/firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class HouseObjectBloc extends Bloc<HouseObjectEvents, HouseObjectState> {
  final HouseObjectRepository _houseObjectRepository;
  StreamSubscription _houseObjectSubscription;

  HouseObjectBloc({@required HouseObjectRepository houseObjectRepository})
      : assert(houseObjectRepository != null),
        _houseObjectRepository = houseObjectRepository,
        super(HouseObjectLoadInProgress());

  @override
  Stream<HouseObjectState> mapEventToState(HouseObjectEvents event) async* {
    if (event is HouseObjectLoad) {
      yield* _mapLoadToState();
    } else if (event is HouseObjectAdded) {
      yield* _mapAddObjectToState(event);
    } else if (event is HouseObjectUpdated) {
      yield* _mapUpdateObjectToState(event);
    } else if (event is HouseObjectDeleted) {
      yield* _mapDeleteObjectToState(event);
    } else if (event is HouseObjectLoaded) {
      yield* _mapLoadObjectsToState(event);
    }
  }

  Stream<HouseObjectState> _mapLoadObjectsToState(
      HouseObjectLoaded event) async* {
    yield HouseObjectLoadSuccess(event.houseObjects);
  }

  Stream<HouseObjectState> _mapLoadToState() async* {
    _houseObjectSubscription?.cancel();
    _houseObjectSubscription = _houseObjectRepository.objects().listen(
          (houseObjects) => add(HouseObjectLoaded(houseObjects)),
        );
  }

  Stream<HouseObjectState> _mapAddObjectToState(HouseObjectAdded event) async* {
    _houseObjectRepository.addNewObject(event.houseObject);
  }

  Stream<HouseObjectState> _mapUpdateObjectToState(
      HouseObjectUpdated event) async* {
    _houseObjectRepository.updateObject(event.houseObject);
  }

  Stream<HouseObjectState> _mapDeleteObjectToState(
      HouseObjectDeleted event) async* {
    _houseObjectRepository.deleteObject(event.houseObject);
  }

  @override
  Future<void> close() {
    _houseObjectSubscription?.cancel();
    return super.close();
  }
}
