import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Data Model for Chart Categories
class ChartCategory {
  final String name;
  final String province;
  final int value;
  final Color color;

  ChartCategory({
    required this.name,
    required this.province,
    required this.value,
    required this.color,
  });
}

// Main Pie Chart Widget
class CategoryPieChart extends StatelessWidget {
  final List<ChartCategory> chartData;

  const CategoryPieChart({Key? key, required this.chartData}) : super(key: key);

  int get totalValue {
    return chartData.fold(0, (sum, item) => sum + item.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chart Title
          const Text(
            'Jumlah Pengaduan berdasarkan Kategori',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          // Pie Chart
          SizedBox(
            height: 300,
            child: _StatelessPieChart(
              chartData: chartData,
              totalValue: totalValue,
            ),
          ),

          const SizedBox(height: 24),

          // Legend Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  'WARNA',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: const Text(
                    'KATEGORI',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 1, color: Colors.grey),

          // Legend Items
          ...chartData.map((category) => buildLegendItem(category)),
        ],
      ),
    );
  }

  Widget buildLegendItem(ChartCategory category) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: category.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 20),

          // Category info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  category.province,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Total value
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              category.value.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget to handle pie chart touch state
class _StatelessPieChart extends StatefulWidget {
  final List<ChartCategory> chartData;
  final int totalValue;

  const _StatelessPieChart({
    Key? key,
    required this.chartData,
    required this.totalValue,
  }) : super(key: key);

  @override
  State<_StatelessPieChart> createState() => _StatelessPieChartState();
}

class _StatelessPieChartState extends State<_StatelessPieChart> {
  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.chartData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 110.0 : 100.0;
      final category = widget.chartData[i];

      return PieChartSectionData(
        color: category.color,
        value: category.value.toDouble(),
        title: category.value.toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.6,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 0,
        sections: showingSections(),
      ),
    );
  }
}
