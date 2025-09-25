import 'package:flutter/material.dart';

import '../../widgets/one_attribute_list.dart';
import '../../widgets/one_attribute_list_item.dart';

class RecentSearchScreen extends StatefulWidget {

  const RecentSearchScreen({super.key,});

  @override
  State<RecentSearchScreen> createState() => _RecentSearchScreenState();
}

class _RecentSearchScreenState extends State<RecentSearchScreen> {
  int selectedCategoryIndex = 0;

  final List<OneAttributeList> recentProducts = [
    OneAttributeList(
        imagePath: 'assets/milk.png',
        name: 'شیر پرچرب پگاه',
        indicator: 'کالری',
        weight: '150',
        value: '240 گرم'
    ),
    OneAttributeList(
        imagePath: 'assets/saghe.png',
        name: 'بیسکویت ساقه طلایی مینو',
        indicator: 'کالری',
        weight: '54',
        value: '12 گرم'
    ),
    OneAttributeList(
        imagePath: 'assets/coloche.png',
        name: 'کلوچه گردویی نادری',
        indicator: 'کالری',
        weight: '213',
        value: '50 گرم'
    ),
    OneAttributeList(
        imagePath: 'assets/yogurt.png',
        name: 'ماست کم چرب کاله',
        indicator: 'کالری',
        weight: '120',
        value: '150 گرم'
    ),
    OneAttributeList(
        imagePath: 'assets/dark_chocolate.png',
        name: 'شکلات تلخ 72٪ پارمیدا',
        indicator: 'کالری',
        weight: '155',
        value: '28 گرم'
    ),
  ];

  final List<String> categories = ['سالم', 'متوسط', 'ناسالم'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: Colors.white,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'جستجوهای اخیر',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          _buildToggleButtons(categories, selectedCategoryIndex, context, (index) {
            setState(() {
              selectedCategoryIndex = index;
            });
          }),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recentProducts.length,
              itemBuilder: (context, index) {
                return OneAttributeListItem(
                  product: recentProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons(List<String> items, int selectedIndex,BuildContext context, Function(int) onSelect) {
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
            .map((text) => _buildToggleButton(text, text == items[selectedIndex], isThreeItems,context))
            .toList(),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, bool isThreeItems,BuildContext context) {
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
}