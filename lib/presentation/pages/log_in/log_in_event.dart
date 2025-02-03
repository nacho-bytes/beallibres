part of 'log_in_bloc.dart';

sealed class LogInEvent {
  const LogInEvent();
}

final class LogInEmailChanged extends LogInEvent {
  const LogInEmailChanged(this.email);

  final String email;
}

final class LogInPasswordChanged extends LogInEvent {
  const LogInPasswordChanged(this.password);

  final String password;
}

final class LogInWithCredentials extends LogInEvent {
  const LogInWithCredentials(this.buildContext);

  final BuildContext buildContext;
}
