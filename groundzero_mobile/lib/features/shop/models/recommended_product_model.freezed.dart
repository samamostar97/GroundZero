// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecommendedProductModel _$RecommendedProductModelFromJson(
  Map<String, dynamic> json,
) {
  return _RecommendedProductModel.fromJson(json);
}

/// @nodoc
mixin _$RecommendedProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get coPurchaseCount => throw _privateConstructorUsedError;

  /// Serializes this RecommendedProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedProductModelCopyWith<RecommendedProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedProductModelCopyWith<$Res> {
  factory $RecommendedProductModelCopyWith(
    RecommendedProductModel value,
    $Res Function(RecommendedProductModel) then,
  ) = _$RecommendedProductModelCopyWithImpl<$Res, RecommendedProductModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double price,
    String? imageUrl,
    int stockQuantity,
    int categoryId,
    String categoryName,
    DateTime createdAt,
    int coPurchaseCount,
  });
}

/// @nodoc
class _$RecommendedProductModelCopyWithImpl<
  $Res,
  $Val extends RecommendedProductModel
>
    implements $RecommendedProductModelCopyWith<$Res> {
  _$RecommendedProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stockQuantity = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? createdAt = null,
    Object? coPurchaseCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            coPurchaseCount: null == coPurchaseCount
                ? _value.coPurchaseCount
                : coPurchaseCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendedProductModelImplCopyWith<$Res>
    implements $RecommendedProductModelCopyWith<$Res> {
  factory _$$RecommendedProductModelImplCopyWith(
    _$RecommendedProductModelImpl value,
    $Res Function(_$RecommendedProductModelImpl) then,
  ) = __$$RecommendedProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double price,
    String? imageUrl,
    int stockQuantity,
    int categoryId,
    String categoryName,
    DateTime createdAt,
    int coPurchaseCount,
  });
}

/// @nodoc
class __$$RecommendedProductModelImplCopyWithImpl<$Res>
    extends
        _$RecommendedProductModelCopyWithImpl<
          $Res,
          _$RecommendedProductModelImpl
        >
    implements _$$RecommendedProductModelImplCopyWith<$Res> {
  __$$RecommendedProductModelImplCopyWithImpl(
    _$RecommendedProductModelImpl _value,
    $Res Function(_$RecommendedProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendedProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stockQuantity = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? createdAt = null,
    Object? coPurchaseCount = null,
  }) {
    return _then(
      _$RecommendedProductModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        coPurchaseCount: null == coPurchaseCount
            ? _value.coPurchaseCount
            : coPurchaseCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendedProductModelImpl implements _RecommendedProductModel {
  const _$RecommendedProductModelImpl({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.stockQuantity,
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.coPurchaseCount,
  });

  factory _$RecommendedProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendedProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final double price;
  @override
  final String? imageUrl;
  @override
  final int stockQuantity;
  @override
  final int categoryId;
  @override
  final String categoryName;
  @override
  final DateTime createdAt;
  @override
  final int coPurchaseCount;

  @override
  String toString() {
    return 'RecommendedProductModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, stockQuantity: $stockQuantity, categoryId: $categoryId, categoryName: $categoryName, createdAt: $createdAt, coPurchaseCount: $coPurchaseCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.coPurchaseCount, coPurchaseCount) ||
                other.coPurchaseCount == coPurchaseCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    imageUrl,
    stockQuantity,
    categoryId,
    categoryName,
    createdAt,
    coPurchaseCount,
  );

  /// Create a copy of RecommendedProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedProductModelImplCopyWith<_$RecommendedProductModelImpl>
  get copyWith =>
      __$$RecommendedProductModelImplCopyWithImpl<
        _$RecommendedProductModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendedProductModelImplToJson(this);
  }
}

abstract class _RecommendedProductModel implements RecommendedProductModel {
  const factory _RecommendedProductModel({
    required final int id,
    required final String name,
    final String? description,
    required final double price,
    final String? imageUrl,
    required final int stockQuantity,
    required final int categoryId,
    required final String categoryName,
    required final DateTime createdAt,
    required final int coPurchaseCount,
  }) = _$RecommendedProductModelImpl;

  factory _RecommendedProductModel.fromJson(Map<String, dynamic> json) =
      _$RecommendedProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get price;
  @override
  String? get imageUrl;
  @override
  int get stockQuantity;
  @override
  int get categoryId;
  @override
  String get categoryName;
  @override
  DateTime get createdAt;
  @override
  int get coPurchaseCount;

  /// Create a copy of RecommendedProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedProductModelImplCopyWith<_$RecommendedProductModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
