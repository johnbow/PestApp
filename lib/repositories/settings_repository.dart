// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  bool noConsecutivePest;
  bool expressRound;
  bool showAnimations;
  int animationFrameDurationMs;

  int? lastPest;

  Settings({
    this.noConsecutivePest = false,
    this.expressRound = false,
    this.showAnimations = true,
    this.animationFrameDurationMs = 300,
  });

  Settings copyWith({
    bool? noConsecutivePest,
    bool? expressRound,
    bool? showAnimations,
    int? animationFrameDurationMs,
  }) {
    return Settings(
      noConsecutivePest: noConsecutivePest ?? this.noConsecutivePest,
      expressRound: expressRound ?? this.expressRound,
      showAnimations: showAnimations ?? this.showAnimations,
      animationFrameDurationMs:
          animationFrameDurationMs ?? this.animationFrameDurationMs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'noConsecutivePest': noConsecutivePest,
      'expressRound': expressRound,
      'showAnimations': showAnimations,
      'animationFrameDurationMs': animationFrameDurationMs,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      noConsecutivePest: map['noConsecutivePest'] as bool,
      expressRound: map['expressRound'] as bool,
      showAnimations: map['showAnimations'] as bool,
      animationFrameDurationMs: map['animationFrameDurationMs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settings(noConsecutivePest: $noConsecutivePest, expressRound: $expressRound, showAnimations: $showAnimations, animationFrameDurationMs: $animationFrameDurationMs)';
  }

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;

    return other.noConsecutivePest == noConsecutivePest &&
        other.expressRound == expressRound &&
        other.showAnimations == showAnimations &&
        other.animationFrameDurationMs == animationFrameDurationMs;
  }

  @override
  int get hashCode {
    return noConsecutivePest.hashCode ^
        expressRound.hashCode ^
        showAnimations.hashCode ^
        animationFrameDurationMs.hashCode;
  }
}
