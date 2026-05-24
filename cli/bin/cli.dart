import 'dart:io';
import 'package:http/http.dart'
    as http; // Add this import for making HTTP requests

const version = '1.1.0';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    String cliVersion = arguments.first;
    print('Dartpedia CLI version $version $cliVersion');
  } else if (arguments.first == 'wikipedia') {
    final inputArg = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArg);
  } else {
    printUsage();
  }
}

void printUsage() {
  // Add this new function
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide an article title to search for:");
    articleTitle = stdin.readLineSync() ?? '';

    if (articleTitle.isEmpty) {
      print("No article title provided. Exiting.");
      return;
    }
  } else {
    articleTitle = arguments.join(' ');
  }
  final articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

Future<String> getWikipediaArticle(String articleTitle) async {
  // final url = 'https://en.wikipedia.org/api/rest_v1/page/summary/$articleTitle';
  final url = Uri.https(
    'en.wikipedia.org', // Wikipedia API domain
    '/api/rest_v1/page/summary/$articleTitle', // API path for article summary
  );

  final response = await http.get(url);

  // fetch the article content from Wikipedia API
  if (response.statusCode == 200) {
    return response.body; // Return the article content
  }
  // Return an error message if the request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
