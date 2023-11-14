import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import 'package:url_shortener/core/constants.dart';
import 'package:url_shortener/model/shorten_url_model.dart';

import '../../../model/error_model.dart';

final shortnerRepositoryProvider = Provider((ref) {
  return ShortnerRepository(client: Client());
});

class ShortnerRepository {
  final Client _client;
  ShortnerRepository({
    required Client client,
  }) : _client = client;
  Future<ErrorModel> shortenURL(String longUrl) async {
    ErrorModel error;
    try {
      var body = {"url": longUrl};
      final res = await _client.post(
        Uri.parse(apiURL),
        body: body,
      );

      switch (res.statusCode) {
        case 200:
          final shortUrl = shotenUrlModelFromJson(res.body);
          error = ErrorModel(null, shortUrl);
          break;
        default:
          throw 'some error occoures';
      }
    } catch (e) {
      error = ErrorModel(e.toString(), null);
    }
    return error;
  }
}
