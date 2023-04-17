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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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


  // Every build method must return a widget or (more typically) a series of widgets.
    return Scaffold(
      body: Column( // Column is one of the most basic layouts of Flutter. It takes any number of children and puts them in a columb from top to bottom. By default the column visually places its children at the top.
        children: [
          Text('A random AWESOME idea:'), // Text is well....text
          Text(pair.asLowerCase), // The second text takes the appState via the pair widget/variable and accesses only a member of that class, current (which in this case is WordPair). WordPair provides several helpful getters, such as asPascalCase or asSnakeCase or in this case asLowerCase

          // Button
          ElevatedButton(
            onPressed: () {
              appState.getNext(); //Calls the getNext method in appState
            },
            child: Text('Next')
          ),
        ],
      ),
    );
  }
}