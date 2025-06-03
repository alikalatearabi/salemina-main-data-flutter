import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';

// یک enum برای مدیریت حالت‌های مختلف مدال
enum ModalScreenState {
  scanning,
  productNotFound,
  addProduct,
}

class ProductScanModal extends StatefulWidget {
  const ProductScanModal({super.key});

  @override
  State<ProductScanModal> createState() => _ProductScanModalState();
}

class _ProductScanModalState extends State<ProductScanModal> {
  ModalScreenState _currentScreen = ModalScreenState.scanning;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();

  void _showProductFoundSnackbar() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3), // کمی بیشتر برای خواندن
        backgroundColor: const Color(0xFF323232), // رنگ پس‌زمینه اسنک‌بار
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'اطلاعات محصول ثبت شد.',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'IranYekan'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '۱۰۰۰ امتیاز دریافت کردید.',
                      style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'IranYekan'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        // اینجا می‌توانید به صفحه امتیازات بروید
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00695C), // یک سبز تیره‌تر
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        textStyle: const TextStyle(fontSize: 12, fontFamily: 'IranYekan'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('دیدن امتیازات'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF018A08), // رنگ سبز اصلی
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_check.svg', // مطمئن شوید این فایل وجود دارد
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildAddProductUI() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(600, 50),
        ),
      ),
      child: SingleChildScrollView( // برای جلوگیری از overflow در کیبورد
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text(
                    'افزودن محصول',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'IranYekan'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'لطفا برای ثبت محصول، اطلاعات زیر را وارد کنید.',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'IranYekan'),
              ),
              const SizedBox(height: 24),
              DottedBorder(
                color: Colors.green,
                strokeWidth: 1.5,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_cloud_upload.svg', // آیکون آپلود خودتان
                        width: 40,
                        height: 40,
                        colorFilter: const ColorFilter.mode(Color(0xFF018A08), BlendMode.srcIn),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'عکس مشخصات محصول',
                        style: TextStyle(color: Color(0xFF018A08), fontFamily: 'IranYekan'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _productNameController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'نام محصول',
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF018A08)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا نام محصول را وارد کنید';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productDescriptionController,
                textDirection: TextDirection.rtl,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'توضیحات محصول (اختیاری)',
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF018A08)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // منطق ذخیره محصول
                    // print('نام محصول: ${_productNameController.text}');
                    // print('توضیحات: ${_productDescriptionController.text}');

                    final messenger = ScaffoldMessenger.of(context);
                    Navigator.of(context).pop(); // بستن مدال

                    // نمایش اسنک‌بار موفقیت‌آمیز بودن ثبت محصول
                    messenger.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(seconds: 2),
                        backgroundColor: const Color(0xFF323232),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end, // برای RTL
                            children: [
                              Flexible(
                                child: Text(
                                  'محصول با موفقیت ثبت شد.', // متن مناسب
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Colors.white, fontFamily: 'IranYekan'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF018A08), // سبز
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_check.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              // اگر می‌خواهید دکمه بستن هم باشد
                              // GestureDetector(
                              //   onTap: () {
                              //     messenger.hideCurrentSnackBar();
                              //   },
                              //   child: Icon(Icons.close, size: 20, color: Color(0xFF647482)),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF018A08),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.87, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "تأیید و ثبت محصول",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'IranYekan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    currentWidget = _buildAddProductUI();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: currentWidget,
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }
}


// یک CustomPainter برای کشیدن گوشه‌های اسکنر
class CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool isTopLeft;
  final bool isTopRight;
  final bool isBottomLeft;
  final bool isBottomRight;

  CornerPainter({
    required this.color,
    this.strokeWidth = 5.0,
    this.isTopLeft = false,
    this.isTopRight = false,
    this.isBottomLeft = false,
    this.isBottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // برای گوشه‌های گردتر

    final path = Path();

    if (isTopLeft) {
      path.moveTo(size.width, 0);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
    } else if (isTopRight) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (isBottomLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else if (isBottomRight) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}