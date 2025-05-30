import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../domain/domain.dart'
    show AuthenticationRepository, UsersRepository;
import '../../app.dart' show User, UserData, UserType;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required final AuthenticationRepository authenticationRepository,
    required final UsersRepository usersRepository,
  })  : _authenticationRepository = authenticationRepository,
        _usersRepository = usersRepository,
        super(const AuthenticationState()) {
    on<AuthenticationSubscriptionRequested>(_onUserSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;

  Future<void> _onUserSubscriptionRequested(
    final AuthenticationSubscriptionRequested event,
    final Emitter<AuthenticationState> emit,
  ) =>
      emit.onEach(
        _authenticationRepository.user,
        onData: (final Future<User?> userFuture) async {
          final User? user = await userFuture;
          if (user == null) {
            emit(const AuthenticationState());
            return;
          }
          if (user.userType == UserType.anonymous) {
            emit(
              AuthenticationState(
                user: user,
              ),
            );
            return;
          }

          final UserData data =
              await _usersRepository.fetchUserData(uid: user.uid);
          emit(
            AuthenticationState(
              user: user.copyWith(data: data),
            ),
          );
        },
        onError: addError,
      );

  Future<void> _onLogoutPressed(
    final AuthenticationLogoutPressed event,
    final Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.logOut();
    await _authenticationRepository.logInAnonymously();
  }
}
