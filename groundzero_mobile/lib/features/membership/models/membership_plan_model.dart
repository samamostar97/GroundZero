import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_plan_model.freezed.dart';
part 'membership_plan_model.g.dart';

@freezed
class MembershipPlanModel with _$MembershipPlanModel {
  const factory MembershipPlanModel({
    required int id,
    required String name,
    String? description,
    required double price,
    required int durationDays,
    required bool isActive,
    required DateTime createdAt,
  }) = _MembershipPlanModel;

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipPlanModelFromJson(json);
}
