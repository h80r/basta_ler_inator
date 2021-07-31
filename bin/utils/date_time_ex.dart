extension TimeReading on DateTime {
  String readableTime() {
    return '$hour:$minute:$second';
  }
}
