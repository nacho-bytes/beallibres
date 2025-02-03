import 'package:flutter/widgets.dart' show FormState, GlobalKey, TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

class SignUpState {
  SignUpState({
    final GlobalKey<FormState>? formKey,
    final TextEditingController? nameController,
    final TextEditingController? emailController,
    final TextEditingController? confirmEmailController,
    final TextEditingController? passwordController,
    final TextEditingController? confirmPasswordController,
  }) : formKey = formKey ?? GlobalKey<FormState>(),
        nameController = nameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        confirmEmailController = confirmEmailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        confirmPasswordController = confirmPasswordController ?? TextEditingController();

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController confirmEmailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignUpState copyWith({
    final GlobalKey<FormState>? formKey,
    final TextEditingController? nameController,
    final TextEditingController? emailController,
    final TextEditingController? confirmEmailController,
    final TextEditingController? passwordController,
    final TextEditingController? confirmPasswordController,
  }) => SignUpState(
    formKey: formKey ?? this.formKey,
    nameController: nameController ?? this.nameController,
    emailController: emailController ?? this.emailController,
    confirmEmailController: confirmEmailController ?? this.confirmEmailController,
    passwordController: passwordController ?? this.passwordController,
    confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
  );
}

sealed class SignUpEvent {}

final class SignUpSignUpEvent extends SignUpEvent {
  SignUpSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    final SignUpState? initialState,
  }) : super(initialState ?? SignUpState()) {
    on<SignUpSignUpEvent>(_onSingUp);
  }

  Future<void> _onSingUp(
    final SignUpSignUpEvent event,
    final Emitter<SignUpState> emit,
  ) async {
    print('Sing up with name: ${event.name}, email: ${event.email}, password: ${event.password}');
  }
}
