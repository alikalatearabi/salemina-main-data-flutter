import 'package:flutter/material.dart';
import 'package:main_app/screens/dashboard_page/weekly_consumption_card.dart';
import 'package:main_app/screens/dashboard_page/yearly_consumption_card.dart';
import 'daily_consumption_card.dart';
import 'monthly_consumption_card.dart';

class ConsumptionDetailsPage extends StatefulWidget {
  const ConsumptionDetailsPage({super.key});

  @override
  State<ConsumptionDetailsPage> createState() => _ConsumptionDetailsPageState();
}

class _ConsumptionDetailsPageState extends State<ConsumptionDetailsPage> {
  bool isComparisonEnabled = false;
  int selectedCategoryIndex = 0;
  int selectedPeriodIndex = 3;

  final double consumed = 12555;
  final double total = 55555;
  final double recommendedConsumption = 10000;

  final List<String> categories = ['سالم', 'متوسط', 'ناسالم'];
  final List<String> periods = ['سالانه', 'ماهانه', 'هفتگی', 'روزانه'];

  List<double> weeklyInitialValues = [10, 20, 15, 25, 18, 12, 22];
  List<double> weeklyCompareValues = [8, 18, 12, 22, 15, 10, 20];
  int currentDayIndex = 2;

  List<double> monthlyInitialValues = List.generate(30, (index) => index * 2.5 + 5);
  List<double> monthlyCompareValues = List.generate(30, (index) => index * 2 + 8);

  List<double> yearlyInitialValues = List.generate(365, (index) => index * index- 10);
  List<double> yearlyCompareValues = List.generate(365, (index) => index * -1*index*index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'جزئیات مصرف',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildToggleButtons(periods, selectedPeriodIndex, (index) {
              setState(() {
                selectedPeriodIndex = index;
              });
            }),
            const SizedBox(height: 16),
            _buildConsumptionCard(),
            const SizedBox(height: 16),
            _buildComparisonToggle(),
            const SizedBox(height: 16),
            _buildToggleButtons(categories, selectedCategoryIndex, (index) {
              setState(() {
                selectedCategoryIndex = index;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildConsumptionCard() {
    switch (selectedPeriodIndex) {
      case 0:
        return YearlyConsumptionChart(
          primaryValues: yearlyInitialValues,
          secondaryValues: isComparisonEnabled ? yearlyCompareValues : null,
          isComparisonMode: isComparisonEnabled,
        );
      case 1:
        return MonthlyConsumptionChart(
          primaryValues: monthlyInitialValues,
          secondaryValues: isComparisonEnabled ? monthlyCompareValues : null,
          isComparisonMode: isComparisonEnabled,
        );
      case 2:
        return WeeklyConsumptionCard(
          primaryValues: weeklyInitialValues,
          secondaryValues: isComparisonEnabled ? weeklyCompareValues : null,
          highlightedIndex: currentDayIndex,
          isComparisonMode: isComparisonEnabled,
        );
      case 3:
      default:
        return DailyConsumptionCard(
          consumed: consumed,
          total: total,
          recommendedConsumption: recommendedConsumption,
          isComparisonEnabled: isComparisonEnabled,
        );
    }
  }


  Widget _buildToggleButtons(List<String> items, int selectedIndex, Function(int) onSelect) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(8),
        isSelected: List.generate(items.length, (index) => index == selectedIndex),
        onPressed: (index) => onSelect(index),
        fillColor: Colors.white,
        selectedColor: Colors.black,
        color: Colors.black,
        borderColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        renderBorder: false,
        children: items.map((text) => _buildToggleButton(text, text == items[selectedIndex])).toList(),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 36,
      width: 70,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }


  Widget _buildComparisonToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isComparisonEnabled = !isComparisonEnabled;
        });
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'مقایسه مصرف پیشنهاد های سالمینا',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isComparisonEnabled,
              onChanged: (value) {
                setState(() {
                  isComparisonEnabled = value;
                });
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class ConsumptionData {
  final String label;
  final double value;
  final Color color;

  ConsumptionData(this.label, this.value, this.color);
}