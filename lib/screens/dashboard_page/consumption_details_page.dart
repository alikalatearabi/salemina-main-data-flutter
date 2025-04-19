import 'package:flutter/material.dart';
import 'package:main_app/widgets/one_attribute_list.dart';
import 'package:main_app/widgets/one_attribute_list_item.dart';
import 'package:main_app/screens/dashboard_page/weekly_consumption_card.dart';
import 'package:main_app/screens/dashboard_page/yearly_consumption_card.dart';
import 'recent_search_screen.dart';
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

  List<double> yearlyInitialValues = List.generate(365, (index) => index * index - 10);
  List<double> yearlyCompareValues = List.generate(365, (index) => index * -1 * index * index + 1);

  final List<OneAttributeList> recentProducts = [
    OneAttributeList(
        imagePath: 'assets/milk.png',
        name: 'نام محصول در حالت خیلی طولانی ...',
        indicator: 'قند',
        weight: '145 گرم',
        value: '5555 گرم'),
    OneAttributeList(
        imagePath: 'assets/milk2.png',
        name: 'نام محصول در حالت خیلی طولانی ...',
        indicator: 'نمک',
        weight: '145 گرم',
        value: '5555 گرم'),
    OneAttributeList(
        imagePath: 'assets/milk3.png',
        name: 'نام محصول در حالت خیلی طولانی ...',
        indicator: 'اسید چرب',
        weight: '145 گرم',
        value: '5555 گرم'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'جزئیات مصرف',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildToggleButtons(periods, selectedPeriodIndex, (index) {
                setState(() {
                  selectedPeriodIndex = index;
                });
              }),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildConsumptionCard(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildComparisonToggle(),
              ),
              const SizedBox(height: 16),
              _buildToggleButtons(categories, selectedCategoryIndex, (index) {
                setState(() {
                  selectedCategoryIndex = index;
                });
              }),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecentSearchScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "مشاهده همه",
                            style: TextStyle(
                              color: Color(0xFF018A08),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Text(
                          "جستجوهای اخیر",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recentProducts.length,
                      itemBuilder: (context, index) {
                        return OneAttributeListItem(
                          product: recentProducts[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    final isThreeItems = items.length == 3;

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.88,
      height: MediaQuery.of(context).size.height * 0.05,
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
        children: items
            .map((text) => _buildToggleButton(text, text == items[selectedIndex], isThreeItems))
            .toList(),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, bool isThreeItems) {
    double width = isThreeItems
        ? MediaQuery.of(context).size.width * 0.285
        : MediaQuery.of(context).size.width * 0.21;

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.04,
      width: width,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)]
            : [],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
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
        height: MediaQuery.of(context).size.height * 0.061,
        decoration: BoxDecoration(
          color: isComparisonEnabled ? Color(0xFFD6ECD8) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isComparisonEnabled ? Color(0xFFD6ECD8) : Colors.grey,
            width: 1.5,
          ),
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
              activeColor: Color(0xFF018A08),
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
