import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// main function which tells the app to run
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { // The myApp class extends StateLessWidget. Widgets are the elements from which every Flutter app is built (like React components). The app itself is even a widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier { // This defines the apps state. MyAppState defines the data the app needs to function. It extends the ChangeNotifier class, which means it can notify other widgets about state changes.
  var current = WordPair.random(); 

  void getNext() { // resassigns current with a new random WordPair. 
    current = WordPair.random(); 
    notifyListeners(); // calls notifyListeners (a method of ChangeNotifierProvider) to ensure anything watching MyAppState is notified
  }

  var favorites = <WordPair>[]; // empty list that expects WordPair type/class 
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
} // The state is created and provided using a ChangeNotifierProvider
//            My App
//              |
//            MyHomePage
//            /        \
//        Some Widget  Other Widgets

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // Every widget defines a build() method that's automatically called every time the widgets circumstances change so that the widget is always up to date.
    var appState = context.watch<MyAppState>(); // The widget tracks changes to the app's current state using the watch method
    var pair = appState.current; // Extracts appState.current into a seperate widget

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

  // Every build method must return a widget or (more typically) a series of widgets.
    return Scaffold(
      body: Center( // centers the column
        child: Column( // Column is one of the most basic layouts of Flutter. It takes any number of children and puts them in a columb from top to bottom. By default the column visually places its children at the top.
          mainAxisAlignment: MainAxisAlignment.center, // aligns the children of Column on its vertical/main axis
          children: [
           // Text('A random AWESOME idea:'), Text is well....text
            BigCard(pair: pair), // The second text takes the appState via the pair widget/variable and accesses only a member of that class, current (which in this case is WordPair). WordPair provides several helpful getters, such as asPascalCase or asSnakeCase or in this case asLowerCase
            SizedBox(height: 10), // adds seperation between widgets
            // Button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(onPressed: () {
                  appState.toggleFavorite();
                },
                  icon: Icon(icon), 
                  label: Text("Like"),
                  
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext(); //Calls the getNext method in appState
                  },
                  child: Text('Next')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // requests the apps current theme
    final style = theme.textTheme.displayMedium!.copyWith( // theme.textTheme accesses the apps font theme. That theme then has properties such as displayLarge, displayMedium, and displaySmall. The ! operator tells Dart to check if the property is null or not. Calling copyWith() returns a copy of the text style with the changes defined.
      color: theme.colorScheme.onPrimary,
    );

    return Card( // Wraps in a card widget
      color: theme.colorScheme.primary, // Defines the color to be the same as the colorSchemes primary color.
      child: Padding( // Wraps in a padding widget
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase, 
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}" // override for screen readers"
          ),
      ),
    );
  }
}