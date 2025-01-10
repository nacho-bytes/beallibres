import 'package:flutter/material.dart' show Icons;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../adaptative_navigation_trail.dart' show AdaptativeNavigationDestination;
import 'routes.dart';

class RouterState {
  const RouterState({
    this.destinations = const <AdaptativeNavigationDestination>[],
  });

  final List<AdaptativeNavigationDestination> destinations;

  RouterState copyWith({
    final List<AdaptativeNavigationDestination>? destinations,
  }) => RouterState(
    destinations: destinations ?? this.destinations,
  );
}

sealed class RouterEvent {}

final class AddAdminDestinationEvent extends RouterEvent {}

final class RemoveAdminDestinationEvent extends RouterEvent {}

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc({
    final RouterState? initialState,
  }) : super(initialState ?? const RouterState()) {
    on<AddAdminDestinationEvent>(_onAddAdminDestinationEvent);
    on<RemoveAdminDestinationEvent>(_onRemoveAdminDestinationEvent);
  }

  void _onAddAdminDestinationEvent(
    final AddAdminDestinationEvent event,
    final Emitter<RouterState> emit,
  ) {
    if (state.destinations.any(
      (final AdaptativeNavigationDestination destination) =>
        destination.location == const AdminRoute().location,
    )) {
      return;
    }

    emit(
      state.copyWith(
        destinations: List<AdaptativeNavigationDestination>.from(
          state.destinations
            ..add(
              AdaptativeNavigationDestination(
                title: 'Admin',
                icon: Icons.admin_panel_settings,
                location: const AdminRoute().location,
              ),
            ),
        ),
      ),
    );
  }

  void _onRemoveAdminDestinationEvent(
    final RemoveAdminDestinationEvent event,
    final Emitter<RouterState> emit,
  ) {
    emit(
      state.copyWith(
        destinations: List<AdaptativeNavigationDestination>.from(
          state.destinations
            ..removeWhere(
              (final AdaptativeNavigationDestination destination) =>
                destination.location == const AdminRoute().location,
            ),
        ),
      ),
    );
  }
}
