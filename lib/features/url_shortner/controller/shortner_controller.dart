// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:url_shortener/features/url_shortner/repository/shortner_repository.dart';

final urlShortnerControllerProvider =
    StateNotifierProvider<ShortenController, String>((ref) {
  return ShortenController(
      shortnerRepository: ref.read(shortnerRepositoryProvider));
});

class ShortenController extends StateNotifier<String> {
  final ShortnerRepository _shortenRepository;

  ShortenController({
    required ShortnerRepository shortnerRepository,
  })  : _shortenRepository = shortnerRepository,
        super('Paste URL');

  void shortenUrl(String longUrl) async {
    final errorModel = await _shortenRepository.shortenURL(longUrl);

    if (errorModel.error == null) {
      state = errorModel.data.resultUrl;
    } else {
      Fluttertoast.showToast(msg: errorModel.error.toString());
    }
  }
}
