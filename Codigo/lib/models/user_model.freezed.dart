// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {String? objectId,
      dynamic photo,
      bool isActive = true,
      DateTime? createdAt,
      DateTime? startDate,
      required String name,
      required String email,
      String? post,
      String? password,
      UserType type = UserType.user}) {
    return _User(
      objectId: objectId,
      photo: photo,
      isActive: isActive,
      createdAt: createdAt,
      startDate: startDate,
      name: name,
      email: email,
      post: post,
      password: password,
      type: type,
    );
  }

  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String? get objectId => throw _privateConstructorUsedError;
  dynamic get photo => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get post => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  UserType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? objectId,
      dynamic photo,
      bool isActive,
      DateTime? createdAt,
      DateTime? startDate,
      String name,
      String email,
      String? post,
      String? password,
      UserType type});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? startDate = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? post = freezed,
    Object? password = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      objectId: objectId == freezed
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      post: post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? objectId,
      dynamic photo,
      bool isActive,
      DateTime? createdAt,
      DateTime? startDate,
      String name,
      String email,
      String? post,
      String? password,
      UserType type});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? startDate = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? post = freezed,
    Object? password = freezed,
    Object? type = freezed,
  }) {
    return _then(_User(
      objectId: objectId == freezed
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      post: post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  _$_User(
      {this.objectId,
      this.photo,
      this.isActive = true,
      this.createdAt,
      this.startDate,
      required this.name,
      required this.email,
      this.post,
      this.password,
      this.type = UserType.user});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String? objectId;
  @override
  final dynamic photo;
  @JsonKey()
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? startDate;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? post;
  @override
  final String? password;
  @JsonKey()
  @override
  final UserType type;

  @override
  String toString() {
    return 'User(objectId: $objectId, photo: $photo, isActive: $isActive, createdAt: $createdAt, startDate: $startDate, name: $name, email: $email, post: $post, password: $password, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.objectId, objectId) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality().equals(other.isActive, isActive) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.post, post) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(objectId),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(isActive),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(post),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User implements User {
  factory _User(
      {String? objectId,
      dynamic photo,
      bool isActive,
      DateTime? createdAt,
      DateTime? startDate,
      required String name,
      required String email,
      String? post,
      String? password,
      UserType type}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String? get objectId;
  @override
  dynamic get photo;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get startDate;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get post;
  @override
  String? get password;
  @override
  UserType get type;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
