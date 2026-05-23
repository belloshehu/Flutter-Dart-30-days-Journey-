import 'dart:io';

const version = '1.1.0';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    String cliVersion = arguments.first;
    print('Dartpedia CLI version $version $cliVersion');
  } else if (arguments.first == 'search') {
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

void searchWikipedia(List<String>? arguments) {
  final String artticelTile;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide an article title to search for:");
    artticelTile = stdin.readLineSync() ?? '';
  } else {
    artticelTile = arguments.join(' ');
  }
  print("Looking up an article about $artticelTile. Please wait...");
  print("Here ya go!");
  print("Pretend this to be the article content about $artticelTile.");
}
