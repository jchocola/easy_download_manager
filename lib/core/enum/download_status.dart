enum DOWNLOAD_STATUS {
  QUEUED,
  DOWNLOADING,
  PAUSED,
  COMPLETED,
  FAILED,
  CANCELED,
}

DOWNLOAD_STATUS downloadStatusFromValue({required String value}) {
  switch (value) {
    case 'QUEUED':
      return DOWNLOAD_STATUS.QUEUED;
    case 'DOWNLOADING':
      return DOWNLOAD_STATUS.DOWNLOADING;
    case 'PAUSED':
      return DOWNLOAD_STATUS.PAUSED;
    case 'COMPLETED':
      return DOWNLOAD_STATUS.COMPLETED;
     case 'FAILED':
      return DOWNLOAD_STATUS.FAILED;  
    case 'CANCELED':
      return DOWNLOAD_STATUS.CANCELED;
    default:
       return DOWNLOAD_STATUS.CANCELED;
  }
}

