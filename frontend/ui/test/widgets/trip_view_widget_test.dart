import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tripmeout/widgets/trip_view_widget.dart';

void main() {
  testWidgets('Showing the text on page correctly shows up',
      (WidgetTester tester) async {
    var tripViewWidget = TripViewWidget();
    await tester.pumpWidget(wrapForDirectionality(tripViewWidget));
    await tester.pumpAndSettle();

    // Should be everything on the view trip screen expanded...
    expect(find.text("Name of the Trip"), findsOneWidget);
    expect(find.text("Place 1"), findsOneWidget);
    expect(find.text("Place 2"), findsOneWidget);
    expect(find.text("Place 3"), findsOneWidget);
    expect(find.text("Place 4"), findsOneWidget);
    expect(find.text("Place 5"), findsOneWidget);
  });

  testWidgets('Showing the expanded Place correctly shows up',
      (WidgetTester tester) async {
    var tripViewWidget = TripViewWidget();
    await tester.pumpWidget(wrapForDirectionality(tripViewWidget));
    await tester.pumpAndSettle();

    expect(find.text("Name of the Trip"), findsOneWidget);
    expect(find.text("Place 1"), findsOneWidget);
    expect(find.text("Description"), findsNothing);
    expect(find.text("Foo"), findsNothing);
    expect(find.text("Bar"), findsNothing);
    expect(find.text("Baz"), findsNothing);

    await tester.tap(find.widgetWithText(ExpansionTile, "Place 1"));
    await tester.pumpAndSettle();

    //Shows expanded Place
    expect(find.text("Name of the Trip"), findsOneWidget);
    expect(find.text("Place 1"), findsOneWidget);
    expect(find.text("Description"), findsOneWidget);
    expect(find.text("Foo"), findsOneWidget);
    expect(find.text("Bar"), findsOneWidget);
    expect(find.text("Baz"), findsOneWidget);
  });

  testWidgets('Testing to see if the M T D toggle buttons work.',
      (WidgetTester tester) async {
    var tripViewWidget = TripViewWidget();
    await tester.pumpWidget(wrapForDirectionality(tripViewWidget));
    await tester.pumpAndSettle();

    expect(find.text("M"), findsOneWidget);
    expect(find.text("T"), findsOneWidget);
    expect(find.text("D"), findsOneWidget);

    ToggleButtons toggle1 = tester.firstWidget(
      find.widgetWithText(ToggleButtons, 'M'),
    );
    ToggleButtons toggle2 = tester.firstWidget(
      find.widgetWithText(ToggleButtons, 'T'),
    );
    ToggleButtons toggle3 = tester.firstWidget(
      find.widgetWithText(ToggleButtons, 'D'),
    );

    await tester.tap(find.widgetWithText(ToggleButtons, "M"));
    await tester.pumpAndSettle();

    expect(toggle1.isSelected, true);
    expect(toggle1.isSelected, false);
    expect(toggle1.isSelected, false);

    await tester.tap(find.widgetWithText(ToggleButtons, "T"));
    await tester.pumpAndSettle();

    expect(toggle1.isSelected, false);
    expect(toggle1.isSelected, true);
    expect(toggle1.isSelected, false);

    await tester.tap(find.widgetWithText(ToggleButtons, "D"));
    await tester.pumpAndSettle();

    expect(toggle1.isSelected, false);
    expect(toggle1.isSelected, false);
    expect(toggle1.isSelected, true);
  });
}

Widget wrapForDirectionality(Widget wrapped) {
  return MaterialApp(home: Scaffold(body: wrapped));
}
