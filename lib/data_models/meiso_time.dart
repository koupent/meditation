import 'package:flutter/material.dart';

class MeisoTime {
  final int timeMinutes;
  final String timeDisplayString;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MeisoTime({
    @required this.timeMinutes,
    @required this.timeDisplayString,
  });

  MeisoTime copyWith({
    int timeMinutes,
    String timeDisplayString,
  }) {
    if ((timeMinutes == null || identical(timeMinutes, this.timeMinutes)) &&
        (timeDisplayString == null || identical(timeDisplayString, this.timeDisplayString))) {
      return this;
    }

    return new MeisoTime(
      timeMinutes: timeMinutes ?? this.timeMinutes,
      timeDisplayString: timeDisplayString ?? this.timeDisplayString,
    );
  }

  @override
  String toString() {
    return 'MeisoTime{timeMinutes: $timeMinutes, timeDisplayString: $timeDisplayString}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeisoTime &&
          runtimeType == other.runtimeType &&
          timeMinutes == other.timeMinutes &&
          timeDisplayString == other.timeDisplayString);

  @override
  int get hashCode => timeMinutes.hashCode ^ timeDisplayString.hashCode;

  factory MeisoTime.fromMap(Map<String, dynamic> map) {
    return new MeisoTime(
      timeMinutes: map['timeMinutes'] as int,
      timeDisplayString: map['timeDisplayString'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'timeMinutes': this.timeMinutes,
      'timeDisplayString': this.timeDisplayString,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
