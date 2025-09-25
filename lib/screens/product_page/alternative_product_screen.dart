import 'package:flutter/material.dart';

import 'alternative_product.dart';
import 'alternative_product_item.dart';

class AlternativeProductScreen extends StatefulWidget {

  const AlternativeProductScreen({super.key,});

  @override
  State<AlternativeProductScreen> createState() => _AlternativeProductScreenState();
}

class _AlternativeProductScreenState extends State<AlternativeProductScreen> {
  int selectedCategoryIndex = 0;

  final List<AlternativeProduct> alternativeProducts = [
    AlternativeProduct(
      imagePath: 'assets/milk.png',
      name: 'شیر پرچرب پگاه',
      calories: '150 کالری',
      weight: '240 گرم',
      values: {
        'چربی': '8 گرم',
        'اسید چرب': '5 گرم',
        'نمک': '0.12 گرم',
        'قند': '12 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/saghe.png',
      name: 'بیسکویت ساقه طلایی مینو',
      calories: '54 کالری',
      weight: '12 گرم',
      values: {
        'چربی': '1 گرم',
        'اسید چرب': '0.1 گرم',
        'نمک': '0.04 گرم',
        'قند': '2.56 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/coloche.png',
      name: 'کلوچه گردویی نادری',
      calories: '213 کالری',
      weight: '50 گرم',
      values: {
        'چربی': '5.2 گرم',
        'اسید چرب': '0.09 گرم',
        'نمک': '0.09 گرم',
        'قند': '10.8 گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/yogurt.png',
      name: 'ماست کم چرب کاله',
      calories: '۱۲۰ کالری',
      weight: '۱۵۰ گرم',
      values: {
        'چربی': '۳ گرم',
        'اسید چرب': '۱.۵ گرم',
        'نمک': '۰.۱ گرم',
        'قند': '۸ گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/dark_chocolate.png',
      name: 'شکلات تلخ 72٪ پارمیدا',
      calories: '۱۵۵ کالری',
      weight: '۲۸ گرم',
      values: {
        'چربی': '۹ گرم',
        'اسید چرب': '۵ گرم',
        'نمک': '۰.۰۱ گرم',
        'قند': '۱۴ گرم',
      },
    ),
    AlternativeProduct(
      imagePath: 'assets/barley_bread.png',
      name: 'نان جو سبوس دار',
      calories: '۲۵۰ کالری',
      weight: '۱۰۰ گرم',
      values: {
        'چربی': '۳ گرم',
        'اسید چرب': '۰.۵ گرم',
        'نمک': '۱.۲ گرم',
        'قند': '۵ گرم',
      },
    ),
    // AlternativeProduct(
    //   imagePath: 'assets/beans.png',
    //   name: 'کنسرو لوبیا چیتی با سس گوجه فرنگی',
    //   calories: '۸۵ کالری',
    //   weight: '۱۰۰ گرم',
    //   values: {
    //     'چربی': '۰.۵ گرم',
    //     'اسید چرب': '۰.۱ گرم',
    //     'نمک': '۰.۸ گرم',
    //     'قند': '۴ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/almond_milk.png',
    //   name: 'شیر بادام شیرین نشده',
    //   calories: '۳۹ کالری',
    //   weight: '۲۴۰ گرم',
    //   values: {
    //     'چربی': '۳ گرم',
    //     'اسید چرب': '۰.۲ گرم',
    //     'نمک': '۰.۱۴ گرم',
    //     'قند': '۰ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/cereal.png',
    //   name: 'غلات صبحانه با فیبر بالا',
    //   calories: '۱۱۰ کالری',
    //   weight: '۳۰ گرم',
    //   values: {
    //     'چربی': '۱ گرم',
    //     'اسید چرب': '۰.۲ گرم',
    //     'نمک': '۰.۲ گرم',
    //     'قند': '۵ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/feta_cheese.png',
    //   name: 'پنیر فتا کم نمک',
    //   calories: '۸۰ کالری',
    //   weight: '۳۰ گرم',
    //   values: {
    //     'چربی': '۶ گرم',
    //     'اسید چرب': '۴ گرم',
    //     'نمک': '۰.۳ گرم',
    //     'قند': '۰.۵ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/orange_juice.png',
    //   name: 'آب پرتقال طبیعی',
    //   calories: '۱۱۲ کالری',
    //   weight: '۲۴۸ گرم',
    //   values: {
    //     'چربی': '۰.۵ گرم',
    //     'اسید چرب': '۰.۱ گرم',
    //     'نمک': '۰.۰۰۲ گرم',
    //     'قند': '۲۰ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/chips.png',
    //   name: 'چیپس سیب زمینی تنوری',
    //   calories: '۱۴۰ کالری',
    //   weight: '۲۸ گرم',
    //   values: {
    //     'چربی': '۶ گرم',
    //     'اسید چرب': '۰.۵ گرم',
    //     'نمک': '۰.۱۵ گرم',
    //     'قند': '۱ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/pasta.png',
    //   name: 'پاستا پنه سبوس دار زر ماکارون',
    //   calories: '۱۸۷ کالری',
    //   weight: '۵۵ گرم',
    //   values: {
    //     'چربی': '۰.۲۸ گرم',
    //     'اسید چرب': '۰.۱ گرم',
    //     'نمک': '۰.۰۱ گرم',
    //     'قند': '۰.۶۱ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/nuggets.png',
    //   name: 'ناگت مرغ پخته شده در فر',
    //   calories: '۱۷۴ کالری',
    //   weight: '۱۰۰ گرم',
    //   values: {
    //     'چربی': '۸.۶ گرم',
    //     'اسید چرب': '۲ گرم',
    //     'نمک': '۰.۸ گرم',
    //     'قند': '۰.۷ گرم',
    //   },
    // ),
    // AlternativeProduct(
    //   imagePath: 'assets/ice_cream.png',
    //   name: 'بستنی وانیلی کم چرب',
    //   calories: '۱۳۷ کالری',
    //   weight: '۱۰۰ گرم',
    //   values: {
    //     'چربی': '۷ گرم',
    //     'اسید چرب': '۴.۵ گرم',
    //     'نمک': '۰.۱ گرم',
    //     'قند': '۱۴ گرم',
    //   },
    // ),
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