// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RevenueReportModel _$RevenueReportModelFromJson(Map<String, dynamic> json) {
  return _RevenueReportModel.fromJson(json);
}

/// @nodoc
mixin _$RevenueReportModel {
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  double get totalOrderRevenue => throw _privateConstructorUsedError;
  int get totalOrders => throw _privateConstructorUsedError;
  int get totalAppointments => throw _privateConstructorUsedError;
  List<MonthlyRevenueItem> get monthlyRevenue =>
      throw _privateConstructorUsedError;
  List<CategoryRevenueItem> get categoryRevenue =>
      throw _privateConstructorUsedError;

  /// Serializes this RevenueReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevenueReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevenueReportModelCopyWith<RevenueReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueReportModelCopyWith<$Res> {
  factory $RevenueReportModelCopyWith(
    RevenueReportModel value,
    $Res Function(RevenueReportModel) then,
  ) = _$RevenueReportModelCopyWithImpl<$Res, RevenueReportModel>;
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    double totalOrderRevenue,
    int totalOrders,
    int totalAppointments,
    List<MonthlyRevenueItem> monthlyRevenue,
    List<CategoryRevenueItem> categoryRevenue,
  });
}

/// @nodoc
class _$RevenueReportModelCopyWithImpl<$Res, $Val extends RevenueReportModel>
    implements $RevenueReportModelCopyWith<$Res> {
  _$RevenueReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevenueReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalOrderRevenue = null,
    Object? totalOrders = null,
    Object? totalAppointments = null,
    Object? monthlyRevenue = null,
    Object? categoryRevenue = null,
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
            totalOrderRevenue: null == totalOrderRevenue
                ? _value.totalOrderRevenue
                : totalOrderRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            totalOrders: null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAppointments: null == totalAppointments
                ? _value.totalAppointments
                : totalAppointments // ignore: cast_nullable_to_non_nullable
                      as int,
            monthlyRevenue: null == monthlyRevenue
                ? _value.monthlyRevenue
                : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyRevenueItem>,
            categoryRevenue: null == categoryRevenue
                ? _value.categoryRevenue
                : categoryRevenue // ignore: cast_nullable_to_non_nullable
                      as List<CategoryRevenueItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RevenueReportModelImplCopyWith<$Res>
    implements $RevenueReportModelCopyWith<$Res> {
  factory _$$RevenueReportModelImplCopyWith(
    _$RevenueReportModelImpl value,
    $Res Function(_$RevenueReportModelImpl) then,
  ) = __$$RevenueReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    double totalOrderRevenue,
    int totalOrders,
    int totalAppointments,
    List<MonthlyRevenueItem> monthlyRevenue,
    List<CategoryRevenueItem> categoryRevenue,
  });
}

/// @nodoc
class __$$RevenueReportModelImplCopyWithImpl<$Res>
    extends _$RevenueReportModelCopyWithImpl<$Res, _$RevenueReportModelImpl>
    implements _$$RevenueReportModelImplCopyWith<$Res> {
  __$$RevenueReportModelImplCopyWithImpl(
    _$RevenueReportModelImpl _value,
    $Res Function(_$RevenueReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RevenueReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalOrderRevenue = null,
    Object? totalOrders = null,
    Object? totalAppointments = null,
    Object? monthlyRevenue = null,
    Object? categoryRevenue = null,
  }) {
    return _then(
      _$RevenueReportModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalOrderRevenue: null == totalOrderRevenue
            ? _value.totalOrderRevenue
            : totalOrderRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        totalOrders: null == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAppointments: null == totalAppointments
            ? _value.totalAppointments
            : totalAppointments // ignore: cast_nullable_to_non_nullable
                  as int,
        monthlyRevenue: null == monthlyRevenue
            ? _value._monthlyRevenue
            : monthlyRevenue // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyRevenueItem>,
        categoryRevenue: null == categoryRevenue
            ? _value._categoryRevenue
            : categoryRevenue // ignore: cast_nullable_to_non_nullable
                  as List<CategoryRevenueItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueReportModelImpl implements _RevenueReportModel {
  const _$RevenueReportModelImpl({
    required this.from,
    required this.to,
    required this.totalOrderRevenue,
    required this.totalOrders,
    required this.totalAppointments,
    required final List<MonthlyRevenueItem> monthlyRevenue,
    required final List<CategoryRevenueItem> categoryRevenue,
  }) : _monthlyRevenue = monthlyRevenue,
       _categoryRevenue = categoryRevenue;

  factory _$RevenueReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueReportModelImplFromJson(json);

  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final double totalOrderRevenue;
  @override
  final int totalOrders;
  @override
  final int totalAppointments;
  final List<MonthlyRevenueItem> _monthlyRevenue;
  @override
  List<MonthlyRevenueItem> get monthlyRevenue {
    if (_monthlyRevenue is EqualUnmodifiableListView) return _monthlyRevenue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyRevenue);
  }

  final List<CategoryRevenueItem> _categoryRevenue;
  @override
  List<CategoryRevenueItem> get categoryRevenue {
    if (_categoryRevenue is EqualUnmodifiableListView) return _categoryRevenue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryRevenue);
  }

  @override
  String toString() {
    return 'RevenueReportModel(from: $from, to: $to, totalOrderRevenue: $totalOrderRevenue, totalOrders: $totalOrders, totalAppointments: $totalAppointments, monthlyRevenue: $monthlyRevenue, categoryRevenue: $categoryRevenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueReportModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.totalOrderRevenue, totalOrderRevenue) ||
                other.totalOrderRevenue == totalOrderRevenue) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            const DeepCollectionEquality().equals(
              other._monthlyRevenue,
              _monthlyRevenue,
            ) &&
            const DeepCollectionEquality().equals(
              other._categoryRevenue,
              _categoryRevenue,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    from,
    to,
    totalOrderRevenue,
    totalOrders,
    totalAppointments,
    const DeepCollectionEquality().hash(_monthlyRevenue),
    const DeepCollectionEquality().hash(_categoryRevenue),
  );

  /// Create a copy of RevenueReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueReportModelImplCopyWith<_$RevenueReportModelImpl> get copyWith =>
      __$$RevenueReportModelImplCopyWithImpl<_$RevenueReportModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueReportModelImplToJson(this);
  }
}

