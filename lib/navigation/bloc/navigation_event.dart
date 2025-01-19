part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {
  const NavigationEvent();
}

class NavigationIndexChanged extends NavigationEvent {
  const NavigationIndexChanged(this.newIndex);
  final int newIndex;
}
