// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'month_labor_time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MonthLaborTime _$MonthLaborTimeFromJson(Map<String, dynamic> json) {
  return _MonthLaborTime.fromJson(json);
}

/// @nodoc
class _$MonthLaborTimeTearOff {
  const _$MonthLaborTimeTearOff();

  _MonthLaborTime call(
      {String? objectId,
      required User user,
      required int year,
      required int month,
      String? status,
      String? monthReference,
      List<LaborTime> laborTimeList = const <LaborTime>[]}) {
    return _MonthLaborTime(
      objectId: objectId,
      user: user,
      year: year,
      month: month,
      status: status,
      monthReference: monthReference,
      laborTimeList: laborTimeList,
    );
  }

  MonthLaborTime fromJson(Map<String, Object?> json) {
    return MonthLaborTime.fromJson(json);
  }
}

/// @nodoc
const $MonthLaborTime = _$MonthLaborTimeTearOff();

/// @nodoc
mixin _$MonthLaborTime {
  String? get objectId => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get monthReference => throw _privateConstructorUsedError;
  List<LaborTime> get laborTimeList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonthLaborTimeCopyWith<MonthLaborTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthLaborTimeCopyWith<$Res> {
  factory $MonthLaborTimeCopyWith(
          MonthLaborTime value, $Res Function(MonthLaborTime) then) =
      _$MonthLaborTimeCopyWithImpl<$Res>;
  $Res call(
      {String? objectId,
      User user,
      int year,
      int month,
      String? status,
      String? monthReference,
      List<LaborTime> laborTimeList});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$MonthLaborTimeCopyWithImpl<$Res>
    implements $MonthLaborTimeCopyWith<$Res> {
  _$MonthLaborTimeCopyWithImpl(this._value, this._then);

  final MonthLaborTime _value;
  // ignore: unused_field
  final $Res Function(MonthLaborTime) _then;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? user = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? status = freezed,
    Object? monthReference = freezed,
    Object? laborTimeList = freezed,
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
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      monthReference: monthReference == freezed
          ? _value.monthReference
          : monthReference // ignore: cast_nullable_to_non_nullable
              as String?,
      laborTimeList: laborTimeList == freezed
          ? _value.laborTimeList
          : laborTimeList // ignore: cast_nullable_to_non_nullable
              as List<LaborTime>,
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
abstract class _$MonthLaborTimeCopyWith<$Res>
    implements $MonthLaborTimeCopyWith<$Res> {
  factory _$MonthLaborTimeCopyWith(
          _MonthLaborTime value, $Res Function(_MonthLaborTime) then) =
      __$MonthLaborTimeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? objectId,
      User user,
      int year,
      int month,
      String? status,
      String? monthReference,
      List<LaborTime> laborTimeList});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$MonthLaborTimeCopyWithImpl<$Res>
    extends _$MonthLaborTimeCopyWithImpl<$Res>
    implements _$MonthLaborTimeCopyWith<$Res> {
  __$MonthLaborTimeCopyWithImpl(
      _MonthLaborTime _value, $Res Function(_MonthLaborTime) _then)
      : super(_value, (v) => _then(v as _MonthLaborTime));

  @override
  _MonthLaborTime get _value => super._value as _MonthLaborTime;

  @override
  $Res call({
    Object? objectId = freezed,
    Object? user = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? status = freezed,
    Object? monthReference = freezed,
    Object? laborTimeList = freezed,
  }) {
    return _then(_MonthLaborTime(
      objectId: objectId == freezed
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      monthReference: monthReference == freezed
          ? _value.monthReference
          : monthReference // ignore: cast_nullable_to_non_nullable
              as String?,
      laborTimeList: laborTimeList == freezed
          ? _value.laborTimeList
          : laborTimeList // ignore: cast_nullable_to_non_nullable
              as List<LaborTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MonthLaborTime extends _MonthLaborTime {
  _$_MonthLaborTime(
      {this.objectId,
      required this.user,
      required this.year,
      required this.month,
      this.status,
      this.monthReference,
      this.laborTimeList = const <LaborTime>[]})
      : super._();

  factory _$_MonthLaborTime.fromJson(Map<String, dynamic> json) =>
      _$$_MonthLaborTimeFromJson(json);

  @override
  final String? objectId;
  @override
  final User user;
  @override
  final int year;
  @override
  final int month;
  @override
  final String? status;
  @override
  final String? monthReference;
  @JsonKey()
  @override
  final List<LaborTime> laborTimeList;

  @override
  String toString() {
    return 'MonthLaborTime(objectId: $objectId, user: $user, year: $year, month: $month, status: $status, monthReference: $monthReference, laborTimeList: $laborTimeList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MonthLaborTime &&
            const DeepCollectionEquality().equals(other.objectId, objectId) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality().equals(other.month, month) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.monthReference, monthReference) &&
            const DeepCollectionEquality()
                .equals(other.laborTimeList, laborTimeList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(objectId),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(year),
      const DeepCollectionEquality().hash(month),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(monthReference),
      const DeepCollectionEquality().hash(laborTimeList));

  @JsonKey(ignore: true)
  @override
  _$MonthLaborTimeCopyWith<_MonthLaborTime> get copyWith =>
      __$MonthLaborTimeCopyWithImpl<_MonthLaborTime>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MonthLaborTimeToJson(this);
  }
}

abstract class _MonthLaborTime extends MonthLaborTime {
  factory _MonthLaborTime(
      {String? objectId,
      required User user,
      required int year,
      required int month,
      String? status,
      String? monthReference,
      List<LaborTime> laborTimeList}) = _$_MonthLaborTime;
  _MonthLaborTime._() : super._();

  factory _MonthLaborTime.fromJson(Map<String, dynamic> json) =
      _$_MonthLaborTime.fromJson;

  @override
  String? get objectId;
  @override
  User get user;
  @override
  int get year;
  @override
  int get month;
  @override
  String? get status;
  @override
  String? get monthReference;
  @override
  List<LaborTime> get laborTimeList;
  @override
  @JsonKey(ignore: true)
  _$MonthLaborTimeCopyWith<_MonthLaborTime> get copyWith =>
      throw _privateConstructorUsedError;
}
