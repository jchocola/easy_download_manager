String TotalSizeConverter(int sizeInBytes) {
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  var size = sizeInBytes.toDouble();
  var suffixIndex = 0;

  while (size >= 1024 && suffixIndex < suffixes.length - 1) {
    size /= 1024;
    suffixIndex++;
  }

  return "${size.toStringAsFixed(2)} ${suffixes[suffixIndex]}";
}