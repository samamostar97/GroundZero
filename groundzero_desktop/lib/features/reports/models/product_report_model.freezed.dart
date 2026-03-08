// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductReportModel _$ProductReportModelFromJson(Map<String, dynamic> json) {
  return _ProductReportModel.fromJson(json);
}

/// @nodoc
mixin _$ProductReportModel {
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  int get totalProducts => throw _privateConstructorUsedError;
  int get outOfStockCount => throw _privateConstructorUsedError;
  List<BestSellerItem> get bestSellers => throw _privateConstructorUsedError;
  List<StockLevelItem> get stockLevels => throw _privateConstructorUsedError;
  List<LowStockAlertItem> get lowStockAlerts =>
      throw _privateConstructorUsedError;

  /// Serializes this ProductReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductReportModelCopyWith<ProductReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductReportModelCopyWith<$Res> {
  factory $ProductReportModelCopyWith(
    ProductReportModel value,
    $Res Function(ProductReportModel) then,
  ) = _$ProductReportModelCopyWithImpl<$Res, ProductReportModel>;
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalProducts,
    int outOfStockCount,
    List<BestSellerItem> bestSellers,
    List<StockLevelItem> stockLevels,
    List<LowStockAlertItem> lowStockAlerts,
  });
}

/// @nodoc
class _$ProductReportModelCopyWithImpl<$Res, $Val extends ProductReportModel>
    implements $ProductReportModelCopyWith<$Res> {
  _$ProductReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalProducts = null,
    Object? outOfStockCount = null,
    Object? bestSellers = null,
    Object? stockLevels = null,
    Object? lowStockAlerts = null,
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
            totalProducts: null == totalProducts
                ? _value.totalProducts
                : totalProducts // ignore: cast_nullable_to_non_nullable
                      as int,
            outOfStockCount: null == outOfStockCount
                ? _value.outOfStockCount
                : outOfStockCount // ignore: cast_nullable_to_non_nullable
                      as int,
            bestSellers: null == bestSellers
                ? _value.bestSellers
                : bestSellers // ignore: cast_nullable_to_non_nullable
                      as List<BestSellerItem>,
            stockLevels: null == stockLevels
                ? _value.stockLevels
                : stockLevels // ignore: cast_nullable_to_non_nullable
                      as List<StockLevelItem>,
            lowStockAlerts: null == lowStockAlerts
                ? _value.lowStockAlerts
                : lowStockAlerts // ignore: cast_nullable_to_non_nullable
                      as List<LowStockAlertItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductReportModelImplCopyWith<$Res>
    implements $ProductReportModelCopyWith<$Res> {
  factory _$$ProductReportModelImplCopyWith(
    _$ProductReportModelImpl value,
    $Res Function(_$ProductReportModelImpl) then,
  ) = __$$ProductReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalProducts,
    int outOfStockCount,
    List<BestSellerItem> bestSellers,
    List<StockLevelItem> stockLevels,
    List<LowStockAlertItem> lowStockAlerts,
  });
}

