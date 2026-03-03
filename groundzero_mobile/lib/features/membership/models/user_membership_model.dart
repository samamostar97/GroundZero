import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_membership_model.freezed.dart';
part 'user_membership_model.g.dart';

@freezed
class UserMembershipModel with _$UserMembershipModel {
  const factory UserMembershipModel({
    required int id,
    required int userId,
    required String userFullName,
    required String userEmail,
    required String planName,
    required double planPrice,
    required int durationDays,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required DateTime createdAt,
  }) = _UserMembershipModel;

  factory UserMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$UserMembershipModelFromJson(json);
}
