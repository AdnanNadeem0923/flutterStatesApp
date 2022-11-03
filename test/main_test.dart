// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_api/main.dart';



void main() {
  testWidgets('Material App testing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets('Testing App Bar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: StatesPage(),));
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Testing App Bar Text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: StatesPage()));
    expect(find.text('States App'), findsWidgets);
  });

  testWidgets('Testing Future builder', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childWidgetBuilder = FutureBuilder(builder: (context, snapshot) {
      final states = snapshot.data;
      if (snapshot.connectionState == ConnectionState.done) {
        if (states == null) {
          return const Text('data not found');
        }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: childWidgetBuilder,
      ),
    )
    );
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidgetBuilder), findsWidgets);
  });
  testWidgets('Testing List Tile', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childWidgetlistTile = ListTile();

    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: childWidgetlistTile,
      ),
    )
    );
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidgetlistTile), findsWidgets);
  });
  testWidgets('Testing Divider', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childWidgetDivider = Divider();

    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: childWidgetDivider,
      ),
    )
    );
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidgetDivider), findsWidgets);
  });
  testWidgets('Testing Center', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    expect(find.byType(Center), findsWidgets);
  });
  testWidgets('Testing circularProgressIndicator', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: StatesPage(),));
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });
  testWidgets('Testing Floating Action Button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: StatesPage(),));
    expect(find.byType(FloatingActionButton), findsNWidgets(1));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  });
  testWidgets('Testing Text Button', (WidgetTester tester) async {
    final childWidgetTextButton = TextButton(
      onPressed: () {

      },
      child: Text("Ok"),
    );


    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: childWidgetTextButton,
      ),
    )
    );

    expect(find.byWidget(childWidgetTextButton), findsWidgets);
  });
  testWidgets('Finding Text Feild', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    var Textfeild = find.text('State Capital');
  });
  testWidgets('Finding Text ', (WidgetTester tester) async {
    final Finder textState = find.text('New State');
  });
  testWidgets('Finding Text name ', (WidgetTester tester) async {
    final Finder textName = find.text('State Name');
  });
  testWidgets('Finding Text Capital', (WidgetTester tester) async {
    final Finder textCapital = find.text('State Capital');
  });
  testWidgets('Finding Alert Text', (WidgetTester tester) async {
    final Finder textAlert = find.text('State has been Added');
  });
  testWidgets('Finding Error Text', (WidgetTester tester) async {
    final Finder textError = find.text('Error Adding Employee');
  });
  testWidgets('Finding Button Text', (WidgetTester tester) async {
    final Finder textButton = find.text('Ok');
  });
  testWidgets('Finding Button save Text', (WidgetTester tester) async {
    final Finder textSave = find.text('save');
  });
  testWidgets('finds a specific Padding', (tester) async {
    const childWidget = Padding(padding: EdgeInsets.all(10));


    await tester.pumpWidget(Center(child: childWidget));


    expect(find.byWidget(childWidget), findsOneWidget);
  });
  testWidgets('finds a specific Column', (tester) async {
    final childWidgetcolumn = Column();


    await tester.pumpWidget(Padding(padding: EdgeInsets.all(10),
        child: childWidgetcolumn));


    expect(find.byWidget(childWidgetcolumn), findsOneWidget);
  });
  testWidgets('finds a specific instance TextFeild', (tester) async {
    final childWidgetText = TextField();


    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: childWidgetText,
      ),
    )
    );

    expect(find.byWidget(childWidgetText), findsWidgets);
  });
}
