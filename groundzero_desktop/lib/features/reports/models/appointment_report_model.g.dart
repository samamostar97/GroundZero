// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentReportModelImpl _$$AppointmentReportModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentReportModelImpl(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  totalAppointments: (json['totalAppointments'] as num).toInt(),
  completedAppointments: (json['completedAppointments'] as num).toInt(),
  cancelledAppointments: (json['cancelledAppointments'] as num).toInt(),
  cancellationRate: (json['cancellationRate'] as num).toDouble(),
  staffBookings: (json['staffBookings'] as List<dynamic>)
      .map((e) => StaffBookingItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  peakHours: (json['peakHours'] as List<dynamic>)
      .map((e) => PeakHourItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  monthlyAppointments: (json['monthlyAppointments'] as List<dynamic>)
      .map((e) => MonthlyAppointmentItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AppointmentReportModelImplToJson(
  _$AppointmentReportModelImpl instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
  'totalAppointments': instance.totalAppointments,
  'completedAppointments': instance.completedAppointments,
  'cancelledAppointments': instance.cancelledAppointments,
  'cancellationRate': instance.cancellationRate,
  'staffBookings': instance.staffBookings,
  'peakHours': instance.peakHours,
  'monthlyAppointments': instance.monthlyAppointments,
};

_$StaffBookingItemImpl _$$StaffBookingItemImplFromJson(
  Map<String, dynamic> json,
) => _$StaffBookingItemImpl(
  staffName: json['staffName'] as String,
  staffType: json['staffType'] as String,
  totalBookings: (json['totalBookings'] as num).toInt(),
  completedBookings: (json['completedBookings'] as num).toInt(),
  cancelledBookings: (json['cancelledBookings'] as num).toInt(),
);

Map<String, dynamic> _$$StaffBookingItemImplToJson(
  _$StaffBookingItemImpl instance,
) => <String, dynamic>{
  'staffName': instance.staffName,
  'staffType': instance.staffType,
  'totalBookings': instance.totalBookings,
  'completedBookings': instance.completedBookings,
  'cancelledBookings': instance.cancelledBookings,
};

_$PeakHourItemImpl _$$PeakHourItemImplFromJson(Map<String, dynamic> json) =>
    _$PeakHourItemImpl(
      hour: (json['hour'] as num).toInt(),
      appointmentCount: (json['appointmentCount'] as num).toInt(),
    );

Map<String, dynamic> _$$PeakHourItemImplToJson(_$PeakHourItemImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'appointmentCount': instance.appointmentCount,
    };

_$MonthlyAppointmentItemImpl _$$MonthlyAppointmentItemImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyAppointmentItemImpl(
  month: json['month'] as String,
  year: (json['year'] as num).toInt(),
  count: (json['count'] as num).toInt(),
  cancelledCount: (json['cancelledCount'] as num).toInt(),
);

Map<String, dynamic> _$$MonthlyAppointmentItemImplToJson(
  _$MonthlyAppointmentItemImpl instance,
) => <String, dynamic>{
  'month': instance.month,
  'year': instance.year,
  'count': instance.count,
  'cancelledCount': instance.cancelledCount,
};
