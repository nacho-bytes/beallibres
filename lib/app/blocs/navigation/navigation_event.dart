part of 'navigation_bloc.dart';

sealed class NavigationEvent {}

final class NavigationNewUserTypeEvent extends NavigationEvent {
  NavigationNewUserTypeEvent({
    required this.type,
  });

  final UserType? type;
}
