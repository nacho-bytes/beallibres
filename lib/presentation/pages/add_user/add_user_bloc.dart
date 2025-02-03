import 'package:flutter/widgets.dart' show FormState, GlobalKey, TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

class AddUserState {
  AddUserState({
    final GlobalKey<FormState>? formKey,
    final TextEditingController? nameController,
    final TextEditingController? surnameController,
    final TextEditingController? emailController,
    final TextEditingController? confirmEmailController,
    final TextEditingController? passwordController,
  }) : formKey = formKey ?? GlobalKey<FormState>(),
       nameController = nameController ?? TextEditingController(),
       surnameController = surnameController ?? TextEditingController(),
       emailController = emailController ?? TextEditingController(),
       confirmEmailController = confirmEmailController ?? TextEditingController(),
       passwordController = passwordController ?? TextEditingController();

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController confirmEmailController;
  final TextEditingController passwordController;

  AddUserState copyWith({
    final GlobalKey<FormState>? formKey,
    final TextEditingController? nameController,
    final TextEditingController? surnameController,
    final TextEditingController? emailController,
    final TextEditingController? confirmEmailController,
    final TextEditingController? passwordController,
  }) => AddUserState(
    formKey: formKey ?? this.formKey,
    nameController: nameController ?? this.nameController,
    surnameController: surnameController ?? this.surnameController,
    emailController: emailController ?? this.emailController,
    confirmEmailController: confirmEmailController ?? this.confirmEmailController,
    passwordController: passwordController ?? this.passwordController,
  );
}

sealed class AddUserEvent {}

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc({
    final AddUserState? initialState,
  }) : super(initialState ?? AddUserState());
}
