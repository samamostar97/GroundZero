import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_report_model.freezed.dart';
part 'appointment_report_model.g.dart';

@freezed
class AppointmentReportModel with _$AppointmentReportModel {
  const factory AppointmentReportModel({
    required DateTime from,
    required DateTime to,
    required int totalAppointments,
    required int completedAppointments,
    required int cancelledAppointments,
    required double cancellationRate,
    required List<StaffBookingItem> staffBookings,
    required List<PeakHourItem> peakHours,
    required List<MonthlyAppointmentItem> monthlyAppointments,
  }) = _AppointmentReportModel;

  factory AppointmentReportModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentReportModelFromJson(json);
}

@freezed
class StaffBookingItem with _$StaffBookingItem {
  const factory StaffBookingItem({
    required String staffName,
    required String staffType,
    required int totalBookings,
    required int completedBookings,
    required int cancelledBookings,
  }) = _StaffBookingItem;

  factory StaffBookingItem.fromJson(Map<String, dynamic> json) =>
      _$StaffBookingItemFromJson(json);
}

@freezed
class PeakHourItem with _$PeakHourItem {
  const factory PeakHourItem({
    required int hour,
    required int appointmentCount,
  }) = _PeakHourItem;

  factory PeakHourItem.fromJson(Map<String, dynamic> json) =>
      _$PeakHourItemFromJson(json);
}

@freezed
class MonthlyAppointmentItem with _$MonthlyAppointmentItem {
  const factory MonthlyAppointmentItem({
    required String month,
    required int year,
    required int count,
    required int cancelledCount,
  }) = _MonthlyAppointmentItem;

  factory MonthlyAppointmentItem.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAppointmentItemFromJson(json);
}
