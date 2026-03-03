import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_review_request.freezed.dart';
part 'update_review_request.g.dart';

@freezed
class UpdateReviewRequest with _$UpdateReviewRequest {
  const factory UpdateReviewRequest({
    required int rating,
    String? comment,
  }) = _UpdateReviewRequest;

  factory UpdateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewRequestFromJson(json);
}
