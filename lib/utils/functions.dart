String convertTimeFormat(int seconds) {
  Duration duration = Duration(seconds: seconds);
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String minutesString = twoDigits(duration.inMinutes);
  String secondsString = twoDigits(duration.inSeconds.remainder(60));
  return "$minutesString : $secondsString";
}
