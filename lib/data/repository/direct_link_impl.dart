import 'package:direct_link/direct_link.dart';

class DirectLinkImpl {
  var directLink = DirectLink();

  Future<SiteModel> fetchDirectLink({required String url}) async {
    try {
      var result = await directLink.check(url);
      if (result == null) {
        throw Exception('Failed to fetch direct link');
      }
      
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
