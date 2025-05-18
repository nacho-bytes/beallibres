part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.user,
  });

  final User? user;

  AuthenticationState copyWith({
    final User? user,
  }) =>
      AuthenticationState(
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => <Object?>[
        user,
      ];

  @override
  String toString() => 'AuthenticationState{'
      'user: $user'
      '}';
}
