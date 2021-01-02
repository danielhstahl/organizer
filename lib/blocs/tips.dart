import '../events/tip_events.dart';
import '../state/tip_state.dart';
import '../repositories/tips.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TipBloc extends Bloc<TipEvents, TipState> {
  final TipRepository repository;

  TipBloc({@required this.repository}) : super(TipLoadingState()) {
    repository.tips().listen((data) => add(HasDataEvent(data)));
  }
  @override
  TipState get initialState => TipLoadingState();

  @override
  Stream<TipState> mapEventToState(TipEvents event) async* {
    if (event is HasDataEvent) {
      yield TipHasDataState(event.data);
    }
  }

  @override
  Future<Function> close() {
    repository.dispose();
    return super.close();
  }
}
