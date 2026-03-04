import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_model.freezed.dart';
part 'membership_model.g.dart';

@freezed
class MembershipModel with _$MembershipModel {
  const factory MembershipModel({
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
  }) = _MembershipModel;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipModelFromJson(json);
}
