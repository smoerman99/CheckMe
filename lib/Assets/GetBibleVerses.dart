import 'dart:convert';
import 'dart:math';
import 'package:checkit/Entities/DailyVerse.dart';
import 'package:http/http.dart' as http;

Future<DailyVerse> fetchBibleVerse() async {
  final _random = new Random();
  var listOfBibleVerses = ['JHN.3.16', 'ECC.12.13', '1CO.10.31'];

  Map<String, String> requestHeaders = {
    'api-key': '31b591ef3138872c7b3722d569a17477'
  };

  final response = await http.get(
      Uri.parse(
          'https://api.scripture.api.bible/v1/bibles/de4e12af7f28f599-02/verses/' +
              listOfBibleVerses[_random.nextInt(listOfBibleVerses.length)]),
      headers: requestHeaders);

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body) as Map<String, dynamic>;

    return DailyVerse.fromJson(json['data']);
  } else {
    return DailyVerse(
      bookId: 'PSA',
      content:
          'For as the heaven is high above the earth, so great is his mercy toward them that fear Him.',
      id: 'PSA.103.11',
      reference: 'Psalms 103:11',
    );

    // throw Exception('Failed to load DailyVerse');
  }
}
