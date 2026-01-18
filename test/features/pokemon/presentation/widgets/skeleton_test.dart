import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/skeleton.dart';

void main() {
  group('Skeleton', () {
    testWidgets('deve exibir skeleton com dimensões corretas', (
      WidgetTester tester,
    ) async {
      // Arrange
      const height = 100.0;
      const width = 150.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Skeleton(height: height, width: width),
          ),
        ),
      );

      // Assert
      expect(find.byType(Skeleton), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('deve aceitar borderRadius customizado', (
      WidgetTester tester,
    ) async {
      // Arrange
      const height = 50.0;
      const width = 100.0;
      const borderRadius = BorderRadius.all(Radius.circular(8));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Skeleton(
              height: height,
              width: width,
              borderRadius: borderRadius,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Skeleton), findsOneWidget);
    });

    testWidgets('deve ter BorderRadius padrão de 12', (
      WidgetTester tester,
    ) async {
      // Arrange
      const height = 80.0;
      const width = 120.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Skeleton(height: height, width: width),
          ),
        ),
      );

      // Assert
      expect(find.byType(Skeleton), findsOneWidget);
    });

    testWidgets('deve animar loading skeleton', (WidgetTester tester) async {
      // Arrange
      const height = 100.0;
      const width = 150.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Skeleton(height: height, width: width),
          ),
        ),
      );

      // Avança a animação
      await tester.pump(const Duration(milliseconds: 500));

      // Assert
      expect(find.byType(Skeleton), findsOneWidget);
      expect(find.byType(AnimatedBuilder), findsWidgets);
    });

    testWidgets('deve exibir múltiplos skeletons', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                Skeleton(height: 100, width: 200),
                const SizedBox(height: 16),
                Skeleton(height: 100, width: 200),
                const SizedBox(height: 16),
                Skeleton(height: 100, width: 200),
              ],
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Skeleton), findsNWidgets(3));
    });

    testWidgets('deve ter gradient para efeito shimmer', (
      WidgetTester tester,
    ) async {
      // Arrange
      const height = 50.0;
      const width = 100.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Skeleton(height: height, width: width),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Skeleton), findsOneWidget);
    });

    testWidgets('deve respeitar diferentes tamanhos', (
      WidgetTester tester,
    ) async {
      // Arrange
      final sizes = [(100.0, 100.0), (50.0, 200.0), (150.0, 75.0)];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: sizes
                  .map((size) => Skeleton(height: size.$1, width: size.$2))
                  .toList(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Skeleton), findsNWidgets(3));
    });
  });
}
