// ignore_for_file: constant_identifier_names, camel_case_types

enum DOWNLOAD_METHOD { HTTP_HTTPS, TORRENT, SOCIAL }

DOWNLOAD_METHOD downloadMethodFromValue({required String value}) {
  switch (value) {
    case 'HTTP_HTTPS':
      return DOWNLOAD_METHOD.HTTP_HTTPS;
    case 'TORRENT':
      return DOWNLOAD_METHOD.TORRENT;
    case 'SOCIAL':
      return DOWNLOAD_METHOD.SOCIAL;
    default :
       return DOWNLOAD_METHOD.HTTP_HTTPS; 
  }
}
