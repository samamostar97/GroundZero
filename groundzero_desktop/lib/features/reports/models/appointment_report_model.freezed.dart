// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentReportModel _$AppointmentReportModelFromJson(
  Map<String, dynamic> json,
) {
  return _AppointmentReportModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentReportModel {
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  int get totalAppointments => throw _privateConstructorUsedError;
  int get completedAppointments => throw _privateConstructorUsedError;
  int get cancelledAppointments => throw _privateConstructorUsedError;
  double get cancellationRate => throw _privateConstructorUsedError;
  List<StaffBookingItem> get staffBookings =>
      throw _privateConstructorUsedError;
  List<PeakHourItem> get peakHours => throw _privateConstructorUsedError;
  List<MonthlyAppointmentItem> get monthlyAppointments =>
      throw _privateConstructorUsedError;

  /// Serializes this AppointmentReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentReportModelCopyWith<AppointmentReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentReportModelCopyWith<$Res> {
  factory $AppointmentReportModelCopyWith(
    AppointmentReportModel value,
    $Res Function(AppointmentReportModel) then,
  ) = _$AppointmentReportModelCopyWithImpl<$Res, AppointmentReportModel>;
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalAppointments,
    int completedAppointments,
    int cancelledAppointments,
    double cancellationRate,
    List<StaffBookingItem> staffBookings,
    List<PeakHourItem> peakHours,
    List<MonthlyAppointmentItem> monthlyAppointments,
  });
}

/// @nodoc
class _$AppointmentReportModelCopyWithImpl<
  $Res,
  $Val extends AppointmentReportModel
