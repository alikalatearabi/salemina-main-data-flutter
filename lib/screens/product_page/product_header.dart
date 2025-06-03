import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/home_page/home_page.dart';
import 'package:main_app/screens/product_page/rate_and_review_modal.dart';
import '../../widgets/one_attribute_list.dart';
import '../../widgets/one_attribute_list_item.dart';
import '../comparison_page/comparison_page.dart';
import 'conditional_marquee.dart';
import 'radial_chart_widget.dart';

String toPersianNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '٫'];
  for (int i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

class ProductHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double productRate;
  final int rateCount;
  final String productBrand;
  final String productName;
  final String productCluster;

  ProductHeaderDelegate({
    required this.productBrand,
    required this.productName,
    required this.productCluster,
    required this.productRate,
    required this.rateCount,
  });

  final GlobalKey _radialChartWidgetKey = GlobalKey();
  double _radialChartWidgetHeight = 0;

  final ValueNotifier<bool> _allQuestionsRatedNotifier = ValueNotifier(false);
  final GlobalKey<RateAndReviewModalState> _rateAndReviewModalKey = GlobalKey<RateAndReviewModalState>();
  final ValueNotifier<double?> _userAverageRatingNotifier = ValueNotifier(null);


  void _measureWidget() {
    if (_radialChartWidgetKey.currentContext == null) return;
    final RenderBox renderBox = _radialChartWidgetKey.currentContext!.findRenderObject() as RenderBox;
    _radialChartWidgetHeight = renderBox.size.height;
  }

  final List<OneAttributeList> product = [
    OneAttributeList(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      indicator: 'قند',
      weight: '145 گرم',
      value: '5555 گرم',
    ),
  ];

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureWidget());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxHeight = maxExtent;
    final double minHeight = minExtent;
    final double currentHeight = (maxHeight - shrinkOffset).clamp(minHeight, maxHeight);

    if (shrinkOffset > 0 && shrinkOffset < _radialChartWidgetHeight) {
      return _buildIntermediateHeader(context, screenWidth, currentHeight, productRate);
    } else if (shrinkOffset > _radialChartWidgetHeight) {
      return _buildCollapsedHeader(context, screenWidth, currentHeight);
    } else {
      return _buildExpandedHeader(context, screenWidth, currentHeight, productRate);
    }
  }

  Widget _buildExpandedHeader(BuildContext context, double screenWidth, double height, double productRate) {
    return Container(
      color: Colors.white,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0814249364,
            child: _buildTopRow(context, screenWidth),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1221374046,
            child: _buildMiddleRow(context, screenWidth, productRate),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1323155216,
            child: _buildBottomRow(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntermediateHeader(BuildContext context, double screenWidth, double height, starIndex) {
    return Container(
      color: Colors.white,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0814249364,
            child: _buildTopRow(context, screenWidth),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1221374046,
            child: _buildMiddleRow(context, screenWidth, starIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context, double screenWidth, double height) {
    return Container(
      color: Colors.white,
      height: height,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
            child: _buildExpandedHeaderContent(context, screenWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedHeaderContent(BuildContext context, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: screenWidth * 0.01795),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ComparisonScreen()),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/compare2.svg',
                width: 18,
                height: 18,
              ),
            ),
            SizedBox(width: screenWidth * 0.05641),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/info-circle.svg',
                width: 18,
                height: 18,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(productName,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    textDirection: TextDirection.rtl,
                    "${productCluster}  ·  ${productBrand}",
                    style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02051),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/biscuit.jpg',
                //todo
                width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height * 0.05
                    : MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height * 0.05
                    : MediaQuery.of(context).size.width * 0.10,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.02564),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>ComparisonScreen()),
            );
          },
          child: Row(
            children: [
              const Text(
                "مقایسه",
                style: TextStyle(color: Color(0xFF018A08), fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(width: screenWidth * 0.02051),
              SvgPicture.asset(
                'assets/icons/compare2.svg',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05641),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Text(
                "راهنما",
                style: TextStyle(color: Color(0xFF018A08), fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(width: screenWidth * 0.02051),
              SvgPicture.asset(
                'assets/icons/info-circle.svg',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
            );
          },
          child: SvgPicture.asset(
            'assets/icons/arrow-right.svg',
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
  Widget _buildMiddleRow(BuildContext context, double screenWidth, double productRate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConditionalMarquee(
                text: productName,
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                maxCharacters: 25,
              ),
              Text(
                textDirection: TextDirection.rtl,
                "${productCluster} · ${productBrand}",
                style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<double?>(
                    valueListenable: _userAverageRatingNotifier,
                    builder: (context, userAverageRating, child) {
                      if (userAverageRating != null) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEEEFF1),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            minimumSize: Size(
                              screenWidth * 0.22308,
                              MediaQuery.of(context).size.height * 0.03053,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "امتیاز شما: ${toPersianNumber(userAverageRating.toStringAsFixed(1))}",
                                style: const TextStyle(
                                  color:CupertinoColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          _allQuestionsRatedNotifier.value = false;
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.elliptical(600, 50),
                              ),
                            ),
                            builder: (ctx) {
                              final maxHeight = MediaQuery.of(ctx).size.height * 0.9;
                              return Padding(
                                padding: MediaQuery.of(ctx).viewInsets,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: maxHeight),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.elliptical(600, 50),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24, top: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 12),
                                                height: 5,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                textDirection: TextDirection.rtl,
                                                children: [
                                                  const Text(
                                                    'ثبت امتیاز',
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                      color: CupertinoColors.black,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    icon: const Icon(CupertinoIcons.multiply, size: 20),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: product.length,
                                                  itemBuilder: (context, index) {
                                                    return OneAttributeListItem(product: product[index]);
                                                  },
                                                ),
                                                const SizedBox(height: 24),
                                                const Text(
                                                  'در صورت استفاده از این محصول، امتیاز خود را به موارد زیر بین ۱ (بد) تا ۵ (عالی) مشخص کنید.',
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: CupertinoColors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                RateAndReviewModal(
                                                  key: _rateAndReviewModalKey,
                                                  onAllRatedChanged: (allRated) {
                                                    _allQuestionsRatedNotifier.value = allRated;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 10,
                                                offset: Offset(0, -2),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                            child: ValueListenableBuilder<bool>(
                                              valueListenable: _allQuestionsRatedNotifier,
                                              builder: (context, allRated, child) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (allRated) {
                                                      // TODO: Calculate actual average rating from _rateAndReviewModalKey
                                                      // For example: _rateAndReviewModalKey.currentState?.getAverageRating();
                                                      _userAverageRatingNotifier.value = 4.0; // مقدار تست
                                                      final messenger = ScaffoldMessenger.of(context);
                                                      Navigator.of(context).pop();
                                                      messenger.showSnackBar(
                                                        SnackBar(
                                                          behavior: SnackBarBehavior.floating,
                                                          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                          duration: const Duration(seconds: 2),
                                                          content: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    messenger.hideCurrentSnackBar();
                                                                  },
                                                                  child: Icon(Icons.close, size: 20, color: Color(0xFF647482)),
                                                                ),
                                                                const Flexible(
                                                                  child: Text(
                                                                    'امتیاز شما با موفقیت ثبت شد.',
                                                                    textDirection: TextDirection.rtl,
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFF284740),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  child: Center(
                                                                    child: SvgPicture.asset(
                                                                      'assets/icons/ic_check.svg',
                                                                      width: 24,
                                                                      height: 24,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      _rateAndReviewModalKey.currentState?.highlightUnratedQuestions();
                                                      final messenger = ScaffoldMessenger.of(context);
                                                      messenger.showSnackBar(
                                                        SnackBar(
                                                          behavior: SnackBarBehavior.floating,
                                                          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                          duration: const Duration(seconds: 2),
                                                          content: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    messenger.hideCurrentSnackBar();
                                                                  },
                                                                  child: Icon(Icons.close, size: 20, color: Color(0xFF647482)),
                                                                ),
                                                                const Flexible(
                                                                  child: Text(
                                                                    'لطفا امتیاز به تمام موارد را مشخص کنید.',
                                                                    textDirection: TextDirection.rtl,
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFF284740),
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                  child: Center(
                                                                    child: SvgPicture.asset(
                                                                      'assets/icons/ic_check.svg',
                                                                      width: 24,
                                                                      height: 24,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: allRated
                                                        ? const Color(0xFF018A08)
                                                        : const Color(0xFF018A08).withOpacity(0.7),
                                                    elevation: 0,
                                                    minimumSize: Size(
                                                      MediaQuery.of(context).size.width * 0.8769,
                                                      50,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'تایید و ثبت امتیاز',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          minimumSize: Size(
                            screenWidth * 0.22308,
                            MediaQuery.of(context).size.height * 0.03053,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "ثبت امتیاز",
                              style: TextStyle(
                                  color: Color(0xFF015B05),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01538),
                            SvgPicture.asset(
                              'assets/icons/star_linear.svg',
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        "(${toPersianNumber(rateCount.toString())} نفر)",
                        style: TextStyle(color: Color(0xFF657380), fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      if (productRate < 2)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(productRate.truncateToDouble() == productRate ? 0 : 2)),
                          style: TextStyle(color: Color(0xFFF2506E), fontSize: 14),
                        ),
                      if (productRate >= 2 && productRate < 3)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(productRate.truncateToDouble() == productRate ? 0 : 2)),
                          style: TextStyle(color: Color(0xFFF5AE32), fontSize: 14),
                        ),
                      if (productRate >= 3 && productRate <= 4)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(productRate.truncateToDouble() == productRate ? 0 : 2)),
                          style: TextStyle(color: Color(0xFF464E59), fontSize: 14),
                        ),
                      if (productRate > 4)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(productRate.truncateToDouble() == productRate ? 0 : 2)),
                          style: TextStyle(color: Color(0xFF018A08), fontSize: 14),
                        ),
                      SizedBox(width: 4),
                      if (productRate < 2)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(Color(0xFFF2506E), BlendMode.srcIn),
                        ),
                      if (productRate >= 2 && productRate < 3)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(Color(0xFFF5AE32), BlendMode.srcIn),
                        ),
                      if (productRate >= 3 && productRate <= 4)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(Color(0xFF464E59), BlendMode.srcIn),
                        ),
                      if (productRate > 4)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(Color(0xFF018A08), BlendMode.srcIn),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/biscuit.jpg',
            //todo
            width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.height * 0.10
                : MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.height * 0.10
                : MediaQuery.of(context).size.width * 0.2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      key: _radialChartWidgetKey,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RadialChartWidget(label: 'نمک', value: 100, color: Color(0xFF4BB4D8)),
        RadialChartWidget(label: 'قند', value: 70, color: Color(0xFFF2506E)),
        RadialChartWidget(label: 'اسید چرب', value: 55, color: Color(0xFF8348F9)),
        RadialChartWidget(label: 'چربی', value: 40, color: Color(0xFFF5AE32)),
        RadialChartWidget(label: 'کالری', value: 20, color: Colors.black),
      ],
    );
  }

  @override
  double get maxExtent => 0.335877863 * MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  @override
  double get minExtent => 0.0814249364 * MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}