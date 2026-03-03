import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required int id,
    required int userId,
    required String userFullName,
    required int rating,
    String? comment,
    required String reviewType,
    int? productId,
    String? productName,
    int? appointmentId,
    String? staffFullName,
    String? staffType,
    required DateTime createdAt,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
