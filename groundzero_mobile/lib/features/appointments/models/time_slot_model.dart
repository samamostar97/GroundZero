import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

@freezed
class TimeSlotModel with _$TimeSlotModel {
  const factory TimeSlotModel({
    required String time,
    required bool isAvailable,
  }) = _TimeSlotModel;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(json);
}
