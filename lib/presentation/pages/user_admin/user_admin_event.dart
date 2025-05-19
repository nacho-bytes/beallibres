part of 'user_admin_bloc.dart';

sealed class UserAdminEvent {
  const UserAdminEvent();
}

final class UserAdminFetchUsersEvent extends UserAdminEvent {
  const UserAdminFetchUsersEvent();
}
