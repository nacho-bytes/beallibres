import 'package:flutter/material.dart'
    show FilledButton, InputDecoration, TextFormField, Theme;
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        Column,
        EdgeInsets,
        Form,
        MainAxisAlignment,
        Padding,
        Row,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

import '../../presentation.dart' show SpacingThemeExtension;
import 'sign_up_bloc.dart' show SignUpBloc, SignUpSignUpEvent, SignUpState;

export 'sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => BlocProvider<SignUpBloc>(
        create: (final BuildContext context) => SignUpBloc(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (
            final BuildContext context,
            final SignUpState signUpState,
          ) =>
              Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  Theme.of(context).extension<SpacingThemeExtension>()!.large,
              vertical:
                  Theme.of(context).extension<SpacingThemeExtension>()!.medium,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing:
                  Theme.of(context).extension<SpacingThemeExtension>()!.large,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.hello,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Form(
                  key: signUpState.formKey,
                  child: Column(
                    spacing: Theme.of(context)
                        .extension<SpacingThemeExtension>()!
                        .medium,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.name,
                        ),
                        controller: signUpState.nameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                        ),
                        controller: signUpState.emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.confirmEmail,
                        ),
                        controller: signUpState.confirmEmailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                        ),
                        obscureText: true,
                        controller: signUpState.passwordController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.confirmPassword,
                        ),
                        obscureText: true,
                        controller: signUpState.confirmPasswordController,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Theme.of(context)
                      .extension<SpacingThemeExtension>()!
                      .medium,
                  children: <Widget>[
                    FilledButton(
                      onPressed: () => context.read<SignUpBloc>().add(
                            SignUpSignUpEvent(
                              name: signUpState.nameController.text,
                              email: signUpState.emailController.text,
                              password: signUpState.passwordController.text,
                            ),
                          ),
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
