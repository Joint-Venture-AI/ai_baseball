import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Define a simple data class
class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

// Sample data for the three charts (adjust y-values for different shapes)
final List<ChartData> chartData1 = [
  ChartData(0, 15),
  ChartData(1, 45),
  ChartData(2, 30),
  ChartData(3, 55), // Higher peak
  ChartData(4, 25),
  ChartData(5, 40),
  ChartData(6, 10),
];

final List<ChartData> chartData2 = [
  ChartData(0, 25), // Starts higher
  ChartData(1, 35),
  ChartData(2, 45), // Flatter top
  ChartData(3, 40),
  ChartData(4, 50),
  ChartData(5, 30),
  ChartData(6, 35), // Ends higher
];

final List<ChartData> chartData3 = [
  ChartData(0, 10),
  ChartData(1, 40),
  ChartData(2, 50), // Peak shifted
  ChartData(3, 35),
  ChartData(4, 45),
  ChartData(5, 20),
  ChartData(6, 30),
];

// Define your colors (adjust as needed to match the image)
const Color primaryYellow = Color(0xFFD4AF37); // Example: Gold-like yellow
const Color textSecondary = Colors.grey;
final Color chartContainerBackground = Colors.grey.shade800.withOpacity(
  0.6,
); // Darker grey bg
final Color chartBackground = Colors.transparent; // Chart area transparent
