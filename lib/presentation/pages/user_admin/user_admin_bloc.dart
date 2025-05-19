import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart' show ElevatedButton;
import 'package:flutter/widgets.dart'
    show Alignment, Container, EdgeInsets, MainAxisSize, Row, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:syncfusion_flutter_datagrid/datagrid.dart'
    show DataGridCell, DataGridRow, DataGridRowAdapter, DataGridSource;

import '../../../app/models/models.dart' show User;

part 'user_admin_state.dart';
part 'user_admin_event.dart';

class UserAdminBloc extends Bloc<UserAdminEvent, UserAdminState> {
  UserAdminBloc({
    final List<User>? initialUsers,
  }) : super(
          UserAdminState(
            userDataSource: UserDataSource(
              users: initialUsers,
            ),
          ),
        ) {
    on<UserAdminFetchUsersEvent>(_onUserAdminFetchUsersEvent);
  }

  void _onUserAdminFetchUsersEvent(
    final UserAdminFetchUsersEvent event,
    final Emitter<UserAdminState> emit,
  ) {}
}
