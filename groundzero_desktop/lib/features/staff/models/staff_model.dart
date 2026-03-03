import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_model.freezed.dart';
part 'staff_model.g.dart';

@freezed
class StaffModel with _$StaffModel {
  const factory StaffModel({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? bio,
    String? profileImageUrl,
    required String staffType,
    required bool isActive,
    required DateTime createdAt,
  }) = _StaffModel;

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);
}
