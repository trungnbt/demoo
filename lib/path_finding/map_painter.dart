import 'package:flutter/material.dart';

class MapPainter extends CustomPainter {
  final List<List<int>> map;
  final List<int> startPoint;
  final List<int> endPoint;

  MapPainter(this.map, this.startPoint, this.endPoint);

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / map[0].length;
    final cellHeight = size.height / map.length;

    // Define arrow properties
    final arrowPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    arrowPath.moveTo(
        cellWidth * (startPoint[1] + 0.5),
        cellHeight *
            (startPoint[0] + 0.2)); // Start arrowhead at the top of start point
    arrowPath.lineTo(cellWidth * (endPoint[1] + 0.5),
        cellHeight * (endPoint[0] + 0.2)); // Draw line to end point

    // Draw the arrowhead triangle
    final triangleSize = cellWidth * 0.15;
    final arrowheadPath = Path();
    arrowheadPath.moveTo(
        cellWidth * (endPoint[1] + 0.5), cellHeight * (endPoint[0] + 0.2));
    arrowheadPath.lineTo(
      cellWidth * (endPoint[1] + 0.5) - triangleSize,
      cellHeight * (endPoint[0] + 0.2) - triangleSize,
    );
    arrowheadPath.lineTo(
      cellWidth * (endPoint[1] + 0.5) + triangleSize,
      cellHeight * (endPoint[0] + 0.2) - triangleSize,
    );
    arrowheadPath.close();

    // Draw the map
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        final cellValue = map[row][col];

        // Draw arrows for cells with value 2 (road)
        if (cellValue == 2) {
          final cellRect = Rect.fromLTWH(
            col * cellWidth,
            row * cellHeight,
            cellWidth,
            cellHeight,
          );
          canvas.drawRect(cellRect, arrowPaint);
        }
      }
    }

    // Draw the arrow from start to end point
    canvas.drawPath(arrowPath, arrowPaint);

    // Draw the arrowhead triangle at the end point
    canvas.drawPath(arrowheadPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
