import 'package:flutter/material.dart';

import '../../widgets/one_attribute_list.dart';
import '../../widgets/one_attribute_list_item.dart';

class RecentSearchScreen extends StatelessWidget {

  RecentSearchScreen({super.key,});
  final List<OneAttributeList> recentProducts = [
    OneAttributeList(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      indicator: 'کالری',
      weight: '145',
      value: '5555 گرم'
    ),
    OneAttributeList(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      indicator: 'کالری',
      weight: '145 گرم',
      value: '5555 گرم'
    ),
    OneAttributeList(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      indicator: 'کالری',
      weight: '145 گرم',
      value: '5555 گرم'
    ),
  ];

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recentProducts.length,
        itemBuilder: (context, index) {
          return OneAttributeListItem(
            product: recentProducts[index],
          );
        },
      ),
    );
  }
}