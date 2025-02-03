import 'package:flutter/material.dart' show Icons;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

import '../../../presentation/presentation.dart' show AdaptativeNavigationDestination;
import '../../app.dart' show $AdminRouteExtension, $HomeRouteExtension, $LoginRouteExtension, $ProfileRouteExtension, AdminRoute, HomeRoute, LoginRoute, ProfileRoute, UserType;

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    final NavigationState? initialState,
  }) : super(initialState ?? NavigationState()) {
    on<NavigationNewUserTypeEvent>(_onNewUserType);
  }

  Future<void> _onNewUserType(
    final NavigationNewUserTypeEvent event,
    final Emitter<NavigationState> emit,
  ) async {
    switch (event.type) {
      case UserType.anonymous:
        emit(
          state.copyWith(
            destinations: NavigationState.anonymousDestinations(event.localizations),
          ),
        );
      case UserType.user:
        emit(
          state.copyWith(
            destinations: NavigationState.userDestinations(event.localizations),
          ),
        );
      case UserType.admin:
        emit(
          state.copyWith(
            destinations: NavigationState.adminDestinations(event.localizations),
          ),
        );
    }
  }
}
