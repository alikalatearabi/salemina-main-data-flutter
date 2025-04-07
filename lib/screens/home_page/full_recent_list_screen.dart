import 'package:flutter/material.dart';

import '../dashboard_page/recent_search.dart';
import '../dashboard_page/recent_search_item.dart';

class FullRecentListScreen extends StatelessWidget {

  FullRecentListScreen({super.key,});
  final List<RecentSearch> recentProducts = [
    RecentSearch(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
    ),
    RecentSearch(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
    ),
    RecentSearch(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
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
          return RecentSearchItem(
            product: recentProducts[index],
          );
        },
      ),
    );
  }
}