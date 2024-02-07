import 'package:core/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_session.freezed.dart';
part 'profile_session.g.dart';

@freezed
class ProfileSession with _$ProfileSession {

  factory ProfileSession({
    required String token,
    @TimestampDateTimeSerializer()
    required DateTime createdAt,
    required bool valid,
  }) = _ProfileSession;

  factory ProfileSession.fromJson(Map<String, dynamic> json) => _$ProfileSessionFromJson(json);
}