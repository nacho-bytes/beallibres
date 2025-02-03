part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    final User user = User.empty,
  }) : user = user;

  final User user;

  AuthenticationState copyWith({
    final User? user,
  }) => AuthenticationState(
    user: user ?? this.user,
  );

  @override
  List<Object> get props => <Object>[
    user,
  ];
}
