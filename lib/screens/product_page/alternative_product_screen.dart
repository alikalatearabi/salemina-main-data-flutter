import 'package:flutter/material.dart';

import 'alternative_product.dart';
import 'alternative_product_item.dart';

class AlternativeProductScreen extends StatefulWidget {

  AlternativeProductScreen({super.key,});

  @override
  State<AlternativeProductScreen> createState() => _AlternativeProductScreenState();
}

class _AlternativeProductScreenState extends State<AlternativeProductScreen> {
  int selectedCategoryIndex = 0;

  final List<AlternativeProduct> alternativeProducts = [
    AlternativeProduct(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk2.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/milk3.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      calories: '5555 کالری',
      weight: '145 گرم',
      values: {
        'چربی': '0.55 گرم',
        'اسید چرب': '0.55 گرم',
        'نمک': '0.55 گرم',
        'قند': '0.55 گرم',
      },
    ),
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
            'محصولات جایگزین',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 24.0,left: 24,bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: alternativeProducts.length,
                itemBuilder: (context, index) {
                  return AlternativeProductItem(
                    product: alternativeProducts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}