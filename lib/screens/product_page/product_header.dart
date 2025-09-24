import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/home_page/view/home_page.dart';
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

  final ValueNotifier<bool> _allQuestionsRatedNotifier = ValueNotifier(false);
  final GlobalKey<RateAndReviewModalState> _rateAndReviewModalKey = GlobalKey<RateAndReviewModalState>();
  final ValueNotifier<double?> _userAverageRatingNotifier = ValueNotifier(null);

  final List<OneAttributeList> product = [
    OneAttributeList(
      imagePath: 'assets/milk.png',
      name: 'نام محصول در حالت خیلی طولانی ...',
      indicator: 'قند',
      weight: '145 گرم',
      value: '5555 گرم',
    ),
  ];

  Color _getRatingColor(double rate) {
    if (rate < 2) return const Color(0xFFF2506E);
    if (rate < 3) return const Color(0xFFF5AE32);
    if (rate <= 4) return const Color(0xFF464E59);
    return const Color(0xFF018A08);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final double collapsedOpacity = progress;
    final double expandedOpacity = 1 - progress;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (progress > 0.9)
            BoxShadow(
              color: Colors.black.withOpacity((progress - 0.9) * 1), // Fade in shadow
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: expandedOpacity,
            child: _buildExpandedLayout(context),
          ),
          Opacity(
            opacity: collapsedOpacity,
            child: _buildCollapsedLayout(context, screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0615),
      child: Column(
        children: [
          Expanded(flex: 2, child: _buildTopRow(context)),
          Expanded(flex: 3, child: _buildMiddleRow(context)),
          Expanded(flex: 3, child: _buildBottomRow()),
        ],
      ),
    );
  }

  Widget _buildCollapsedLayout(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset('assets/icons/arrow-right.svg', width: 20, height: 20),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/biscuit.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 8,
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productName,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "$productCluster  ·  $productBrand",
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(color: Color(0xFF018A08), fontSize: 12),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset('assets/icons/info-circle.svg', width: 18, height: 18),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ComparisonScreen()),
            ),
            child: SvgPicture.asset('assets/icons/compare2.svg', width: 18, height: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionButton(context, 'مقایسه', 'assets/icons/compare2.svg', () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ComparisonScreen()));
        }),
        const SizedBox(width: 24),
        _buildActionButton(context, 'راهنما', 'assets/icons/info-circle.svg', () {}),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/icons/arrow-right.svg', width: 20, height: 20),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, String iconPath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF018A08), fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 8),
          SvgPicture.asset(iconPath, width: 18, height: 18),
        ],
      ),
    );
  }

  Widget _buildMiddleRow(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConditionalMarquee(
                text: productName,
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                maxCharacters: 25,
              ),
              Text(
                "$productCluster · $productBrand",
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Color(0xFF018A08), fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildRatingDisplay(context),
                  const SizedBox(width: 8),
                  _buildUserRatingButton(context),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/biscuit.jpg',
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingDisplay(BuildContext context) {
    final color = _getRatingColor(productRate);
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/star.svg',
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        const SizedBox(width: 4),
        Text(toPersianNumber(productRate.toStringAsFixed(1)), style: TextStyle(color: color, fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          "(${toPersianNumber(rateCount.toString())} نفر)",
          style: const TextStyle(color: Color(0xFF657380), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildUserRatingButton(BuildContext context) {
    return ValueListenableBuilder<double?>(
      valueListenable: _userAverageRatingNotifier,
      builder: (context, userAverageRating, child) {
        if (userAverageRating != null) {
          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEEEFF1),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Text(
              "امتیاز شما: ${toPersianNumber(userAverageRating.toStringAsFixed(1))}",
              style: const TextStyle(color: CupertinoColors.black, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () => _showRatingModal(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "ثبت امتیاز",
                style: TextStyle(color: Color(0xFF015B05), fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset('assets/icons/star_linear.svg', width: 16, height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomRow() {
    return const Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RadialChartWidget(label: 'نمک', value: 100, color: Color(0xFF4BB4D8)),
        RadialChartWidget(label: 'قند', value: 70, color: Color(0xFFF2506E)),
        RadialChartWidget(label: 'اسید چرب', value: 55, color: Color(0xFF8348F9)),
        RadialChartWidget(label: 'چربی', value: 40, color: Color(0xFFF5AE32)),
        RadialChartWidget(label: 'کالری', value: 20, color: Colors.black),
      ],
    );
  }

  void _showRatingModal(BuildContext context) {
    _allQuestionsRatedNotifier.value = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.9),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(CupertinoIcons.multiply, size: 20),
                            ),
                            const Text('ثبت امتیاز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 40),
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
                            itemBuilder: (context, index) => OneAttributeListItem(product: product[index]),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'در صورت استفاده از این محصول، امتیاز خود را به موارد زیر بین ۱ (بد) تا ۵ (عالی) مشخص کنید.',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 24),
                          RateAndReviewModal(
                            key: _rateAndReviewModalKey,
                            onAllRatedChanged: (allRated) => _allQuestionsRatedNotifier.value = allRated,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildModalSubmitButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalSubmitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _allQuestionsRatedNotifier,
        builder: (context, allRated, child) {
          return ElevatedButton(
            onPressed: () {
              if (allRated) {
                _userAverageRatingNotifier.value = 4.0;
                Navigator.of(context).pop();
                _showSuccessSnackBar(context, 'امتیاز شما با موفقیت ثبت شد.');
              } else {
                _rateAndReviewModalKey.currentState?.highlightUnratedQuestions();
                _showErrorSnackBar(context, 'لطفا امتیاز به تمام موارد را مشخص کنید.');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: allRated ? const Color(0xFF018A08) : const Color(0xFF018A08).withOpacity(0.7),
              elevation: 0,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تایید و ثبت امتیاز', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          );
        },
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(context, message, SvgPicture.asset('assets/icons/ic_check.svg', width: 24, height: 24));
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    _showCustomSnackBar(context, message, const Icon(Icons.error_outline, color: Colors.white));
  }

  void _showCustomSnackBar(BuildContext context, String message, Widget icon) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        content: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => messenger.hideCurrentSnackBar(),
              icon: const Icon(Icons.close, size: 20, color: Color(0xFF647482)),
            ),
            Expanded(
              child: Text(message, textDirection: TextDirection.rtl, textAlign: TextAlign.center),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(color: const Color(0xFF284740), borderRadius: BorderRadius.circular(8)),
              child: Center(child: icon),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.335;

  @override
  double get minExtent => MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.081;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}