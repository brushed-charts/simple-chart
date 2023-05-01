// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:simple_chart/typedef.dart';

// class LineDraw {
//   LineDraw(this._data);

//   final List<ChartEntry> _data;
//   late Canvas _canvas;
//   late Size _size;

//   void draw(Canvas canvas, Size size) {
//     _canvas = canvas;
//     _size = size;
//     for (var i = 1; i < _data.length; i++) {
//       throwOnNotFoundField(_data[i]);
//       _drawSegement(i);
//     }
//   }

//   void _drawSegement(int currentIndex) {
//     final previousX = _calculateXPosition(currentIndex - 1);
//     final currentX = _calculateXPosition(currentIndex);

//     // _canvas.drawLine(previousEntry['value'], currentEntry['value'],
//     //     Paint()..color = Colors.blue);
//   }

//   void throwOnNotFoundField(ChartEntry entry) {
//     if (!entry.containsKey('value')) {
//       throw FormatException(
//           "Input data given to SimpleChart is not in correct format."
//           "'value' field is missing. inputData: \n$entry");
//     }
//     if (entry['value'].runtimeType is! double) {
//       throw FormatException(
//           "Input data for 'value' field is not of type 'double': \n$entry");
//     }
//   }
// }
