part of 'log_in_bloc.dart';

final class LogInState extends Equatable {
  const LogInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      <Object?>[email, password, status, isValid, errorMessage];

  LogInState copyWith({
    final Email? email,
    final Password? password,
    final FormzSubmissionStatus? status,
    final bool? isValid,
    final String? errorMessage,
  }) =>
      LogInState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
