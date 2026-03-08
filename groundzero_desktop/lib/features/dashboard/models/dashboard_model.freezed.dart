// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) {
  return _DashboardModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardModel {
  int get currentlyInGym => throw _privateConstructorUsedError;
  int get pendingOrderCount => throw _privateConstructorUsedError;
  int get todayAppointments => throw _privateConstructorUsedError;
  int get newUsersThisMonth => throw _privateConstructorUsedError;
  List<ActiveGymVisitItem> get activeGymVisits =>
      throw _privateConstructorUsedError;
  List<PendingOrderItem> get pendingOrders =>
      throw _privateConstructorUsedError;

  /// Serializes this DashboardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardModelCopyWith<DashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardModelCopyWith<$Res> {
  factory $DashboardModelCopyWith(
    DashboardModel value,
    $Res Function(DashboardModel) then,
  ) = _$DashboardModelCopyWithImpl<$Res, DashboardModel>;
  @useResult
  $Res call({
    int currentlyInGym,
    int pendingOrderCount,
    int todayAppointments,
    int newUsersThisMonth,
    List<ActiveGymVisitItem> activeGymVisits,
    List<PendingOrderItem> pendingOrders,
  });
}

/// @nodoc
class _$DashboardModelCopyWithImpl<$Res, $Val extends DashboardModel>
    implements $DashboardModelCopyWith<$Res> {
  _$DashboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentlyInGym = null,
    Object? pendingOrderCount = null,
    Object? todayAppointments = null,
    Object? newUsersThisMonth = null,
    Object? activeGymVisits = null,
    Object? pendingOrders = null,
  }) {
    return _then(
      _value.copyWith(
            currentlyInGym: null == currentlyInGym
                ? _value.currentlyInGym
                : currentlyInGym // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingOrderCount: null == pendingOrderCount
                ? _value.pendingOrderCount
                : pendingOrderCount // ignore: cast_nullable_to_non_nullable
                      as int,
            todayAppointments: null == todayAppointments
                ? _value.todayAppointments
                : todayAppointments // ignore: cast_nullable_to_non_nullable
                      as int,
            newUsersThisMonth: null == newUsersThisMonth
                ? _value.newUsersThisMonth
                : newUsersThisMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            activeGymVisits: null == activeGymVisits
                ? _value.activeGymVisits
                : activeGymVisits // ignore: cast_nullable_to_non_nullable
                      as List<ActiveGymVisitItem>,
            pendingOrders: null == pendingOrders
                ? _value.pendingOrders
                : pendingOrders // ignore: cast_nullable_to_non_nullable
                      as List<PendingOrderItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardModelImplCopyWith<$Res>
    implements $DashboardModelCopyWith<$Res> {
  factory _$$DashboardModelImplCopyWith(
    _$DashboardModelImpl value,
    $Res Function(_$DashboardModelImpl) then,
  ) = __$$DashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentlyInGym,
    int pendingOrderCount,
    int todayAppointments,
    int newUsersThisMonth,
    List<ActiveGymVisitItem> activeGymVisits,
    List<PendingOrderItem> pendingOrders,
  });
}

/// @nodoc
class __$$DashboardModelImplCopyWithImpl<$Res>
    extends _$DashboardModelCopyWithImpl<$Res, _$DashboardModelImpl>
    implements _$$DashboardModelImplCopyWith<$Res> {
  __$$DashboardModelImplCopyWithImpl(
    _$DashboardModelImpl _value,
    $Res Function(_$DashboardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentlyInGym = null,
    Object? pendingOrderCount = null,
    Object? todayAppointments = null,
    Object? newUsersThisMonth = null,
    Object? activeGymVisits = null,
    Object? pendingOrders = null,
  }) {
    return _then(
      _$DashboardModelImpl(
        currentlyInGym: null == currentlyInGym
            ? _value.currentlyInGym
            : currentlyInGym // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingOrderCount: null == pendingOrderCount
            ? _value.pendingOrderCount
            : pendingOrderCount // ignore: cast_nullable_to_non_nullable
                  as int,
        todayAppointments: null == todayAppointments
            ? _value.todayAppointments
            : todayAppointments // ignore: cast_nullable_to_non_nullable
                  as int,
        newUsersThisMonth: null == newUsersThisMonth
            ? _value.newUsersThisMonth
            : newUsersThisMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        activeGymVisits: null == activeGymVisits
            ? _value._activeGymVisits
            : activeGymVisits // ignore: cast_nullable_to_non_nullable
                  as List<ActiveGymVisitItem>,
        pendingOrders: null == pendingOrders
            ? _value._pendingOrders
            : pendingOrders // ignore: cast_nullable_to_non_nullable
                  as List<PendingOrderItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardModelImpl implements _DashboardModel {
  const _$DashboardModelImpl({
    required this.currentlyInGym,
    required this.pendingOrderCount,
    required this.todayAppointments,
    required this.newUsersThisMonth,
    required final List<ActiveGymVisitItem> activeGymVisits,
    required final List<PendingOrderItem> pendingOrders,
  }) : _activeGymVisits = activeGymVisits,
       _pendingOrders = pendingOrders;

  factory _$DashboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardModelImplFromJson(json);

  @override
  final int currentlyInGym;
  @override
  final int pendingOrderCount;
  @override
  final int todayAppointments;
  @override
  final int newUsersThisMonth;
  final List<ActiveGymVisitItem> _activeGymVisits;
  @override
  List<ActiveGymVisitItem> get activeGymVisits {
    if (_activeGymVisits is EqualUnmodifiableListView) return _activeGymVisits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeGymVisits);
  }

  final List<PendingOrderItem> _pendingOrders;
  @override
  List<PendingOrderItem> get pendingOrders {
    if (_pendingOrders is EqualUnmodifiableListView) return _pendingOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingOrders);
  }

  @override
  String toString() {
    return 'DashboardModel(currentlyInGym: $currentlyInGym, pendingOrderCount: $pendingOrderCount, todayAppointments: $todayAppointments, newUsersThisMonth: $newUsersThisMonth, activeGymVisits: $activeGymVisits, pendingOrders: $pendingOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardModelImpl &&
            (identical(other.currentlyInGym, currentlyInGym) ||
                other.currentlyInGym == currentlyInGym) &&
            (identical(other.pendingOrderCount, pendingOrderCount) ||
                other.pendingOrderCount == pendingOrderCount) &&
            (identical(other.todayAppointments, todayAppointments) ||
                other.todayAppointments == todayAppointments) &&
            (identical(other.newUsersThisMonth, newUsersThisMonth) ||
                other.newUsersThisMonth == newUsersThisMonth) &&
            const DeepCollectionEquality().equals(
              other._activeGymVisits,
              _activeGymVisits,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingOrders,
              _pendingOrders,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentlyInGym,
    pendingOrderCount,
    todayAppointments,
    newUsersThisMonth,
    const DeepCollectionEquality().hash(_activeGymVisits),
    const DeepCollectionEquality().hash(_pendingOrders),
  );

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      __$$DashboardModelImplCopyWithImpl<_$DashboardModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardModelImplToJson(this);
  }
}

abstract class _DashboardModel implements DashboardModel {
  const factory _DashboardModel({
    required final int currentlyInGym,
    required final int pendingOrderCount,
    required final int todayAppointments,
    required final int newUsersThisMonth,
    required final List<ActiveGymVisitItem> activeGymVisits,
    required final List<PendingOrderItem> pendingOrders,
  }) = _$DashboardModelImpl;

  factory _DashboardModel.fromJson(Map<String, dynamic> json) =
      _$DashboardModelImpl.fromJson;

  @override
  int get currentlyInGym;
  @override
  int get pendingOrderCount;
  @override
  int get todayAppointments;
  @override
  int get newUsersThisMonth;
  @override
  List<ActiveGymVisitItem> get activeGymVisits;
  @override
  List<PendingOrderItem> get pendingOrders;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveGymVisitItem _$ActiveGymVisitItemFromJson(Map<String, dynamic> json) {
  return _ActiveGymVisitItem.fromJson(json);
}

/// @nodoc
mixin _$ActiveGymVisitItem {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get userFullName => throw _privateConstructorUsedError;
  DateTime get checkInAt => throw _privateConstructorUsedError;

  /// Serializes this ActiveGymVisitItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveGymVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveGymVisitItemCopyWith<ActiveGymVisitItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveGymVisitItemCopyWith<$Res> {
  factory $ActiveGymVisitItemCopyWith(
    ActiveGymVisitItem value,
    $Res Function(ActiveGymVisitItem) then,
  ) = _$ActiveGymVisitItemCopyWithImpl<$Res, ActiveGymVisitItem>;
  @useResult
  $Res call({int id, int userId, String userFullName, DateTime checkInAt});
}

/// @nodoc
class _$ActiveGymVisitItemCopyWithImpl<$Res, $Val extends ActiveGymVisitItem>
    implements $ActiveGymVisitItemCopyWith<$Res> {
  _$ActiveGymVisitItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveGymVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? checkInAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userFullName: null == userFullName
                ? _value.userFullName
                : userFullName // ignore: cast_nullable_to_non_nullable
                      as String,
            checkInAt: null == checkInAt
                ? _value.checkInAt
                : checkInAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActiveGymVisitItemImplCopyWith<$Res>
    implements $ActiveGymVisitItemCopyWith<$Res> {
  factory _$$ActiveGymVisitItemImplCopyWith(
    _$ActiveGymVisitItemImpl value,
    $Res Function(_$ActiveGymVisitItemImpl) then,
  ) = __$$ActiveGymVisitItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int userId, String userFullName, DateTime checkInAt});
}

/// @nodoc
class __$$ActiveGymVisitItemImplCopyWithImpl<$Res>
    extends _$ActiveGymVisitItemCopyWithImpl<$Res, _$ActiveGymVisitItemImpl>
    implements _$$ActiveGymVisitItemImplCopyWith<$Res> {
  __$$ActiveGymVisitItemImplCopyWithImpl(
    _$ActiveGymVisitItemImpl _value,
    $Res Function(_$ActiveGymVisitItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveGymVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? checkInAt = null,
  }) {
    return _then(
      _$ActiveGymVisitItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userFullName: null == userFullName
            ? _value.userFullName
            : userFullName // ignore: cast_nullable_to_non_nullable
                  as String,
        checkInAt: null == checkInAt
            ? _value.checkInAt
            : checkInAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveGymVisitItemImpl implements _ActiveGymVisitItem {
  const _$ActiveGymVisitItemImpl({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.checkInAt,
  });

  factory _$ActiveGymVisitItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveGymVisitItemImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String userFullName;
  @override
  final DateTime checkInAt;

  @override
  String toString() {
    return 'ActiveGymVisitItem(id: $id, userId: $userId, userFullName: $userFullName, checkInAt: $checkInAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveGymVisitItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.checkInAt, checkInAt) ||
                other.checkInAt == checkInAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, userFullName, checkInAt);

  /// Create a copy of ActiveGymVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveGymVisitItemImplCopyWith<_$ActiveGymVisitItemImpl> get copyWith =>
      __$$ActiveGymVisitItemImplCopyWithImpl<_$ActiveGymVisitItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveGymVisitItemImplToJson(this);
  }
}

abstract class _ActiveGymVisitItem implements ActiveGymVisitItem {
  const factory _ActiveGymVisitItem({
    required final int id,
    required final int userId,
    required final String userFullName,
    required final DateTime checkInAt,
  }) = _$ActiveGymVisitItemImpl;

  factory _ActiveGymVisitItem.fromJson(Map<String, dynamic> json) =
      _$ActiveGymVisitItemImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get userFullName;
  @override
  DateTime get checkInAt;

  /// Create a copy of ActiveGymVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveGymVisitItemImplCopyWith<_$ActiveGymVisitItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingOrderItem _$PendingOrderItemFromJson(Map<String, dynamic> json) {
  return _PendingOrderItem.fromJson(json);
}

/// @nodoc
mixin _$PendingOrderItem {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get userFullName => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PendingOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingOrderItemCopyWith<PendingOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingOrderItemCopyWith<$Res> {
  factory $PendingOrderItemCopyWith(
    PendingOrderItem value,
    $Res Function(PendingOrderItem) then,
  ) = _$PendingOrderItemCopyWithImpl<$Res, PendingOrderItem>;
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    double totalAmount,
    int itemCount,
    DateTime createdAt,
  });
}

/// @nodoc
class _$PendingOrderItemCopyWithImpl<$Res, $Val extends PendingOrderItem>
    implements $PendingOrderItemCopyWith<$Res> {
  _$PendingOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? totalAmount = null,
    Object? itemCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userFullName: null == userFullName
                ? _value.userFullName
                : userFullName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PendingOrderItemImplCopyWith<$Res>
    implements $PendingOrderItemCopyWith<$Res> {
  factory _$$PendingOrderItemImplCopyWith(
    _$PendingOrderItemImpl value,
    $Res Function(_$PendingOrderItemImpl) then,
  ) = __$$PendingOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    double totalAmount,
    int itemCount,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$PendingOrderItemImplCopyWithImpl<$Res>
    extends _$PendingOrderItemCopyWithImpl<$Res, _$PendingOrderItemImpl>
    implements _$$PendingOrderItemImplCopyWith<$Res> {
  __$$PendingOrderItemImplCopyWithImpl(
    _$PendingOrderItemImpl _value,
    $Res Function(_$PendingOrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PendingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? totalAmount = null,
    Object? itemCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$PendingOrderItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userFullName: null == userFullName
            ? _value.userFullName
            : userFullName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingOrderItemImpl implements _PendingOrderItem {
  const _$PendingOrderItemImpl({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.totalAmount,
    required this.itemCount,
    required this.createdAt,
  });

  factory _$PendingOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingOrderItemImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String userFullName;
  @override
  final double totalAmount;
  @override
  final int itemCount;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PendingOrderItem(id: $id, userId: $userId, userFullName: $userFullName, totalAmount: $totalAmount, itemCount: $itemCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    userFullName,
    totalAmount,
    itemCount,
    createdAt,
  );

  /// Create a copy of PendingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingOrderItemImplCopyWith<_$PendingOrderItemImpl> get copyWith =>
      __$$PendingOrderItemImplCopyWithImpl<_$PendingOrderItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingOrderItemImplToJson(this);
  }
}

abstract class _PendingOrderItem implements PendingOrderItem {
  const factory _PendingOrderItem({
    required final int id,
    required final int userId,
    required final String userFullName,
    required final double totalAmount,
    required final int itemCount,
    required final DateTime createdAt,
  }) = _$PendingOrderItemImpl;

  factory _PendingOrderItem.fromJson(Map<String, dynamic> json) =
      _$PendingOrderItemImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get userFullName;
  @override
  double get totalAmount;
  @override
  int get itemCount;
  @override
  DateTime get createdAt;

  /// Create a copy of PendingOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingOrderItemImplCopyWith<_$PendingOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
