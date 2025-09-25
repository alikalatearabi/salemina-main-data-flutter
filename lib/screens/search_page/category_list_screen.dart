import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/search_page/sort_button.dart';

import '../../widgets/one_attribute_list.dart';
import '../../widgets/one_attribute_list_item.dart';

class CategoryListScreen extends StatefulWidget {
  final String title;

  const CategoryListScreen({super.key,required this.title});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  String sortState='سالمترین';
  String indicator='کالری';
  int currentIndex=0;

  late List<OneAttributeList> products ;
  final List<Map<String, dynamic>> allProductsData = [
    {
      'imagePath': 'assets/milk.png',
      'name': 'شیر پرچرب پگاه',
      'serving': '240 گرم',
      'values': {'کالری': '150', 'قند': '12', 'چربی': '8', 'اسید چرب': '5', 'نمک': '0.12'}
    },
    {
      'imagePath': 'assets/saghe.png',
      'name': 'بیسکویت ساقه طلایی مینو',
      'serving': '12 گرم',
      'values': {'کالری': '54', 'قند': '2.56', 'چربی': '1', 'اسید چرب': '0.1', 'نمک': '0.04'}
    },
    {
      'imagePath': 'assets/coloche.png',
      'name': 'کلوچه گردویی نادری',
      'serving': '50 گرم',
      'values': {'کالری': '213', 'قند': '10.8', 'چربی': '5.2', 'اسید چرب': '0.09', 'نمک': '0.09'}
    },
    {
      'imagePath': 'assets/yogurt.png',
      'name': 'ماست کم چرب کاله',
      'serving': '150 گرم',
      'values': {'کالری': '120', 'قند': '8', 'چربی': '3', 'اسید چرب': '1.5', 'نمک': '0.1'}
    },
    {
      'imagePath': 'assets/dark_chocolate.png',
      'name': 'شکلات تلخ 72٪ پارمیدا',
      'serving': '28 گرم',
      'values': {'کالری': '155', 'قند': '14', 'چربی': '9', 'اسید چرب': '5', 'نمک': '0.01'}
    },
    {
      'imagePath': 'assets/barley_bread.png',
      'name': 'نان جو سبوس دار',
      'serving': '100 گرم',
      'values': {'کالری': '250', 'قند': '5', 'چربی': '3', 'اسید چرب': '0.5', 'نمک': '1.2'}
    },
    // {
    //   'imagePath': 'assets/beans.png',
    //   'name': 'کنسرو لوبیا چیتی',
    //   'serving': '100 گرم',
    //   'values': {'کالری': '85', 'قند': '4', 'چربی': '0.5', 'اسید چرب': '0.1', 'نمک': '0.8'}
    // },
    // {
    //   'imagePath': 'assets/almond_milk.png',
    //   'name': 'شیر بادام شیرین نشده',
    //   'serving': '240 گرم',
    //   'values': {'کالری': '39', 'قند': '0', 'چربی': '3', 'اسید چرب': '0.2', 'نمک': '0.14'}
    // },
    // {
    //   'imagePath': 'assets/cereal.png',
    //   'name': 'غلات صبحانه با فیبر بالا',
    //   'serving': '30 گرم',
    //   'values': {'کالری': '110', 'قند': '5', 'چربی': '1', 'اسید چرب': '0.2', 'نمک': '0.2'}
    // },
    // {
    //   'imagePath': 'assets/feta_cheese.png',
    //   'name': 'پنیر فتا کم نمک',
    //   'serving': '30 گرم',
    //   'values': {'کالری': '80', 'قند': '0.5', 'چربی': '6', 'اسید چرب': '4', 'نمک': '0.3'}
    // },
  ];

  @override
  void initState() {
    super.initState();
    buildProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showSortBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.22564102564102564102564102564103,
                    MediaQuery.of(context).size.height * 0.04071246819338422391857506361323,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(
                    color: Color(0xFF018A08),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sort.svg',
                      width: 18,
                      height: 18,
                      color: const Color(0xFF018A08),
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      sortState,
                      style: const TextStyle(
                          color: Color(0xFF018A08),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16,bottom: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16,bottom: 16),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return OneAttributeListItem(
                    product: products[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) async {
    final selectedIndex = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SortButton(initialIndex: currentIndex),
    );

    if (selectedIndex != null) {
      setState(() {
        currentIndex = selectedIndex;
        if (selectedIndex==0){
          sortState='سالمترین';
          indicator='کالری';
        }else if (selectedIndex==1){
          sortState='کمترین کالری';
          indicator='کالری';
        }else if (selectedIndex==2){
          sortState='کمترین قند';
          indicator='قند';
        }else if (selectedIndex==3){
          sortState='کمترین چربی';
          indicator='چربی';
        }else if (selectedIndex==4){
          sortState='کمترین اسیدچرب';
          indicator='اسید چرب';
        }else if (selectedIndex==5){
          sortState='کمترین نمک';
          indicator='نمک';
        }else if (selectedIndex==6){
          sortState='ملاحظات شخصی';
          indicator='کالری';
        }
        buildProductList();
      });
    }
  }

  void buildProductList() {
    products = allProductsData.map((p) {
      return OneAttributeList(
        imagePath: p['imagePath'],
        name: p['name'],
        indicator: indicator,
        weight: p['values'][indicator] ?? '0',
        value: p['serving'],
      );
    }).toList();
  }
}