
import 'package:flutter/material.dart';
import 'package:main_app/screens/comparison_page/sample_product_data.dart';
import 'package:main_app/screens/comparison_page/widgets/product_card_widgets.dart';
import 'package:main_app/screens/comparison_page/widgets/sticky_header_delegate.dart';
import 'package:main_app/screens/comparison_page/widgets/table_card_widgets.dart';
class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showStickyHeader = false;
  final double _initialProductCardsSectionHeight = 200.0;

  Map<String, dynamic> product1Data = product1SampleData;
  Map<String, dynamic>? product2Data = product2SampleData;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _initialProductCardsSectionHeight && !_showStickyHeader) {
      setState(() { _showStickyHeader = true; });
    } else if (_scrollController.offset < _initialProductCardsSectionHeight && _showStickyHeader) {
      setState(() { _showStickyHeader = false; });
    }
  }

  void _addProduct2() {
    setState(() {
      product2Data = sampleAddedProduct2Data;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double stickyHeaderActualHeight = 70.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black54,
          onPressed: () {
            Navigator.of(context).pop();
            // if (Navigator.of(context).canPop()) {
            //   Navigator.of(context).pop();
            // }
          },
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black54),
        //   onPressed: () => Navigator.of(context).pop(),
        //   tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        // ),
        title: Row(
          textDirection: TextDirection.rtl,
          children: const [
            Text("مقایسه محصولات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(
              height: _initialProductCardsSectionHeight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    buildFullProductCard(product1Data,context),
                    product2Data != null
                        ? buildFullProductCard(product2Data,context)
                        : buildAddProductFullCardButton(
                      onTap: _addProduct2, context: context,height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_showStickyHeader)
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                height: stickyHeaderActualHeight,
                backgroundColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    buildStickyProductSummary(product1Data),

                    VerticalDivider(width: 1.0, thickness: 0.8, color: Colors.grey[300]),

                    product2Data != null
                    ? buildStickyProductSummary(product2Data!)
                        :Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildAddProductFullCardButton(
                                                  onTap: _addProduct2, context: context,height: 50
                                                ),
                          ),
                        ),
                  ],
                ),
              ),
            ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildTableCard(
                  title: "اطلاعات کلی",
                  rows: buildRowsWithDividers([
                        () => buildNutrientRow(nutrientKeyBase: "calories", displayName: "کالری", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "fat", displayName: "چربی", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.orange, p2DotColor: Colors.orange),
                        () => buildNutrientRow(nutrientKeyBase: "saturatedFat", displayName: "اسید چرب", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                        () => buildNutrientRow(nutrientKeyBase: "sugar", displayName: "قند", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "salt", displayName: "نمک", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                  ]),
                ),
                buildTableCard(
                  title: "شاخص های غذایی سازمان غذا و دارو",
                  rows: buildRowsWithDividers([
                        () => buildNutrientRow(nutrientKeyBase: "fnd_sugar", displayName: "قند", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "fnd_totalFat", displayName: "چربی کل", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.orange, p2DotColor: Colors.orange),
                        () => buildNutrientRow(nutrientKeyBase: "fnd_salt", displayName: "نمک", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                        () => buildNutrientRow(nutrientKeyBase: "fnd_transFat", displayName: "اسیدهای چرب ترانس", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                  ]),
                ),
                buildTableCard(
                  title: "ویژگی مثبت", subTitle: "(براساس شاخص غذایی Nutrient Claim)",
                  rows: buildRowsWithDividers([
                        () => buildNutrientRow(nutrientKeyBase: "nutrient_claim_energy", displayName: "انرژی", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "nutrient_claim_fat", displayName: "چربی", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "nutrient_claim_sugar", displayName: "شکر", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "nutrient_claim_salt", displayName: "نمک", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                  ]),
                ),
                buildTableCard(
                  title: "ویژگی منفی", subTitle: "(براساس شاخص غذایی STOP)",
                  rows: buildRowsWithDividers([
                        () => buildNutrientRow(nutrientKeyBase: "stop_energy", displayName: "انرژی", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                        () => buildNutrientRow(nutrientKeyBase: "stop_sugar", displayName: "شکر", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                        () => buildNutrientRow(nutrientKeyBase: "stop_salt", displayName: "نمک", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                  ]),
                ),
                buildTableCard(
                  title: "آنالیز کالری",
                  rows: buildRowsWithDividers([
                        () => buildNutrientRow(nutrientKeyBase: "analysis_total_calories", displayName: "کالری کل", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.orange, p2DotColor: Colors.orange),
                        () => buildNutrientRow(nutrientKeyBase: "analysis_sugar_calories", displayName: "کالری حاصل از قند", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.green, p2DotColor: Colors.green),
                        () => buildNutrientRow(nutrientKeyBase: "analysis_fat_calories", displayName: "کالری حاصل از چربی", p1Data: product1Data, p2Data: product2Data, p1DotColor: Colors.red, p2DotColor: Colors.red),
                  ]),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}