import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationIndexChanged>(_onNavigationIndexChanged);
  }

  void _onNavigationIndexChanged(
    NavigationIndexChanged event,
    Emitter<NavigationState> emit,
  ) {
    emit(NavigationState(screenIndex: event.newIndex));
  }
}