>
    implements $AppointmentReportModelCopyWith<$Res> {
  _$AppointmentReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalAppointments = null,
    Object? completedAppointments = null,
    Object? cancelledAppointments = null,
    Object? cancellationRate = null,
    Object? staffBookings = null,
    Object? peakHours = null,
    Object? monthlyAppointments = null,
  }) {
    return _then(
      _value.copyWith(
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalAppointments: null == totalAppointments
                ? _value.totalAppointments
                : totalAppointments // ignore: cast_nullable_to_non_nullable
                      as int,
            completedAppointments: null == completedAppointments
                ? _value.completedAppointments
                : completedAppointments // ignore: cast_nullable_to_non_nullable
                      as int,
            cancelledAppointments: null == cancelledAppointments
                ? _value.cancelledAppointments
                : cancelledAppointments // ignore: cast_nullable_to_non_nullable
                      as int,
            cancellationRate: null == cancellationRate
                ? _value.cancellationRate
                : cancellationRate // ignore: cast_nullable_to_non_nullable
                      as double,
            staffBookings: null == staffBookings
                ? _value.staffBookings
                : staffBookings // ignore: cast_nullable_to_non_nullable
                      as List<StaffBookingItem>,
            peakHours: null == peakHours
                ? _value.peakHours
                : peakHours // ignore: cast_nullable_to_non_nullable
                      as List<PeakHourItem>,
            monthlyAppointments: null == monthlyAppointments
                ? _value.monthlyAppointments
                : monthlyAppointments // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyAppointmentItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentReportModelImplCopyWith<$Res>
    implements $AppointmentReportModelCopyWith<$Res> {
  factory _$$AppointmentReportModelImplCopyWith(
    _$AppointmentReportModelImpl value,
    $Res Function(_$AppointmentReportModelImpl) then,
  ) = __$$AppointmentReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalAppointments,
    int completedAppointments,
    int cancelledAppointments,
    double cancellationRate,
    List<StaffBookingItem> staffBookings,
    List<PeakHourItem> peakHours,
    List<MonthlyAppointmentItem> monthlyAppointments,
  });
}

/// @nodoc
class __$$AppointmentReportModelImplCopyWithImpl<$Res>
    extends
        _$AppointmentReportModelCopyWithImpl<$Res, _$AppointmentReportModelImpl>
    implements _$$AppointmentReportModelImplCopyWith<$Res> {
  __$$AppointmentReportModelImplCopyWithImpl(
    _$AppointmentReportModelImpl _value,
    $Res Function(_$AppointmentReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalAppointments = null,
    Object? completedAppointments = null,
    Object? cancelledAppointments = null,
    Object? cancellationRate = null,
    Object? staffBookings = null,
    Object? peakHours = null,
    Object? monthlyAppointments = null,
  }) {
    return _then(
      _$AppointmentReportModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalAppointments: null == totalAppointments
            ? _value.totalAppointments
            : totalAppointments // ignore: cast_nullable_to_non_nullable
                  as int,
        completedAppointments: null == completedAppointments
            ? _value.completedAppointments
            : completedAppointments // ignore: cast_nullable_to_non_nullable
                  as int,
        cancelledAppointments: null == cancelledAppointments
            ? _value.cancelledAppointments
            : cancelledAppointments // ignore: cast_nullable_to_non_nullable
                  as int,
        cancellationRate: null == cancellationRate
            ? _value.cancellationRate
            : cancellationRate // ignore: cast_nullable_to_non_nullable
                  as double,
        staffBookings: null == staffBookings
            ? _value._staffBookings
            : staffBookings // ignore: cast_nullable_to_non_nullable
                  as List<StaffBookingItem>,
        peakHours: null == peakHours
            ? _value._peakHours
            : peakHours // ignore: cast_nullable_to_non_nullable
                  as List<PeakHourItem>,
        monthlyAppointments: null == monthlyAppointments
            ? _value._monthlyAppointments
            : monthlyAppointments // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyAppointmentItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentReportModelImpl implements _AppointmentReportModel {
  const _$AppointmentReportModelImpl({
    required this.from,
    required this.to,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.cancellationRate,
    required final List<StaffBookingItem> staffBookings,
    required final List<PeakHourItem> peakHours,
    required final List<MonthlyAppointmentItem> monthlyAppointments,
  }) : _staffBookings = staffBookings,
       _peakHours = peakHours,
       _monthlyAppointments = monthlyAppointments;

  factory _$AppointmentReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentReportModelImplFromJson(json);

  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final int totalAppointments;
  @override
  final int completedAppointments;
  @override
  final int cancelledAppointments;
  @override
  final double cancellationRate;
  final List<StaffBookingItem> _staffBookings;
  @override
  List<StaffBookingItem> get staffBookings {
    if (_staffBookings is EqualUnmodifiableListView) return _staffBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staffBookings);
  }

  final List<PeakHourItem> _peakHours;
  @override
  List<PeakHourItem> get peakHours {
    if (_peakHours is EqualUnmodifiableListView) return _peakHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakHours);
  }

  final List<MonthlyAppointmentItem> _monthlyAppointments;
  @override
  List<MonthlyAppointmentItem> get monthlyAppointments {
    if (_monthlyAppointments is EqualUnmodifiableListView)
      return _monthlyAppointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyAppointments);
  }

  @override
  String toString() {
    return 'AppointmentReportModel(from: $from, to: $to, totalAppointments: $totalAppointments, completedAppointments: $completedAppointments, cancelledAppointments: $cancelledAppointments, cancellationRate: $cancellationRate, staffBookings: $staffBookings, peakHours: $peakHours, monthlyAppointments: $monthlyAppointments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentReportModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.completedAppointments, completedAppointments) ||
                other.completedAppointments == completedAppointments) &&
            (identical(other.cancelledAppointments, cancelledAppointments) ||
                other.cancelledAppointments == cancelledAppointments) &&
            (identical(other.cancellationRate, cancellationRate) ||
                other.cancellationRate == cancellationRate) &&
            const DeepCollectionEquality().equals(
              other._staffBookings,
              _staffBookings,
            ) &&
            const DeepCollectionEquality().equals(
              other._peakHours,
              _peakHours,
            ) &&
            const DeepCollectionEquality().equals(
              other._monthlyAppointments,
              _monthlyAppointments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    from,
    to,
    totalAppointments,
    completedAppointments,
    cancelledAppointments,
    cancellationRate,
    const DeepCollectionEquality().hash(_staffBookings),
    const DeepCollectionEquality().hash(_peakHours),
    const DeepCollectionEquality().hash(_monthlyAppointments),
  );

  /// Create a copy of AppointmentReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentReportModelImplCopyWith<_$AppointmentReportModelImpl>
  get copyWith =>
      __$$AppointmentReportModelImplCopyWithImpl<_$AppointmentReportModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentReportModelImplToJson(this);
  }
}

abstract class _AppointmentReportModel implements AppointmentReportModel {
  const factory _AppointmentReportModel({
    required final DateTime from,
    required final DateTime to,
    required final int totalAppointments,
    required final int completedAppointments,
    required final int cancelledAppointments,
    required final double cancellationRate,
    required final List<StaffBookingItem> staffBookings,
    required final List<PeakHourItem> peakHours,
    required final List<MonthlyAppointmentItem> monthlyAppointments,
  }) = _$AppointmentReportModelImpl;

  factory _AppointmentReportModel.fromJson(Map<String, dynamic> json) =
      _$AppointmentReportModelImpl.fromJson;

  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  int get totalAppointments;
  @override
  int get completedAppointments;
  @override
  int get cancelledAppointments;
  @override
  double get cancellationRate;
  @override
  List<StaffBookingItem> get staffBookings;
  @override
  List<PeakHourItem> get peakHours;
  @override
  List<MonthlyAppointmentItem> get monthlyAppointments;

