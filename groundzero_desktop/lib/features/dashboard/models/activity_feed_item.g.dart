// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityFeedItemImpl _$$ActivityFeedItemImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityFeedItemImpl(
  type: json['type'] as String,
  message: json['message'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$ActivityFeedItemImplToJson(
  _$ActivityFeedItemImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'message': instance.message,
  'timestamp': instance.timestamp.toIso8601String(),
};
