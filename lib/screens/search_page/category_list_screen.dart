import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/search_page/sort_button.dart';

import '../../widgets/one_attribute_list.dart';
import '../../widgets/one_attribute_list_item.dart';

class CategoryListScreen extends StatefulWidget {
  final String title;

  CategoryListScreen({super.key,required this.title});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  String sortState='سالمترین';
  String indicator='کالری';
  int currentIndex=0;

  late List<OneAttributeList> products ;

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
                  side: BorderSide(
                    color: Color(0xFF018A08),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.rtl,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sort.svg',
                      width: 18,
                      height: 18,
                      color: Color(0xFF018A08),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      sortState,
                      style: TextStyle(
                          color: Color(0xFF018A08),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
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
                  offset: Offset(0, 5),
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
                  style: TextStyle(
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
          buildProductList();
        }else if (selectedIndex==1){
          sortState='کمترین کالری';
          indicator='کالری';
          buildProductList();
        }else if (selectedIndex==2){
          sortState='کمترین قند';
          indicator='قند';
          buildProductList();
        }else if (selectedIndex==3){
          sortState='کمترین چربی';
          indicator='چربی';
          buildProductList();
        }else if (selectedIndex==4){
          sortState='کمترین اسیدچرب';
          indicator='اسید چرب';
          buildProductList();
        }else if (selectedIndex==5){
          sortState='کمترین نمک';
          indicator='نمک';
          buildProductList();
        }else if (selectedIndex==6){
          sortState='ملاحظات شخصی';
          indicator='کالری';
          buildProductList();
        }
      });
    }
  }

  void buildProductList() {
    products = [
      OneAttributeList(
          imagePath: 'assets/milk.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk2.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk3.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk2.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk3.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk2.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk3.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk2.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk3.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk2.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
      OneAttributeList(
          imagePath: 'assets/milk3.png',
          name: 'نام محصول در حالت خیلی طولانی ...',
          indicator: indicator,
          weight: '145 گرم',
          value: '5555 گرم'
      ),
    ];
  }

}