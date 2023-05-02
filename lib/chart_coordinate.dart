import 'dart:math';
import 'dart:ui';

import 'package:simple_chart/typedef.dart';

class ChartCoordinate {
  const ChartCoordinate(this.inputData, this.canvasSize);

  final List<ChartEntry> inputData;
  final Size canvasSize;

  Offset toCanvasCoordinate({required int fromDataIndex}) {
    final x = calculateX(atIndex: fromDataIndex);
    final y = calculateY(yDataValue: inputData[fromDataIndex]['value']);
    print(y);
    return Offset(x, y);
  }

  double calculateX({required int atIndex}) {
    assert(atIndex >= 0);
    throwOnTooSmallInputData();
    final interval = canvasSize.width / (inputData.length - 1);
    return interval * atIndex;
  }

  double calculateY({required double yDataValue}) {
    final dataAxis = getMax() - getMin();
    final chartAxis = canvasSize.height;
    final scale = chartAxis / dataAxis;
    return (yDataValue - getMin()) * scale;
  }

  double getMax() => inputData
      .map((element) => element['value'] as double)
      .reduce((value, element) => max(value, element));

  double getMin() => inputData
      .map((element) => element['value'] as double)
      .reduce((value, element) => min(value, element));

  void throwOnTooSmallInputData() {
    if (inputData.length > 1) return;
    throw StateError("Chart input data must have a length greater than 1");
  }
}
