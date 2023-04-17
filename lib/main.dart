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
} // The state is created and provided using a ChangeNotifierProvider
//            My App
//              |
//            MyHomePage
//            /        \
//        Some Widget  Other Widgets

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // Every widget defines a build() method that's automatically called every time the widgets circumstances change so that the widget is always up to date.
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),

          // Button
          ElevatedButton(
            onPressed: () {
              print('button pressed');
            },
            child: Text('Next')
          ),
        ],
      ),
    );
  }
}