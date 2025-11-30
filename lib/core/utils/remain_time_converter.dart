String remainTimeConverter({
  required int totalSizeInBytes,
  required double currentSpeedInKiloBytes,
  required double progress,
}) {
  if (currentSpeedInKiloBytes <= 0) {
    return "∞";
  }

  final remainingBytes = totalSizeInBytes * (1 - progress);
  final secondsRemaining = remainingBytes / (currentSpeedInKiloBytes * 1024);

  final hours = secondsRemaining ~/ 3600;
  final minutes = (secondsRemaining % 3600) ~/ 60;
  final seconds = (secondsRemaining % 60).toInt();

  if (hours > 0) {
    return "${hours}h ${minutes}m ${seconds}s";
  } else if (minutes > 0) {
    return "${minutes}m ${seconds}s";
  } else {
    return "${seconds}s";
  }
}
