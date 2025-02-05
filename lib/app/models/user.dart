import 'package:equatable/equatable.dart' show Equatable;

enum UserType {
  none,
  anonymous,
  unabled,
  user,
  admin,
}

class User extends Equatable {
  const User({
    final String? uid,
    final String? email,
    final UserData? data,
  })  : uid = uid ?? '',
        email = email ?? '',
        data = data ?? UserData.empty;

  final String uid;
  final String email;
  final UserData data;

  UserType get userType {
    if (isEmpty) {
      return UserType.none;
    } else if (uid.isNotEmpty && email.isEmpty) {
      return UserType.anonymous;
    } else {
      return data.userType;
    }
  }

  static const User empty = User();

  bool get isEmpty => this == User.empty;

  User copyWith({
    final String? uid,
    final String? email,
    final UserData? data,
  }) => User(
    uid: uid ?? this.uid,
    email: email ?? this.email,
    data: data ?? this.data,
  );

  @override
  List<Object?> get props => <Object?>[uid, email, data];

  @override
  String toString() => 'User{'
    'uid: $uid'
    ', email: $email'
    ', data: $data'
  '}';
}

class UserData extends Equatable {
  const UserData({
    final String? name,
    final bool? isEnabled,
    final bool? isAdmin ,
  })  : name = name ?? '',
        isEnabled = isEnabled ?? false,
        isAdmin = isAdmin ?? false;

  UserData.fromMap(final Map<String, dynamic> data) : this(
    name: data[nameString] as String,
    isEnabled: data[isEnabledString] as bool,
    isAdmin: data[isAdminString] as bool,
  );

  static const String nameString = 'name';
  static const String isEnabledString = 'isEnabled';
  static const String isAdminString = 'isAdmin';

  final String name;
  final bool isEnabled;
  final bool isAdmin;

  static const UserData empty = UserData();

  UserType get userType {
    if (isAdmin) {
      return UserType.admin;
    } else if (isEnabled) {
      return UserType.user;
    } else {
      return UserType.unabled;
    }
  }

  UserData copyWith({
    final String? name,
    final bool? isEnabled,
    final bool? isAdmin,
  }) => UserData(
    name: name ?? this.name,
    isEnabled: isEnabled ?? this.isEnabled,
    isAdmin: isAdmin ?? this.isAdmin,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    nameString: name,
    isEnabledString: isEnabled,
    isAdminString: isAdmin,
  };

  @override
  List<Object?> get props => <Object?>[name, isEnabled, isAdmin];

  @override
  String toString() => 'UserData{'
    'name: $name'
    ', isEnabled: $isEnabled'
    ', isAdmin: $isAdmin'
  '}';
}
