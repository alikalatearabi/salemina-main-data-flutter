import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app/screens/scanner_page/product_detail.dart';
import '../product_page/adding_meal.dart';
import '../product_page/product_page.dart';

class ValidProductDisplay extends StatefulWidget {
  final String scannedCode;
  final Map<String, dynamic>? productData;
  final VoidCallback onClose;

  const ValidProductDisplay({
    Key? key,
    required this.scannedCode,
    this.productData,
    required this.onClose,
  }) : super(key: key);

  @override
  State<ValidProductDisplay> createState() => _ValidProductDisplayState();
}

class _ValidProductDisplayState extends State<ValidProductDisplay> with SingleTickerProviderStateMixin {
  late final AnimationController _badgeAnimationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(600, 50),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE3E6EA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: widget.onClose,
              icon: const Icon(
                CupertinoIcons.multiply,
                size: 24,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          ProductDetail(productData: widget.productData),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.8,
                  minChildSize: 0.4,
                  maxChildSize: 0.95,
                  builder: (context, scrollController) {
                    return AddingMeal(
                      productData: widget.productData,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF018A08),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(
                MediaQuery.of(context).size.width *
                    0.87692307692307692307692307692308,
                MediaQuery.of(context).size.height *
                    0.06106870229007633587786259541985,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "افزودن به لیست مصرف",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: ElevatedButton(
                  onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.8769230769230769,
                      MediaQuery.of(context).size.height * 0.061068702290076335,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(
                color: Color(0xFF018A08),
                width: 1,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "مشاهده جزئیات",
                  style: TextStyle(
                      color: Color(0xFF018A08),
                      fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                ),
              ],
            ),
                ),
              ),
              Positioned(
                top: 4,
                right: 16,
                child: ScaleTransition(
                  scale: _badgeAnimationController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'به زودی',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _badgeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _badgeAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _badgeAnimationController.forward();
      }
    })..forward();
  }

  @override
  void dispose() {
    _badgeAnimationController.dispose();
    super.dispose();
  }
}
