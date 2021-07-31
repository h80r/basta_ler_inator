extension TimeReading on DateTime {
  /// Returns the time as a string.
  ///
  /// Returns a string with the format "HH:MM:SS"
  String readableTime() {
    return '$hour:$minute:$second';
  }
}
