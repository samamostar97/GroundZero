import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_review_request.freezed.dart';
part 'create_review_request.g.dart';

@freezed
class CreateReviewRequest with _$CreateReviewRequest {
  const factory CreateReviewRequest({
    required int rating,
    String? comment,
    required int reviewType, // 0 = Product, 1 = Appointment
    int? productId,
    int? appointmentId,
  }) = _CreateReviewRequest;

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
}
