import 'package:http/http.dart' as http;
import 'package:meme_creator/model/meme_data.dart';

class MemeApi {
  String url = 'https://meme-api.com/gimme';
  Future<MemeData> generateMeme() async {
    final request = await http.get(Uri.parse(url));
    if (request.statusCode == 200) {
      MemeData memeData = memeDataFromJson(request.body);
      return memeData;
    } else {
      throw Exception('Something went Wrong');
    }
  }
}
