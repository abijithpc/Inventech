import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Product_Page/data/Datasource/product_local_datasource.dart';
import 'package:inventech/Product_Page/data/Model/product_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required this.size});
  final Size size;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Future<List<ProductModel>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = ProductLocalDatasource().getProducts();
  }

  String _monthLabel(String date) {
    final parts = date.split('-');
    final monthNum = int.parse(parts[1]);
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${monthNames[monthNum - 1]} '${parts[0].substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!;
        final totalCount = products.length;

        final Map<String, int> monthlyCount = {};
        for (var product in products) {
          final key =
              "${product.createdAt.year}-${product.createdAt.month.toString().padLeft(2, '0')}";
          monthlyCount[key] = (monthlyCount[key] ?? 0) + 1;
        }

        final sortedKeys = monthlyCount.keys.toList()..sort();
        final colors = [
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.purple,
          Colors.red,
          Colors.indigo,
          Colors.teal,
          Colors.pink,
          Colors.cyan,
          Colors.brown,
          Colors.lime,
          Colors.amber,
        ];

        final pieSections =
            sortedKeys.asMap().entries.map((entry) {
              final index = entry.key;
              final key = entry.value;
              final count = monthlyCount[key]!;
              final percentage = (count / totalCount) * 100;

              return PieChartSectionData(
                color: colors[index % colors.length],
                value: count.toDouble(),
                title: '$count',
                radius: 70,
                titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList();

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 105, 20, 25),
          child: Column(
            children: [
              // Total Products Card
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: widget.size.width * 0.75,
                  height: widget.size.height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withAlpha(50),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Products',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: kBlack,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$totalCount',
                        style: GoogleFonts.robotoMono(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Pie Chart
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(120),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Monthly Product Distribution',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 250,
                      child: PieChart(
                        PieChartData(
                          sections: pieSections,
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Legend
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          sortedKeys.asMap().entries.map((entry) {
                            final index = entry.key;
                            final label = _monthLabel(entry.value);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  color: colors[index % colors.length],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  label,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 10),
                              ],
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
