import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/product_page/alternative_product_screen.dart';
import 'package:main_app/screens/product_page/calorie_analysis_card.dart';
import 'package:main_app/screens/product_page/negative_attributes_card.dart';
import 'package:main_app/screens/product_page/positive_attributes_card.dart';
import 'package:main_app/screens/product_page/bottom_bar.dart';
import 'alternative_product.dart';
import 'alternative_product_item.dart';
import 'food_info_card.dart';
import 'food_item_data.dart';
import 'product_header.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {

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
  ];

  List<FoodItemData> foodInfoItems = [
    FoodItemData(
      label: 'قند',
      value: 4,
      unit: 'گرم',
      status: 'سالم',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/sugar.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'چربی کل',
      value: 10,
      unit: 'گرم',
      status: 'متوسط',
      statusTextColor: Color(0xFFAE701E),
      icon: SvgPicture.asset(
        'assets/icons/bottle_2.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'نمک',
      value: 0.8,
      unit: 'گرم',
      status: 'ناسالم',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/salt.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'اسیدهای چرب ترانس',
      value: 0.4,
      unit: 'گرم',
      status: 'ناسالم',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/olives.svg',
        width: 20,
        height: 20,
      ),
    ),
  ];

  List<FoodItemData> calorieAnalysisItems = [
    FoodItemData(
      label: 'کالری کل',
      value: 24.33,
      unit: 'کیلوکالری',
      status: '',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/fire.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'کالری حاصل از قند',
      value: 10,
      unit: 'کیلوکالری',
      status: '',
      statusTextColor: Color(0xFFAE701E),
      icon: SvgPicture.asset(
        'assets/icons/sugar.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'کالری حاصل از چربی',
      value: 0.8,
      unit: 'کیلوکالری',
      status: 'ناسالم',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/bottle_2.svg',
        width: 24,
        height: 24,
      ),
    ),
  ];

  List<FoodItemData> positiveItems = [
    FoodItemData(
      label: 'انرژی',
      value: 4,
      unit: 'کیلوکالری',
      status: 'Free Calorie',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/fire.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'چربی',
      value: 10,
      unit: 'گرم',
      status: 'Low Fat',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/bottle_2.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'شکر',
      value: 0.8,
      unit: 'گرم',
      status: 'Low Sugar',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/sugar.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'نمک',
      value: 0.4,
      unit: 'گرم',
      status: 'Low Salt',
      statusTextColor: Color(0xFF25A749),
      icon: SvgPicture.asset(
        'assets/icons/salt.svg',
        width: 24,
        height: 24,
      ),
    ),
  ];

  List<FoodItemData> negativeItems = [
    FoodItemData(
      label: 'انرژی',
      value: 4,
      unit: 'کیلوکالری',
      status: 'High in Calorie',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/fire.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'شکر',
      value: 0.8,
      unit: 'گرم',
      status: 'High in Sugar',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/sugar.svg',
        width: 24,
        height: 24,
      ),
    ),
    FoodItemData(
      label: 'نمک',
      value: 0.4,
      unit: 'گرم',
      status: 'High Sodium',
      statusTextColor: Color(0xFFD44661),
      icon: SvgPicture.asset(
        'assets/icons/salt.svg',
        width: 24,
        height: 24,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ProductHeaderDelegate(productRate: 2.31, rateCount: 200, productBrand: 'اویلا', productName: 'روغن آفتابگردان اویلا', productCluster: 'خوشه محصول'),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.02035623409669211195928753180662,
                    vertical: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,
                  ),
                  color: Colors.white,
                  child: FoodInfoCard(foodItems: foodInfoItems),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.02035623409669211195928753180662,
                    vertical: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,
                  ),
                  color: Colors.white,
                  child: PositiveAttributesCard(foodItems: positiveItems),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.02035623409669211195928753180662,
                    vertical: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,
                  ),
                  color: Colors.white,
                  child: NegativeAttributesCard(foodItems: negativeItems),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.02035623409669211195928753180662,
                    vertical: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,
                  ),
                  color: Colors.white,
                  child: CalorieAnalysisCard(foodItems: calorieAnalysisItems),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.01017811704834605597964376590331,
                  color: Color(0xFF03D929EAB).withOpacity(0.24),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                ),
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
                                  builder: (context) => AlternativeProductScreen(),
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
                            "محصولات جایگزین",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3231,
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
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductBottomBar(), // Use the new widget here
    );
  }
}