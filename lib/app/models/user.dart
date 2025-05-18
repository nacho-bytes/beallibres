import 'package:equatable/equatable.dart' show Equatable;
import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;

part 'user.g.dart';

enum UserType {
  anonymous,
  unabled,
  user,
  admin,
}

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    this.data,
  });

  final String uid;
  final String email;
  final UserData? data;

  UserType get userType {
    if (uid.isNotEmpty && email.isEmpty) {
      return UserType.anonymous;
    }
    if (data == null) {
      throw Exception('User not anonymous but data is null');
    }
    return data!.userType;
  }

  User copyWith({
    final String? uid,
    final String? email,
    final UserData? data,
  }) =>
      User(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        data: data ?? this.data,
      );

  @override
  List<Object?> get props => <Object?>[
        uid,
        email,
        data,
      ];

  @override
  String toString() => 'User{'
      'uid: $uid'
      ', email: $email'
      ', data: $data'
      '}';
}

@JsonSerializable()
class UserData extends Equatable {
  const UserData({
    required this.name,
    required this.isEnabled,
    required this.isAdmin,
  });

  factory UserData.fromJson(final Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  static const String nameString = 'name';
  static const String isEnabledString = 'isEnabled';
  static const String isAdminString = 'isAdmin';

  @JsonKey(name: nameString)
  final String name;

  @JsonKey(name: isEnabledString)
  final bool isEnabled;

  @JsonKey(name: isAdminString)
  final bool isAdmin;

  UserType get userType {
    if (!isEnabled) {
      return UserType.unabled;
    }
    if (isAdmin) {
      return UserType.admin;
    }
    return UserType.user;
  }

  UserData copyWith({
    final String? name,
    final bool? isEnabled,
    final bool? isAdmin,
  }) =>
      UserData(
        name: name ?? this.name,
        isEnabled: isEnabled ?? this.isEnabled,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  @override
  List<Object?> get props => <Object?>[
        name,
        isEnabled,
        isAdmin,
      ];

  @override
  String toString() => 'UserData{'
      'name: $name'
      ', isEnabled: $isEnabled'
      ', isAdmin: $isAdmin'
      '}';
}
