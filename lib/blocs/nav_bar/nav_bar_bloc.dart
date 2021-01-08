import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class NavBarCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  NavBarCubit() : super(0);

  /// Add 1 to the current state.
  void set(int index) => emit(index);

  /// Subtract 1 from the current state.
  //void items() => emit(1);
}
