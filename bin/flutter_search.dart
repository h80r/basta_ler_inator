import 'package:web_scraper/web_scraper.dart';
import 'models/result.dart';

String queryParser(String query) {
  var parsedQuery = query.replaceFirst('basta ler ', '').replaceAll(' ', '+');
  return parsedQuery + '+site%3aapi.flutter.dev';
}

Future<List<Result>?> search(String query) async {
  final webScraper = WebScraper('https://bing.com');

  if (await webScraper.loadWebPage('/search?q=${queryParser(query)}')) {
    final descriptions = webScraper.getElement('div.b_caption > p', []);
    final titles = webScraper.getElement('div.b_title > h2 > a', ['href']);

    return List<Result>.generate(
      titles.length,
      (index) => Result(
        title: titles[index]['title'],
        description: descriptions[index]['title'],
        url: titles[index]['attributes']['href'],
      ),
    );
  }
}