  /// Create a copy of AppointmentReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentReportModelImplCopyWith<_$AppointmentReportModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StaffBookingItem _$StaffBookingItemFromJson(Map<String, dynamic> json) {
  return _StaffBookingItem.fromJson(json);
}

/// @nodoc
mixin _$StaffBookingItem {
  String get staffName => throw _privateConstructorUsedError;
  String get staffType => throw _privateConstructorUsedError;
  int get totalBookings => throw _privateConstructorUsedError;
  int get completedBookings => throw _privateConstructorUsedError;
  int get cancelledBookings => throw _privateConstructorUsedError;

  /// Serializes this StaffBookingItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffBookingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffBookingItemCopyWith<StaffBookingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffBookingItemCopyWith<$Res> {
  factory $StaffBookingItemCopyWith(
    StaffBookingItem value,
    $Res Function(StaffBookingItem) then,
  ) = _$StaffBookingItemCopyWithImpl<$Res, StaffBookingItem>;
  @useResult
  $Res call({
    String staffName,
    String staffType,
    int totalBookings,
    int completedBookings,
    int cancelledBookings,
  });
}

/// @nodoc
class _$StaffBookingItemCopyWithImpl<$Res, $Val extends StaffBookingItem>
    implements $StaffBookingItemCopyWith<$Res> {
  _$StaffBookingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffBookingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffName = null,
    Object? staffType = null,
    Object? totalBookings = null,
    Object? completedBookings = null,
    Object? cancelledBookings = null,
  }) {
    return _then(
      _value.copyWith(
            staffName: null == staffName
                ? _value.staffName
                : staffName // ignore: cast_nullable_to_non_nullable
                      as String,
            staffType: null == staffType
                ? _value.staffType
                : staffType // ignore: cast_nullable_to_non_nullable
                      as String,
            totalBookings: null == totalBookings
                ? _value.totalBookings
                : totalBookings // ignore: cast_nullable_to_non_nullable
                      as int,
            completedBookings: null == completedBookings
                ? _value.completedBookings
                : completedBookings // ignore: cast_nullable_to_non_nullable
                      as int,
            cancelledBookings: null == cancelledBookings
                ? _value.cancelledBookings
                : cancelledBookings // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffBookingItemImplCopyWith<$Res>
    implements $StaffBookingItemCopyWith<$Res> {
  factory _$$StaffBookingItemImplCopyWith(
    _$StaffBookingItemImpl value,
    $Res Function(_$StaffBookingItemImpl) then,
  ) = __$$StaffBookingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String staffName,
    String staffType,
    int totalBookings,
    int completedBookings,
    int cancelledBookings,
  });
}

/// @nodoc
class __$$StaffBookingItemImplCopyWithImpl<$Res>
    extends _$StaffBookingItemCopyWithImpl<$Res, _$StaffBookingItemImpl>
    implements _$$StaffBookingItemImplCopyWith<$Res> {
  __$$StaffBookingItemImplCopyWithImpl(
    _$StaffBookingItemImpl _value,
    $Res Function(_$StaffBookingItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffBookingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffName = null,
    Object? staffType = null,
    Object? totalBookings = null,
    Object? completedBookings = null,
    Object? cancelledBookings = null,
  }) {
    return _then(
      _$StaffBookingItemImpl(
        staffName: null == staffName
            ? _value.staffName
            : staffName // ignore: cast_nullable_to_non_nullable
                  as String,
        staffType: null == staffType
            ? _value.staffType
            : staffType // ignore: cast_nullable_to_non_nullable
                  as String,
        totalBookings: null == totalBookings
            ? _value.totalBookings
            : totalBookings // ignore: cast_nullable_to_non_nullable
                  as int,
        completedBookings: null == completedBookings
            ? _value.completedBookings
            : completedBookings // ignore: cast_nullable_to_non_nullable
                  as int,
        cancelledBookings: null == cancelledBookings
            ? _value.cancelledBookings
            : cancelledBookings // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffBookingItemImpl implements _StaffBookingItem {
  const _$StaffBookingItemImpl({
    required this.staffName,
    required this.staffType,
    required this.totalBookings,
    required this.completedBookings,
    required this.cancelledBookings,
  });

  factory _$StaffBookingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffBookingItemImplFromJson(json);

  @override
  final String staffName;
  @override
  final String staffType;
  @override
  final int totalBookings;
  @override
  final int completedBookings;
  @override
  final int cancelledBookings;

  @override
  String toString() {
    return 'StaffBookingItem(staffName: $staffName, staffType: $staffType, totalBookings: $totalBookings, completedBookings: $completedBookings, cancelledBookings: $cancelledBookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffBookingItemImpl &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.staffType, staffType) ||
                other.staffType == staffType) &&
            (identical(other.totalBookings, totalBookings) ||
                other.totalBookings == totalBookings) &&
            (identical(other.completedBookings, completedBookings) ||
                other.completedBookings == completedBookings) &&
            (identical(other.cancelledBookings, cancelledBookings) ||
                other.cancelledBookings == cancelledBookings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    staffName,
    staffType,
    totalBookings,
    completedBookings,
    cancelledBookings,
  );

  /// Create a copy of StaffBookingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffBookingItemImplCopyWith<_$StaffBookingItemImpl> get copyWith =>
      __$$StaffBookingItemImplCopyWithImpl<_$StaffBookingItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffBookingItemImplToJson(this);
  }
}

abstract class _StaffBookingItem implements StaffBookingItem {
  const factory _StaffBookingItem({
    required final String staffName,
    required final String staffType,
    required final int totalBookings,
    required final int completedBookings,
    required final int cancelledBookings,
  }) = _$StaffBookingItemImpl;

  factory _StaffBookingItem.fromJson(Map<String, dynamic> json) =
      _$StaffBookingItemImpl.fromJson;

  @override
  String get staffName;
  @override
  String get staffType;
  @override
  int get totalBookings;
  @override
  int get completedBookings;
  @override
  int get cancelledBookings;

  /// Create a copy of StaffBookingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffBookingItemImplCopyWith<_$StaffBookingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PeakHourItem _$PeakHourItemFromJson(Map<String, dynamic> json) {
  return _PeakHourItem.fromJson(json);
}

/// @nodoc
mixin _$PeakHourItem {
  int get hour => throw _privateConstructorUsedError;
  int get appointmentCount => throw _privateConstructorUsedError;

  /// Serializes this PeakHourItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PeakHourItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeakHourItemCopyWith<PeakHourItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeakHourItemCopyWith<$Res> {
  factory $PeakHourItemCopyWith(
    PeakHourItem value,
    $Res Function(PeakHourItem) then,
  ) = _$PeakHourItemCopyWithImpl<$Res, PeakHourItem>;
  @useResult
  $Res call({int hour, int appointmentCount});
}

/// @nodoc
class _$PeakHourItemCopyWithImpl<$Res, $Val extends PeakHourItem>
    implements $PeakHourItemCopyWith<$Res> {
  _$PeakHourItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeakHourItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hour = null, Object? appointmentCount = null}) {
    return _then(
      _value.copyWith(
            hour: null == hour
                ? _value.hour
                : hour // ignore: cast_nullable_to_non_nullable
                      as int,
            appointmentCount: null == appointmentCount
                ? _value.appointmentCount
                : appointmentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeakHourItemImplCopyWith<$Res>
    implements $PeakHourItemCopyWith<$Res> {
  factory _$$PeakHourItemImplCopyWith(
    _$PeakHourItemImpl value,
    $Res Function(_$PeakHourItemImpl) then,
  ) = __$$PeakHourItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, int appointmentCount});
}

/// @nodoc
class __$$PeakHourItemImplCopyWithImpl<$Res>
    extends _$PeakHourItemCopyWithImpl<$Res, _$PeakHourItemImpl>
    implements _$$PeakHourItemImplCopyWith<$Res> {
  __$$PeakHourItemImplCopyWithImpl(
    _$PeakHourItemImpl _value,
    $Res Function(_$PeakHourItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeakHourItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hour = null, Object? appointmentCount = null}) {
    return _then(
      _$PeakHourItemImpl(
        hour: null == hour
            ? _value.hour
            : hour // ignore: cast_nullable_to_non_nullable
                  as int,
        appointmentCount: null == appointmentCount
            ? _value.appointmentCount
            : appointmentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PeakHourItemImpl implements _PeakHourItem {
  const _$PeakHourItemImpl({
    required this.hour,
    required this.appointmentCount,
  });

  factory _$PeakHourItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeakHourItemImplFromJson(json);

  @override
  final int hour;
  @override
  final int appointmentCount;

  @override
  String toString() {
    return 'PeakHourItem(hour: $hour, appointmentCount: $appointmentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeakHourItemImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hour, appointmentCount);

  /// Create a copy of PeakHourItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeakHourItemImplCopyWith<_$PeakHourItemImpl> get copyWith =>
      __$$PeakHourItemImplCopyWithImpl<_$PeakHourItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeakHourItemImplToJson(this);
  }
}

abstract class _PeakHourItem implements PeakHourItem {
  const factory _PeakHourItem({
    required final int hour,
    required final int appointmentCount,
  }) = _$PeakHourItemImpl;

  factory _PeakHourItem.fromJson(Map<String, dynamic> json) =
      _$PeakHourItemImpl.fromJson;

  @override
  int get hour;
  @override
  int get appointmentCount;

  /// Create a copy of PeakHourItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeakHourItemImplCopyWith<_$PeakHourItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyAppointmentItem _$MonthlyAppointmentItemFromJson(
  Map<String, dynamic> json,
) {
  return _MonthlyAppointmentItem.fromJson(json);
}

/// @nodoc
mixin _$MonthlyAppointmentItem {
  String get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get cancelledCount => throw _privateConstructorUsedError;

  /// Serializes this MonthlyAppointmentItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyAppointmentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyAppointmentItemCopyWith<MonthlyAppointmentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyAppointmentItemCopyWith<$Res> {
  factory $MonthlyAppointmentItemCopyWith(
    MonthlyAppointmentItem value,
    $Res Function(MonthlyAppointmentItem) then,
  ) = _$MonthlyAppointmentItemCopyWithImpl<$Res, MonthlyAppointmentItem>;
  @useResult
  $Res call({String month, int year, int count, int cancelledCount});
}

/// @nodoc
class _$MonthlyAppointmentItemCopyWithImpl<
  $Res,
  $Val extends MonthlyAppointmentItem
>
    implements $MonthlyAppointmentItemCopyWith<$Res> {
  _$MonthlyAppointmentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyAppointmentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? count = null,
    Object? cancelledCount = null,
  }) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            cancelledCount: null == cancelledCount
                ? _value.cancelledCount
                : cancelledCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyAppointmentItemImplCopyWith<$Res>
    implements $MonthlyAppointmentItemCopyWith<$Res> {
  factory _$$MonthlyAppointmentItemImplCopyWith(
    _$MonthlyAppointmentItemImpl value,
    $Res Function(_$MonthlyAppointmentItemImpl) then,
  ) = __$$MonthlyAppointmentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, int year, int count, int cancelledCount});
}

/// @nodoc
class __$$MonthlyAppointmentItemImplCopyWithImpl<$Res>
    extends
        _$MonthlyAppointmentItemCopyWithImpl<$Res, _$MonthlyAppointmentItemImpl>
    implements _$$MonthlyAppointmentItemImplCopyWith<$Res> {
  __$$MonthlyAppointmentItemImplCopyWithImpl(
    _$MonthlyAppointmentItemImpl _value,
    $Res Function(_$MonthlyAppointmentItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyAppointmentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? count = null,
    Object? cancelledCount = null,
  }) {
    return _then(
      _$MonthlyAppointmentItemImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        cancelledCount: null == cancelledCount
            ? _value.cancelledCount
            : cancelledCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyAppointmentItemImpl implements _MonthlyAppointmentItem {
  const _$MonthlyAppointmentItemImpl({
    required this.month,
    required this.year,
    required this.count,
    required this.cancelledCount,
  });

  factory _$MonthlyAppointmentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyAppointmentItemImplFromJson(json);

  @override
  final String month;
  @override
  final int year;
  @override
  final int count;
  @override
  final int cancelledCount;

  @override
  String toString() {
    return 'MonthlyAppointmentItem(month: $month, year: $year, count: $count, cancelledCount: $cancelledCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyAppointmentItemImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.cancelledCount, cancelledCount) ||
                other.cancelledCount == cancelledCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, month, year, count, cancelledCount);

  /// Create a copy of MonthlyAppointmentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyAppointmentItemImplCopyWith<_$MonthlyAppointmentItemImpl>
  get copyWith =>
      __$$MonthlyAppointmentItemImplCopyWithImpl<_$MonthlyAppointmentItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyAppointmentItemImplToJson(this);
  }
}

abstract class _MonthlyAppointmentItem implements MonthlyAppointmentItem {
  const factory _MonthlyAppointmentItem({
    required final String month,
    required final int year,
    required final int count,
    required final int cancelledCount,
  }) = _$MonthlyAppointmentItemImpl;

  factory _MonthlyAppointmentItem.fromJson(Map<String, dynamic> json) =
      _$MonthlyAppointmentItemImpl.fromJson;

  @override
  String get month;
  @override
  int get year;
  @override
  int get count;
  @override
  int get cancelledCount;

  /// Create a copy of MonthlyAppointmentItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyAppointmentItemImplCopyWith<_$MonthlyAppointmentItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}