abstract class _RevenueReportModel implements RevenueReportModel {
  const factory _RevenueReportModel({
    required final DateTime from,
    required final DateTime to,
    required final double totalOrderRevenue,
    required final int totalOrders,
    required final int totalAppointments,
    required final List<MonthlyRevenueItem> monthlyRevenue,
    required final List<CategoryRevenueItem> categoryRevenue,
  }) = _$RevenueReportModelImpl;

  factory _RevenueReportModel.fromJson(Map<String, dynamic> json) =
      _$RevenueReportModelImpl.fromJson;

  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  double get totalOrderRevenue;
  @override
  int get totalOrders;
  @override
  int get totalAppointments;
  @override
  List<MonthlyRevenueItem> get monthlyRevenue;
  @override
  List<CategoryRevenueItem> get categoryRevenue;

  /// Create a copy of RevenueReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevenueReportModelImplCopyWith<_$RevenueReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyRevenueItem _$MonthlyRevenueItemFromJson(Map<String, dynamic> json) {
  return _MonthlyRevenueItem.fromJson(json);
}

/// @nodoc
mixin _$MonthlyRevenueItem {
  String get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  int get orderCount => throw _privateConstructorUsedError;

  /// Serializes this MonthlyRevenueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyRevenueItemCopyWith<MonthlyRevenueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyRevenueItemCopyWith<$Res> {
  factory $MonthlyRevenueItemCopyWith(
    MonthlyRevenueItem value,
    $Res Function(MonthlyRevenueItem) then,
  ) = _$MonthlyRevenueItemCopyWithImpl<$Res, MonthlyRevenueItem>;
  @useResult
  $Res call({String month, int year, double revenue, int orderCount});
}

/// @nodoc
class _$MonthlyRevenueItemCopyWithImpl<$Res, $Val extends MonthlyRevenueItem>
    implements $MonthlyRevenueItemCopyWith<$Res> {
  _$MonthlyRevenueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? revenue = null,
    Object? orderCount = null,
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
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as double,
            orderCount: null == orderCount
                ? _value.orderCount
                : orderCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyRevenueItemImplCopyWith<$Res>
    implements $MonthlyRevenueItemCopyWith<$Res> {
  factory _$$MonthlyRevenueItemImplCopyWith(
    _$MonthlyRevenueItemImpl value,
    $Res Function(_$MonthlyRevenueItemImpl) then,
  ) = __$$MonthlyRevenueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, int year, double revenue, int orderCount});
}

