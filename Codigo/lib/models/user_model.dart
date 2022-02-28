import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserType { user, admin }

@freezed
class User with _$User {
  factory User({
    String? objectId,
    dynamic photo,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? startDate,
    required String name,
    required String email,
    String? post,
    String? password,
    @Default(UserType.user) UserType type,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
