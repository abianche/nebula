part of 'navigation_bloc.dart';

@immutable
final class NavigationState extends Equatable {
  const NavigationState({required this.screenIndex});
  final int screenIndex;

  @override
  List<Object> get props => [screenIndex];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(screenIndex: 0);
}
