import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:formz/formz.dart' show Formz, FormzInput, FormzSubmissionStatus;

import '../../../app/app.dart' show Email, Password;
import '../../../domain/domain.dart' show AuthenticationRepository, LogInWithEmailAndPasswordFailure;

part 'log_in_state.dart';
part 'log_in_event.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc({
    required final AuthenticationRepository authenticationRepository,
  }) :  _authenticationRepository = authenticationRepository,
        super(const LogInState()) {
    on<LogInEmailChanged>(_onEmailChanged);
    on<LogInPasswordChanged>(_onPasswordChanged);
    on<LogInWithCredentials>(_onLogInWithCredentials);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    final LogInEmailChanged event,
    final Emitter<LogInState> emit,
  ) {
    final Email email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput>[email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    final LogInPasswordChanged event,
    final Emitter<LogInState> emit,
  ) {
    final Password password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(<FormzInput>[state.email, password]),
      ),
    );
  }

  Future<void> _onLogInWithCredentials(
    final LogInWithCredentials event,
    final Emitter<LogInState> emit,
  ) async {
    if (!state.isValid) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.getErrorMessage(
            AppLocalizations.of(event.buildContext)!,
          ),
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
