import 'package:flutter/material.dart'
    show BuildContext, CircularProgressIndicator, Column, EdgeInsets, FilledButton, InputDecoration, MainAxisAlignment, Padding, Row, ScaffoldMessenger, SnackBar, StatelessWidget, Text, TextField, Theme, Widget;
import 'package:flutter/widgets.dart' show Align, Alignment, MainAxisSize, TextInputType;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener, BlocProvider, ReadContext, SelectContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:formz/formz.dart' show FormzSubmissionStatusX;
import 'package:gap/gap.dart' show Gap;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../app/app.dart' show $HomeRouteExtension, $SignUpRouteExtension, EmailValidationError, HomeRoute, SignUpRoute;
import '../../../app/models/form_inputs/password.dart';
import '../../../domain/domain.dart' show AuthenticationRepository;
import '../../presentation.dart' show SpacingThemeExtension;
import 'log_in_bloc.dart' show LogInBloc, LogInEmailChanged, LogInPasswordChanged, LogInState, LogInWithCredentials;

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => BlocProvider<LogInBloc>(
    create: (final BuildContext context) => LogInBloc(
      authenticationRepository: context.read<AuthenticationRepository>(),
    ),
    child: BlocListener<LogInBloc, LogInState>(
      listener: (final BuildContext context, final LogInState state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? AppLocalizations.of(context)!.logInError),
              ),
            );
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.logInSuccess),
              ),
            );
          context.go(const HomeRoute().location);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              Theme.of(context).extension<SpacingThemeExtension>()!.large,
          vertical: Theme.of(context)
              .extension<SpacingThemeExtension>()!
              .medium,
        ),
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing:
                Theme.of(context).extension<SpacingThemeExtension>()!.large,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.helloAgain,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gap(Theme.of(context).extension<SpacingThemeExtension>()!.small),
              _EmailInput(),
              Gap(Theme.of(context).extension<SpacingThemeExtension>()!.small),
              _PasswordInput(),
              Gap(Theme.of(context).extension<SpacingThemeExtension>()!.small),
              _LogInActions(),
            ],
          ),
        ),
      ),
    ),
  );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final EmailValidationError? displayError = context.select(
      (final LogInBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      onChanged: (final String email) => context.read<LogInBloc>().add(
        LogInEmailChanged(email),
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,
        helperText: '',
        errorText: displayError != null
          ? AppLocalizations.of(context)!.invalidEmail
          : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final PasswordValidationError? displayError = context.select(
      (final LogInBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      onChanged: (final String password) =>
          context.read<LogInBloc>().add(LogInPasswordChanged(password)),
      obscureText: true,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,
        helperText: '',
        errorText: displayError != null
          ? AppLocalizations.of(context)!.invalidPassword
          : null,
      ),
    );
  }
}

class _LogInActions extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: Theme.of(context)
        .extension<SpacingThemeExtension>()!
        .medium,
    children: <Widget>[
      _LogInButton(),
      _SingUpButton(),
    ],
  );
}

class _LogInButton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final bool isInProgress = context.select(
      (final LogInBloc bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) {
      return const CircularProgressIndicator();
    }

    final bool isValid = context.select(
      (final LogInBloc bloc) => bloc.state.isValid,
    );

    return FilledButton(
      onPressed: isValid
        ? () => context.read<LogInBloc>().add(LogInWithCredentials(context))
        : null,
      child: Text(
        AppLocalizations.of(context)!.login,
      ),
    );
  }
}

class _SingUpButton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => FilledButton.tonal(
    onPressed: () => context.go(const SignUpRoute().location),
    child: Text(
      AppLocalizations.of(context)!.signUp,
    ),
  );
}
