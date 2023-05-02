import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chart/chart_coordinate.dart';
import 'package:simple_chart/typedef.dart';

class MockInputData extends Fake implements List<ChartEntry> {
  MockInputData({int? withLength}) : withLength = withLength ?? 4;

  final int withLength;
  @override
  int get length => withLength;
}

void main() {
  test('Check x position values depending on data index', () {
    final inputData = MockInputData(withLength: 4);
    final coord = ChartCoordinate(inputData, const Size(1000, 0));
    expect(inputData.length, 4);
    expect(coord.calculateX(atIndex: 0), 1000 / 3 * 0);
    expect(coord.calculateX(atIndex: 1), 1000 / 3 * 1);
    expect(coord.calculateX(atIndex: 2), 1000 / 3 * 2);
    expect(coord.calculateX(atIndex: 3), 1000);
  });

  test('Check x position calculation throw when input data is less than 2', () {
    final inputData = MockInputData(withLength: 1);
    final coord = ChartCoordinate(inputData, const Size(1000, 0));
    expect(() => coord.calculateX(atIndex: 0), throwsStateError);
  });

  test("Check calculate min / max from input data is correct", () {
    var coord = const ChartCoordinate([
      {'value': -10.2},
      {'value': 500.0},
      {'value': 100.0},
      {'value': 1.000001}
    ], Size.zero);
    expect(coord.getMax(), 500);
    expect(coord.getMin(), -10.2);
  });

  group("Check position of data value to Y chart axis", () {
    test("when values are smalls", () {
      const coord = ChartCoordinate([
        {'value': 1.01},
        {'value': 1.11},
      ], Size(100, 1000));
      expect(coord.calculateY(yDataValue: 1.01).round(), 0);
      expect(coord.calculateY(yDataValue: 1.11).round(), 1000);
      expect(coord.calculateY(yDataValue: 1.06).round(), 500);
    });
    test("when values are bigger", () {
      const coord = ChartCoordinate([
        {'value': 6000.0},
        {'value': 10000.0},
      ], Size(100, 1000));
      expect(coord.calculateY(yDataValue: 6000.0).round(), 0);
      expect(coord.calculateY(yDataValue: 10000.0).round(), 1000);
      expect(coord.calculateY(yDataValue: 8000.0).round(), 500);
      expect(coord.calculateY(yDataValue: 7000.0).round(), 250);
    });
  });

  test("Check if data value convertion to canvas coordinate is correct", () {
    const coord = ChartCoordinate([
      {'value': 0.0},
      {'value': 20.0},
      {'value': 30.0},
      {'value': 40.0},
      {'value': 50.0}
    ], Size(100, 1000));
    expect(coord.toCanvasCoordinate(fromDataIndex: 0), const Offset(0, 0));
    expect(coord.toCanvasCoordinate(fromDataIndex: 1), const Offset(25, 400));
    expect(coord.toCanvasCoordinate(fromDataIndex: 2), const Offset(50, 600));
    expect(coord.toCanvasCoordinate(fromDataIndex: 3), const Offset(75, 800));
    expect(coord.toCanvasCoordinate(fromDataIndex: 4), const Offset(100, 1000));
  });
}
