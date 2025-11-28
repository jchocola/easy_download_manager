class TorrentTaskProgress {
  final double progress;
  final int downloaded;
  final int total;
  final double speed;
  final int peers;
  
  TorrentTaskProgress({
    required this.progress,
    required this.downloaded,
    required this.total,
    required this.speed,
    required this.peers,
  });
}