import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clock_in/models/auth/user_model.dart';

part 'work_place_model.freezed.dart';
part 'work_place_model.g.dart';

@freezed
class WorkPlace with _$WorkPlace {
  factory WorkPlace({
    String? objectId,
    required User user,
    required double latitude,
    required double longitude,
    required String address,
    required bool isActive,
  }) = _WorkPlace;

  factory WorkPlace.fromJson(Map<String, dynamic> json) =>
      _$WorkPlaceFromJson(json);
}
