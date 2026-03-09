import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_feed_item.freezed.dart';
part 'activity_feed_item.g.dart';

@freezed
class ActivityFeedItem with _$ActivityFeedItem {
  const factory ActivityFeedItem({
    required String type,
    required String message,
    required DateTime timestamp,
  }) = _ActivityFeedItem;

  factory ActivityFeedItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityFeedItemFromJson(json);
}
