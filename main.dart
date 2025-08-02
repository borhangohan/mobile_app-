import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // --- Primary Color Scheme ---
        // A Material 3 way to define colors. primarySwatch is for Material 2.
        // Using ColorScheme.fromSeed with a seed color automatically generates a harmonious palette.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, // Your primary "brand" color
          brightness: Brightness.light, // Or .dark for a dark theme
        ).copyWith(
          // You can explicitly set accent colors if the generated ones aren't quite right
          secondary: Colors.amber, // A bright accent color for some elements
        ),

        // --- Custom Typography (Text Theme) ---
        // Define how different text styles will look throughout your app
        textTheme: const TextTheme(
          // For the main counter number: large, bold, and uses primary color by default
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          // For smaller descriptive text (like "Current Value:")
          headlineMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 18.0),
          // For button text (though ElevatedButton will override some of this)
          labelLarge: TextStyle(fontSize: 20.0, color: Colors.white),
        ),

        // --- AppBar Styling ---
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // AppBar background color
          foregroundColor: Colors.white, // Text and icon color on the AppBar
          elevation: 4.0, // Shadow beneath the AppBar
          centerTitle: true, // Centers the title text
        ),

        // --- ElevatedButton (and other button types) Styling ---
        // This sets default styles for all ElevatedButton widgets
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Default button background
            foregroundColor: Colors.white, // Default button text/icon color
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Internal padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Button text style
          ),
        ),
      ),
      // Optional: Hide the debug banner (good for presentation)
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() { // setState is crucial to update the UI
      if (_counter > 0) { // Only decrement if the counter is greater than 0
        _counter--;
      }
      // Optional: You could add a message here if you try to go below zero
      // For now, it just stops at 0 silently.
    });
  }

  void _resetCounter() {
    setState(() { // setState is crucial to update the UI
      _counter = 0; // Simply set the counter back to 0
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the defined text styles from the theme for easy use
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Optional: Dynamically change background color based on counter value
      backgroundColor: _counter % 3 == 0
          ? Colors.grey[100] // Light grey for multiples of 3
          : Colors.white, // White otherwise (this can be customized)
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // The Reset button remains in the AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounter,
            tooltip: 'Reset Counter',
          ),
          const SizedBox(width: 8), // Some spacing from the edge
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the column content
          children: <Widget>[
            Text(
              'Current Value:',
              style: textTheme.bodyMedium, // Uses the medium body text style from theme
            ),
            const SizedBox(height: 10), // Small space

            // The main counter display - now uses the large display style
            Text(
              '$_counter',
              style: textTheme.displayLarge, // Applies the large, bold style defined in the theme
            ),
            const SizedBox(height: 50), // More space between counter and buttons

            // --- Buttons: Arranged in a Row below the counter ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Horizontally centers the buttons in the row
              children: <Widget>[
                // Subtract Button
                ElevatedButton.icon(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove_circle_outline), // A suitable icon for subtraction
                  label: const Text('Subtract'),
                  // Override the default ElevatedButton theme for this button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary, // Uses the accent color
                    foregroundColor: Colors.black87, // Text color for this button (contrasts with amber)
                  ),
                ),
                const SizedBox(width: 30), // Adds horizontal space between buttons
                // Add Button
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add_circle_outline), // A suitable icon for addition
                  label: const Text('Add'),
                  // This button will use the default ElevatedButton style defined in MyApp's theme
                ),
              ],
            ),
            const SizedBox(height: 30), // Space below buttons

            // --- Optional: Contextual message based on counter value ---
            // This is an example of an optional enhancement from the requirements
            if (_counter % 2 == 0) // Check if the number is even
              Text(
                'This is an even number!',
                style: textTheme.bodyMedium?.copyWith(color: Colors.green), // Green text for even
              )
            else // If not even, it's odd
              Text(
                'This is an odd number!',
                style: textTheme.bodyMedium?.copyWith(color: Colors.red), // Red text for odd
              ),
          ],
        ),
      ),
      // We no longer need the floatingActionButton property here because our buttons
      // are now placed directly in the body using a Row widget.
      // floatingActionButton: ... // REMOVE THIS ENTIRE BLOCK IF IT'S STILL THERE
      // floatingActionButtonLocation: ... // REMOVE THIS LINE TOO
    );
  }
}
