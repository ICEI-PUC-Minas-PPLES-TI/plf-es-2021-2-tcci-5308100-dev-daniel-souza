// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'work_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorkPlace _$WorkPlaceFromJson(Map<String, dynamic> json) {
  return _WorkPlace.fromJson(json);
}

/// @nodoc
mixin _$WorkPlace {
  String? get objectId => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkPlaceCopyWith<WorkPlace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkPlaceCopyWith<$Res> {
  factory $WorkPlaceCopyWith(WorkPlace value, $Res Function(WorkPlace) then) =
      _$WorkPlaceCopyWithImpl<$Res>;
  $Res call(
      {String? objectId,
      User user,
      double latitude,
      double longitude,
      String address,
      bool isActive});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$WorkPlaceCopyWithImpl<$Res> implements $WorkPlaceCopyWith<$Res> {
  _$WorkPlaceCopyWithImpl(this._value, this._then);

  final WorkPlace _value;
  // ignore: unused_field
  final $Res Function(WorkPlace) _then;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? user = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      objectId: objectId == freezed
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_WorkPlaceCopyWith<$Res> implements $WorkPlaceCopyWith<$Res> {
  factory _$$_WorkPlaceCopyWith(
          _$_WorkPlace value, $Res Function(_$_WorkPlace) then) =
      __$$_WorkPlaceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? objectId,
      User user,
      double latitude,
      double longitude,
      String address,
      bool isActive});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_WorkPlaceCopyWithImpl<$Res> extends _$WorkPlaceCopyWithImpl<$Res>
    implements _$$_WorkPlaceCopyWith<$Res> {
  __$$_WorkPlaceCopyWithImpl(
      _$_WorkPlace _value, $Res Function(_$_WorkPlace) _then)
      : super(_value, (v) => _then(v as _$_WorkPlace));

  @override
  _$_WorkPlace get _value => super._value as _$_WorkPlace;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? user = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? address = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$_WorkPlace(
      objectId: objectId == freezed
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WorkPlace implements _WorkPlace {
  _$_WorkPlace(
      {this.objectId,
      required this.user,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.isActive});

  factory _$_WorkPlace.fromJson(Map<String, dynamic> json) =>
      _$$_WorkPlaceFromJson(json);

  @override
  final String? objectId;
  @override
  final User user;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'WorkPlace(objectId: $objectId, user: $user, latitude: $latitude, longitude: $longitude, address: $address, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkPlace &&
            const DeepCollectionEquality().equals(other.objectId, objectId) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.longitude, longitude) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.isActive, isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(objectId),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(longitude),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(isActive));

  @JsonKey(ignore: true)
  @override
  _$$_WorkPlaceCopyWith<_$_WorkPlace> get copyWith =>
      __$$_WorkPlaceCopyWithImpl<_$_WorkPlace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorkPlaceToJson(this);
  }
}

abstract class _WorkPlace implements WorkPlace {
  factory _WorkPlace(
      {final String? objectId,
      required final User user,
      required final double latitude,
      required final double longitude,
      required final String address,
      required final bool isActive}) = _$_WorkPlace;

  factory _WorkPlace.fromJson(Map<String, dynamic> json) =
      _$_WorkPlace.fromJson;

  @override
  String? get objectId => throw _privateConstructorUsedError;
  @override
  User get user => throw _privateConstructorUsedError;
  @override
  double get latitude => throw _privateConstructorUsedError;
  @override
  double get longitude => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WorkPlaceCopyWith<_$_WorkPlace> get copyWith =>
      throw _privateConstructorUsedError;
}