/// @nodoc
class __$$ProductReportModelImplCopyWithImpl<$Res>
    extends _$ProductReportModelCopyWithImpl<$Res, _$ProductReportModelImpl>
    implements _$$ProductReportModelImplCopyWith<$Res> {
  __$$ProductReportModelImplCopyWithImpl(
    _$ProductReportModelImpl _value,
    $Res Function(_$ProductReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalProducts = null,
    Object? outOfStockCount = null,
    Object? bestSellers = null,
    Object? stockLevels = null,
    Object? lowStockAlerts = null,
  }) {
    return _then(
      _$ProductReportModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalProducts: null == totalProducts
            ? _value.totalProducts
            : totalProducts // ignore: cast_nullable_to_non_nullable
                  as int,
        outOfStockCount: null == outOfStockCount
            ? _value.outOfStockCount
            : outOfStockCount // ignore: cast_nullable_to_non_nullable
                  as int,
        bestSellers: null == bestSellers
            ? _value._bestSellers
            : bestSellers // ignore: cast_nullable_to_non_nullable
                  as List<BestSellerItem>,
        stockLevels: null == stockLevels
            ? _value._stockLevels
            : stockLevels // ignore: cast_nullable_to_non_nullable
                  as List<StockLevelItem>,
        lowStockAlerts: null == lowStockAlerts
            ? _value._lowStockAlerts
            : lowStockAlerts // ignore: cast_nullable_to_non_nullable
                  as List<LowStockAlertItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductReportModelImpl implements _ProductReportModel {
  const _$ProductReportModelImpl({
    required this.from,
    required this.to,
    required this.totalProducts,
    required this.outOfStockCount,
    required final List<BestSellerItem> bestSellers,
    required final List<StockLevelItem> stockLevels,
    required final List<LowStockAlertItem> lowStockAlerts,
  }) : _bestSellers = bestSellers,
       _stockLevels = stockLevels,
       _lowStockAlerts = lowStockAlerts;

  factory _$ProductReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductReportModelImplFromJson(json);

  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final int totalProducts;
  @override
  final int outOfStockCount;
  final List<BestSellerItem> _bestSellers;
  @override
  List<BestSellerItem> get bestSellers {
    if (_bestSellers is EqualUnmodifiableListView) return _bestSellers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bestSellers);
  }

  final List<StockLevelItem> _stockLevels;
  @override
  List<StockLevelItem> get stockLevels {
    if (_stockLevels is EqualUnmodifiableListView) return _stockLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stockLevels);
  }

  final List<LowStockAlertItem> _lowStockAlerts;
  @override
  List<LowStockAlertItem> get lowStockAlerts {
    if (_lowStockAlerts is EqualUnmodifiableListView) return _lowStockAlerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lowStockAlerts);
  }

  @override
  String toString() {
    return 'ProductReportModel(from: $from, to: $to, totalProducts: $totalProducts, outOfStockCount: $outOfStockCount, bestSellers: $bestSellers, stockLevels: $stockLevels, lowStockAlerts: $lowStockAlerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductReportModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            (identical(other.outOfStockCount, outOfStockCount) ||
                other.outOfStockCount == outOfStockCount) &&
            const DeepCollectionEquality().equals(
              other._bestSellers,
              _bestSellers,
            ) &&
            const DeepCollectionEquality().equals(
              other._stockLevels,
              _stockLevels,
            ) &&
            const DeepCollectionEquality().equals(
              other._lowStockAlerts,
              _lowStockAlerts,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    from,
    to,
    totalProducts,
    outOfStockCount,
    const DeepCollectionEquality().hash(_bestSellers),
    const DeepCollectionEquality().hash(_stockLevels),
    const DeepCollectionEquality().hash(_lowStockAlerts),
  );

  /// Create a copy of ProductReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductReportModelImplCopyWith<_$ProductReportModelImpl> get copyWith =>
      __$$ProductReportModelImplCopyWithImpl<_$ProductReportModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductReportModelImplToJson(this);
  }
}

abstract class _ProductReportModel implements ProductReportModel {
  const factory _ProductReportModel({
    required final DateTime from,
    required final DateTime to,
    required final int totalProducts,
    required final int outOfStockCount,
    required final List<BestSellerItem> bestSellers,
    required final List<StockLevelItem> stockLevels,
    required final List<LowStockAlertItem> lowStockAlerts,
  }) = _$ProductReportModelImpl;

  factory _ProductReportModel.fromJson(Map<String, dynamic> json) =
      _$ProductReportModelImpl.fromJson;

  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  int get totalProducts;
  @override
  int get outOfStockCount;
  @override
  List<BestSellerItem> get bestSellers;
  @override
  List<StockLevelItem> get stockLevels;
  @override
  List<LowStockAlertItem> get lowStockAlerts;

  /// Create a copy of ProductReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductReportModelImplCopyWith<_$ProductReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BestSellerItem _$BestSellerItemFromJson(Map<String, dynamic> json) {
  return _BestSellerItem.fromJson(json);
}

/// @nodoc
mixin _$BestSellerItem {
  String get productName => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get quantitySold => throw _privateConstructorUsedError;
  double get totalRevenue => throw _privateConstructorUsedError;

  /// Serializes this BestSellerItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BestSellerItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BestSellerItemCopyWith<BestSellerItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BestSellerItemCopyWith<$Res> {
  factory $BestSellerItemCopyWith(
    BestSellerItem value,
    $Res Function(BestSellerItem) then,
  ) = _$BestSellerItemCopyWithImpl<$Res, BestSellerItem>;
  @useResult
  $Res call({
    String productName,
    String categoryName,
    int quantitySold,
    double totalRevenue,
  });
}

