import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chart/chart_coordinate.dart';
import 'package:simple_chart/typedef.dart';

class MockInputData extends Fake implements List<ChartEntry> {
  MockInputData({required this.withLength});

  final int withLength;
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
}