/// @nodoc
class __$$MonthlyRevenueItemImplCopyWithImpl<$Res>
    extends _$MonthlyRevenueItemCopyWithImpl<$Res, _$MonthlyRevenueItemImpl>
    implements _$$MonthlyRevenueItemImplCopyWith<$Res> {
  __$$MonthlyRevenueItemImplCopyWithImpl(
    _$MonthlyRevenueItemImpl _value,
    $Res Function(_$MonthlyRevenueItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? revenue = null,
    Object? orderCount = null,
  }) {
    return _then(
      _$MonthlyRevenueItemImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as double,
        orderCount: null == orderCount
            ? _value.orderCount
            : orderCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyRevenueItemImpl implements _MonthlyRevenueItem {
  const _$MonthlyRevenueItemImpl({
    required this.month,
    required this.year,
    required this.revenue,
    required this.orderCount,
  });

  factory _$MonthlyRevenueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyRevenueItemImplFromJson(json);

  @override
  final String month;
  @override
  final int year;
  @override
  final double revenue;
  @override
  final int orderCount;

  @override
  String toString() {
    return 'MonthlyRevenueItem(month: $month, year: $year, revenue: $revenue, orderCount: $orderCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyRevenueItemImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, month, year, revenue, orderCount);

  /// Create a copy of MonthlyRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyRevenueItemImplCopyWith<_$MonthlyRevenueItemImpl> get copyWith =>
      __$$MonthlyRevenueItemImplCopyWithImpl<_$MonthlyRevenueItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyRevenueItemImplToJson(this);
  }
}

abstract class _MonthlyRevenueItem implements MonthlyRevenueItem {
  const factory _MonthlyRevenueItem({
    required final String month,
    required final int year,
    required final double revenue,
    required final int orderCount,
  }) = _$MonthlyRevenueItemImpl;

  factory _MonthlyRevenueItem.fromJson(Map<String, dynamic> json) =
      _$MonthlyRevenueItemImpl.fromJson;

  @override
  String get month;
  @override
  int get year;
  @override
  double get revenue;
  @override
  int get orderCount;

  /// Create a copy of MonthlyRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyRevenueItemImplCopyWith<_$MonthlyRevenueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryRevenueItem _$CategoryRevenueItemFromJson(Map<String, dynamic> json) {
  return _CategoryRevenueItem.fromJson(json);
}

/// @nodoc
mixin _$CategoryRevenueItem {
  String get categoryName => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  int get itemsSold => throw _privateConstructorUsedError;

  /// Serializes this CategoryRevenueItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryRevenueItemCopyWith<CategoryRevenueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryRevenueItemCopyWith<$Res> {
  factory $CategoryRevenueItemCopyWith(
    CategoryRevenueItem value,
    $Res Function(CategoryRevenueItem) then,
  ) = _$CategoryRevenueItemCopyWithImpl<$Res, CategoryRevenueItem>;
  @useResult
  $Res call({String categoryName, double revenue, int itemsSold});
}

/// @nodoc
class _$CategoryRevenueItemCopyWithImpl<$Res, $Val extends CategoryRevenueItem>
    implements $CategoryRevenueItemCopyWith<$Res> {
  _$CategoryRevenueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? revenue = null,
    Object? itemsSold = null,
  }) {
    return _then(
      _value.copyWith(
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as double,
            itemsSold: null == itemsSold
                ? _value.itemsSold
                : itemsSold // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryRevenueItemImplCopyWith<$Res>
    implements $CategoryRevenueItemCopyWith<$Res> {
  factory _$$CategoryRevenueItemImplCopyWith(
    _$CategoryRevenueItemImpl value,
    $Res Function(_$CategoryRevenueItemImpl) then,
  ) = __$$CategoryRevenueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categoryName, double revenue, int itemsSold});
}

/// @nodoc
class __$$CategoryRevenueItemImplCopyWithImpl<$Res>
    extends _$CategoryRevenueItemCopyWithImpl<$Res, _$CategoryRevenueItemImpl>
    implements _$$CategoryRevenueItemImplCopyWith<$Res> {
  __$$CategoryRevenueItemImplCopyWithImpl(
    _$CategoryRevenueItemImpl _value,
    $Res Function(_$CategoryRevenueItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? revenue = null,
    Object? itemsSold = null,
  }) {
    return _then(
      _$CategoryRevenueItemImpl(
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as double,
        itemsSold: null == itemsSold
            ? _value.itemsSold
            : itemsSold // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryRevenueItemImpl implements _CategoryRevenueItem {
  const _$CategoryRevenueItemImpl({
    required this.categoryName,
    required this.revenue,
    required this.itemsSold,
  });

  factory _$CategoryRevenueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryRevenueItemImplFromJson(json);

  @override
  final String categoryName;
  @override
  final double revenue;
  @override
  final int itemsSold;

  @override
  String toString() {
    return 'CategoryRevenueItem(categoryName: $categoryName, revenue: $revenue, itemsSold: $itemsSold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryRevenueItemImpl &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.itemsSold, itemsSold) ||
                other.itemsSold == itemsSold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryName, revenue, itemsSold);

  /// Create a copy of CategoryRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryRevenueItemImplCopyWith<_$CategoryRevenueItemImpl> get copyWith =>
      __$$CategoryRevenueItemImplCopyWithImpl<_$CategoryRevenueItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryRevenueItemImplToJson(this);
  }
}

abstract class _CategoryRevenueItem implements CategoryRevenueItem {
  const factory _CategoryRevenueItem({
    required final String categoryName,
    required final double revenue,
    required final int itemsSold,
  }) = _$CategoryRevenueItemImpl;

  factory _CategoryRevenueItem.fromJson(Map<String, dynamic> json) =
      _$CategoryRevenueItemImpl.fromJson;

  @override
  String get categoryName;
  @override
  double get revenue;
  @override
  int get itemsSold;

  /// Create a copy of CategoryRevenueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryRevenueItemImplCopyWith<_$CategoryRevenueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
