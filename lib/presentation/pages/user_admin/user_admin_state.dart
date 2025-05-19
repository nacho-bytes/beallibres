part of 'user_admin_bloc.dart';

final class UserAdminState extends Equatable {
  const UserAdminState({
    required this.userDataSource,
  });

  final UserDataSource userDataSource;

  @override
  List<Object?> get props => <Object?>[
        userDataSource,
      ];
}

class UserDataSource extends DataGridSource {
  UserDataSource({final List<User>? users}) {
    updateUsers(
      users ?? <User>[],
    );
  }

  static const String nameColumn = 'name';
  static const String emailColumn = 'email';
  static const String isEnabledColumn = 'isEnabled';
  static const String isAdminColumn = 'isAdmin';
  static const String actionsColumn = 'actions';

  late List<User> _users;
  late List<DataGridRow> _dataGridRows;

  void updateUsers(final List<User> users) {
    _users = users;
    _updateDataRows();
  }

  void _updateDataRows() {
    _dataGridRows = _users
        .map<DataGridRow>(
          (
            final User user,
          ) =>
              DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<String>(
                columnName: nameColumn,
                value: user.data?.name,
              ),
              DataGridCell<String>(
                columnName: emailColumn,
                value: user.email,
              ),
              DataGridCell<bool>(
                columnName: isEnabledColumn,
                value: user.data?.isEnabled,
              ),
              DataGridCell<bool>(
                columnName: isAdminColumn,
                value: user.data?.isAdmin,
              ),
              DataGridCell<User>(
                columnName: actionsColumn,
                value: user,
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(
    final DataGridRow row,
  ) =>
      DataGridRowAdapter(
        cells: row.getCells().map<Widget>((
          final DataGridCell dataGridCell,
        ) {
          switch (dataGridCell.columnName) {
            case actionsColumn:
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ],
              );
            default:
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(dataGridCell.value.toString()),
              );
          }
        }).toList(),
      );
}
