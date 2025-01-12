import 'package:flutter/material.dart'
    show AlertDialog,
    BuildContext,
    Column,
    EdgeInsets,
    Expanded,
    FilledButton,
    Form,
    Icon,
    IconButton,
    Icons,
    InputDecoration,
    MainAxisAlignment,
    Padding,
    Row,
    StatelessWidget,
    Text,
    TextAlign,
    TextFormField,
    Theme,
    Widget,
    showDialog;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../theme/spacing_theme_extension.dart' show SpacingThemeExtension;
import 'add_user_bloc.dart' show AddUserBloc, AddUserState;

class AddUserPage extends StatelessWidget {
  const AddUserPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => BlocProvider<AddUserBloc>(
        create: (final BuildContext context) => AddUserBloc(),
        child: BlocBuilder<AddUserBloc, AddUserState>(
          builder: (
            final BuildContext context,
            final AddUserState adminState,
          ) =>
              Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  Theme.of(context).extension<SpacingThemeExtension>()!.large,
              vertical:
                  Theme.of(context).extension<SpacingThemeExtension>()!.medium,
            ),
            child: Form(
              key: adminState.formKey,
              child: Column(
                spacing:
                    Theme.of(context).extension<SpacingThemeExtension>()!.large,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: context.pop,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.addUser,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.name,
                        ),
                        controller: adminState.nameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.surname,
                        ),
                        controller: adminState.surnameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                        ),
                        controller: adminState.emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.confirmEmail,
                        ),
                        controller: adminState.confirmEmailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                        ),
                        controller: adminState.passwordController,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FilledButton(
                        onPressed: () async => showDialog(
                          context: context,
                          builder: (
                            final BuildContext context,
                          ) =>
                              AlertDialog(
                            title: Text(
                              'name: ${adminState.nameController.text}\n'
                              'surname: ${adminState.surnameController.text}\n'
                              'email: ${adminState.emailController.text}\n'
                              'confirmEmail: ${adminState.confirmEmailController.text}\n'
                              'password: ${adminState.passwordController.text}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            actions: <Widget>[
                              FilledButton(
                                onPressed: context.pop,
                                child: const Text(
                                  'Ok',
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.addUser,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
