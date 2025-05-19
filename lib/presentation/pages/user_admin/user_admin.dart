import 'package:flutter/widgets.dart'
    show
        Alignment,
        BuildContext,
        Container,
        EdgeInsets,
        SizedBox,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:syncfusion_flutter_datagrid/datagrid.dart'
    show GridColumn, SfDataGrid;

import '../../../app/models/models.dart' show User, UserData;
import '../../presentation.dart' show BackButtonPage;
import 'user_admin_bloc.dart'
    show UserAdminBloc, UserAdminState, UserDataSource;

class UserAdminPage extends StatelessWidget {
  const UserAdminPage({
    super.key,
  });

  @override
  Widget build(
    final BuildContext context,
  ) =>
      BlocProvider<UserAdminBloc>(
        create: (
          final BuildContext context,
        ) =>
            UserAdminBloc(
          initialUsers: List<User>.generate(
            50,
            (
              final int index,
            ) =>
                User(
              uid: '$index',
              email: 'test$index@test.com',
              data: UserData(
                name: 'Test $index',
                isEnabled: true,
                isAdmin: true,
              ),
            ),
          ),
        ),
        child: BlocBuilder<UserAdminBloc, UserAdminState>(
          builder: (
            final BuildContext context,
            final UserAdminState state,
          ) =>
              BackButtonPage(
            child: SfDataGrid(
              source: state.userDataSource,
              columns: <GridColumn>[
                GridColumn(
                  columnName: UserDataSource.nameColumn,
                  label: _Label(
                    label: AppLocalizations.of(context)!.name,
                  ),
                ),
                GridColumn(
                  columnName: UserDataSource.emailColumn,
                  label: _Label(
                    label: AppLocalizations.of(context)!.email,
                  ),
                  width: 200,
                ),
                GridColumn(
                  columnName: UserDataSource.isEnabledColumn,
                  label: _Label(
                    label: AppLocalizations.of(context)!.enabled,
                  ),
                ),
                GridColumn(
                  columnName: UserDataSource.isAdminColumn,
                  label: _Label(
                    label: AppLocalizations.of(context)!.admin,
                  ),
                ),
                GridColumn(
                  columnName: UserDataSource.actionsColumn,
                  label: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
}

class _Label extends StatelessWidget {
  const _Label({required this.label});

  final String label;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
        ),
      );
}
