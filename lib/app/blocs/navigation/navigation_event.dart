part of 'navigation_bloc.dart';

sealed class NavigationEvent {}

final class NavigationNewUserTypeEvent extends NavigationEvent {
  NavigationNewUserTypeEvent({
    required this.localizations,
    required this.type,
  });

  final AppLocalizations localizations;
  final UserType type;
}