/// @nodoc
class _$BestSellerItemCopyWithImpl<$Res, $Val extends BestSellerItem>
    implements $BestSellerItemCopyWith<$Res> {
  _$BestSellerItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BestSellerItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? quantitySold = null,
    Object? totalRevenue = null,
  }) {
    return _then(
      _value.copyWith(
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            quantitySold: null == quantitySold
                ? _value.quantitySold
                : quantitySold // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRevenue: null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BestSellerItemImplCopyWith<$Res>
    implements $BestSellerItemCopyWith<$Res> {
  factory _$$BestSellerItemImplCopyWith(
    _$BestSellerItemImpl value,
    $Res Function(_$BestSellerItemImpl) then,
  ) = __$$BestSellerItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productName,
    String categoryName,
    int quantitySold,
    double totalRevenue,
  });
}

/// @nodoc
class __$$BestSellerItemImplCopyWithImpl<$Res>
    extends _$BestSellerItemCopyWithImpl<$Res, _$BestSellerItemImpl>
    implements _$$BestSellerItemImplCopyWith<$Res> {
  __$$BestSellerItemImplCopyWithImpl(
    _$BestSellerItemImpl _value,
    $Res Function(_$BestSellerItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BestSellerItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? quantitySold = null,
    Object? totalRevenue = null,
  }) {
    return _then(
      _$BestSellerItemImpl(
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        quantitySold: null == quantitySold
            ? _value.quantitySold
            : quantitySold // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRevenue: null == totalRevenue
            ? _value.totalRevenue
            : totalRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BestSellerItemImpl implements _BestSellerItem {
  const _$BestSellerItemImpl({
    required this.productName,
    required this.categoryName,
    required this.quantitySold,
    required this.totalRevenue,
  });

  factory _$BestSellerItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BestSellerItemImplFromJson(json);

  @override
  final String productName;
  @override
  final String categoryName;
  @override
  final int quantitySold;
  @override
  final double totalRevenue;

  @override
  String toString() {
    return 'BestSellerItem(productName: $productName, categoryName: $categoryName, quantitySold: $quantitySold, totalRevenue: $totalRevenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BestSellerItemImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.quantitySold, quantitySold) ||
                other.quantitySold == quantitySold) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productName,
    categoryName,
    quantitySold,
    totalRevenue,
  );

  /// Create a copy of BestSellerItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BestSellerItemImplCopyWith<_$BestSellerItemImpl> get copyWith =>
      __$$BestSellerItemImplCopyWithImpl<_$BestSellerItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BestSellerItemImplToJson(this);
  }
}

abstract class _BestSellerItem implements BestSellerItem {
  const factory _BestSellerItem({
    required final String productName,
    required final String categoryName,
    required final int quantitySold,
    required final double totalRevenue,
  }) = _$BestSellerItemImpl;

  factory _BestSellerItem.fromJson(Map<String, dynamic> json) =
      _$BestSellerItemImpl.fromJson;

  @override
  String get productName;
  @override
  String get categoryName;
  @override
  int get quantitySold;
  @override
  double get totalRevenue;

  /// Create a copy of BestSellerItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BestSellerItemImplCopyWith<_$BestSellerItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StockLevelItem _$StockLevelItemFromJson(Map<String, dynamic> json) {
  return _StockLevelItem.fromJson(json);
}

/// @nodoc
mixin _$StockLevelItem {
  String get productName => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Serializes this StockLevelItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockLevelItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockLevelItemCopyWith<StockLevelItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockLevelItemCopyWith<$Res> {
  factory $StockLevelItemCopyWith(
    StockLevelItem value,
    $Res Function(StockLevelItem) then,
  ) = _$StockLevelItemCopyWithImpl<$Res, StockLevelItem>;
  @useResult
  $Res call({
    String productName,
    String categoryName,
    int stockQuantity,
    double price,
  });
}

/// @nodoc
class _$StockLevelItemCopyWithImpl<$Res, $Val extends StockLevelItem>
    implements $StockLevelItemCopyWith<$Res> {
  _$StockLevelItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockLevelItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? stockQuantity = null,
    Object? price = null,
  }) {
    return _then(
      _value.copyWith(
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StockLevelItemImplCopyWith<$Res>
    implements $StockLevelItemCopyWith<$Res> {
  factory _$$StockLevelItemImplCopyWith(
    _$StockLevelItemImpl value,
    $Res Function(_$StockLevelItemImpl) then,
  ) = __$$StockLevelItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productName,
    String categoryName,
    int stockQuantity,
    double price,
  });
}

/// @nodoc
class __$$StockLevelItemImplCopyWithImpl<$Res>
    extends _$StockLevelItemCopyWithImpl<$Res, _$StockLevelItemImpl>
    implements _$$StockLevelItemImplCopyWith<$Res> {
  __$$StockLevelItemImplCopyWithImpl(
    _$StockLevelItemImpl _value,
    $Res Function(_$StockLevelItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StockLevelItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? stockQuantity = null,
    Object? price = null,
  }) {
    return _then(
      _$StockLevelItemImpl(
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StockLevelItemImpl implements _StockLevelItem {
  const _$StockLevelItemImpl({
    required this.productName,
    required this.categoryName,
    required this.stockQuantity,
    required this.price,
  });

  factory _$StockLevelItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockLevelItemImplFromJson(json);

  @override
  final String productName;
  @override
  final String categoryName;
  @override
  final int stockQuantity;
  @override
  final double price;

  @override
  String toString() {
    return 'StockLevelItem(productName: $productName, categoryName: $categoryName, stockQuantity: $stockQuantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockLevelItemImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productName, categoryName, stockQuantity, price);

  /// Create a copy of StockLevelItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockLevelItemImplCopyWith<_$StockLevelItemImpl> get copyWith =>
      __$$StockLevelItemImplCopyWithImpl<_$StockLevelItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StockLevelItemImplToJson(this);
  }
}

abstract class _StockLevelItem implements StockLevelItem {
  const factory _StockLevelItem({
    required final String productName,
    required final String categoryName,
    required final int stockQuantity,
    required final double price,
  }) = _$StockLevelItemImpl;

  factory _StockLevelItem.fromJson(Map<String, dynamic> json) =
      _$StockLevelItemImpl.fromJson;

  @override
  String get productName;
  @override
  String get categoryName;
  @override
  int get stockQuantity;
  @override
  double get price;

  /// Create a copy of StockLevelItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockLevelItemImplCopyWith<_$StockLevelItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LowStockAlertItem _$LowStockAlertItemFromJson(Map<String, dynamic> json) {
  return _LowStockAlertItem.fromJson(json);
}

/// @nodoc
mixin _$LowStockAlertItem {
  String get productName => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;

  /// Serializes this LowStockAlertItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LowStockAlertItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LowStockAlertItemCopyWith<LowStockAlertItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LowStockAlertItemCopyWith<$Res> {
  factory $LowStockAlertItemCopyWith(
    LowStockAlertItem value,
    $Res Function(LowStockAlertItem) then,
  ) = _$LowStockAlertItemCopyWithImpl<$Res, LowStockAlertItem>;
  @useResult
  $Res call({String productName, String categoryName, int stockQuantity});
}

/// @nodoc
class _$LowStockAlertItemCopyWithImpl<$Res, $Val extends LowStockAlertItem>
    implements $LowStockAlertItemCopyWith<$Res> {
  _$LowStockAlertItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LowStockAlertItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? stockQuantity = null,
  }) {
    return _then(
      _value.copyWith(
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LowStockAlertItemImplCopyWith<$Res>
    implements $LowStockAlertItemCopyWith<$Res> {
  factory _$$LowStockAlertItemImplCopyWith(
    _$LowStockAlertItemImpl value,
    $Res Function(_$LowStockAlertItemImpl) then,
  ) = __$$LowStockAlertItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productName, String categoryName, int stockQuantity});
}

/// @nodoc
class __$$LowStockAlertItemImplCopyWithImpl<$Res>
    extends _$LowStockAlertItemCopyWithImpl<$Res, _$LowStockAlertItemImpl>
    implements _$$LowStockAlertItemImplCopyWith<$Res> {
  __$$LowStockAlertItemImplCopyWithImpl(
    _$LowStockAlertItemImpl _value,
    $Res Function(_$LowStockAlertItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LowStockAlertItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? categoryName = null,
    Object? stockQuantity = null,
  }) {
    return _then(
      _$LowStockAlertItemImpl(
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LowStockAlertItemImpl implements _LowStockAlertItem {
  const _$LowStockAlertItemImpl({
    required this.productName,
    required this.categoryName,
    required this.stockQuantity,
  });

  factory _$LowStockAlertItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LowStockAlertItemImplFromJson(json);

  @override
  final String productName;
  @override
  final String categoryName;
  @override
  final int stockQuantity;

  @override
  String toString() {
    return 'LowStockAlertItem(productName: $productName, categoryName: $categoryName, stockQuantity: $stockQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LowStockAlertItemImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productName, categoryName, stockQuantity);

  /// Create a copy of LowStockAlertItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LowStockAlertItemImplCopyWith<_$LowStockAlertItemImpl> get copyWith =>
      __$$LowStockAlertItemImplCopyWithImpl<_$LowStockAlertItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LowStockAlertItemImplToJson(this);
  }
}

abstract class _LowStockAlertItem implements LowStockAlertItem {
  const factory _LowStockAlertItem({
    required final String productName,
    required final String categoryName,
    required final int stockQuantity,
  }) = _$LowStockAlertItemImpl;

  factory _LowStockAlertItem.fromJson(Map<String, dynamic> json) =
      _$LowStockAlertItemImpl.fromJson;

  @override
  String get productName;
  @override
  String get categoryName;
  @override
  int get stockQuantity;

  /// Create a copy of LowStockAlertItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LowStockAlertItemImplCopyWith<_$LowStockAlertItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
