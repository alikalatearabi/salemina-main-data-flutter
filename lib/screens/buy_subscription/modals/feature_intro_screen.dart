// lib/buy_subscription_flow/modals/feature_intro_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; // مطمئن شوید این پکیج در pubspec.yaml موجود است
import '../constants.dart';
import '../ui_helpers.dart';
import 'feature_modal_screen.dart';

Widget _buildFeatureListItem(BuildContext itemContext, String number, String title) {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(vertical: 5),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: salminaLightGreyBorder,
          child: Text(number, style: TextStyle(color: Colors.black87, fontSize: 14))),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
      trailing: Icon(Icons.info_outline, color: salminaIconGrey),
      onTap: () {
        showFeatureModalScreen(itemContext, featureTitle: title);
      },
    ),
  );
}

void showFeatureIntroScreen(BuildContext context) {
  final List<String> features = [
    'فیچر پرمیوم سالمینا ۱', 'فیچر پرمیوم سالمینا ۲', 'فیچر پرمیوم سالمینا ۳',
    'فیچر پرمیوم سالمینا ۴', 'فیچر پرمیوم سالمینا ۵', 'فیچر پرمیوم سالمینا ۶', // اضافه کردن آیتم برای تست اسکرول
    'فیچر پرمیوم سالمینا ۷', 'فیچر پرمیوم سالمینا ۸',
  ];

  print("Attempting to show FeatureIntroScreen with context: $context");

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // مهم برای اینکه بتوانیم ارتفاع را کنترل کنیم
    shape: modalShape,
    backgroundColor: Colors.transparent, // برای اینکه RoundedRectangleBorder modalShape دیده شود
    builder: (bc) {
      final screenHeight = MediaQuery.of(bc).size.height;
      final topPadding = MediaQuery.of(bc).padding.top; // برای safe area
      final bottomInset = MediaQuery.of(bc).viewInsets.bottom; // برای کیبورد

      // محاسبه حداکثر ارتفاع مودال (80% ارتفاع قابل استفاده)
      // ارتفاع قابل استفاده، ارتفاع کل صفحه منهای پدینگ بالا و پایین (مثل کیبورد) است
      final availableHeight = screenHeight - topPadding - bottomInset;
      final maxHeight = availableHeight * 0.95;

      return Padding(
        // این پدینگ برای زمانی است که کیبورد باز می‌شود
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          // اعمال شکل و رنگ پس‌زمینه در اینجا
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(600, 50)),
          ),
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView( // اضافه کردن SingleChildScrollView
              child: Padding(
                padding: EdgeInsets.all(20.0).copyWith(
                  // پدینگ پایین را می‌توان کمتر کرد یا حذف کرد اگر bottomInset در بالا اعمال شده
                  // bottom: 20
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // مهم برای SingleChildScrollView
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 40), // برای تراز کردن عنوان
                          Text('امکانات پرمیوم سالمینا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(bc))
                        ]
                    ),
                    SizedBox(height: 20),
                    SvgPicture.asset(
                      'assets/Illustration (6).svg', // مطمئن شوید این فایل در assets شما وجود دارد
                      width: 150, // می‌توانید اندازه را تنظیم کنید
                      height: 150,
                      placeholderBuilder: (BuildContext context) => Container(
                          width: 150, height: 150,
                          child: Center(child: CircularProgressIndicator())
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('امکانات پرمیوم برای شما فعال شد.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                    ),
                    SizedBox(height: 10),
                    Text(
                        'برای استفاده از هر یک از امکانات پریمیوم سالمینا میتوانید در زیر راهنمای استفاده از هر یک را مشاهده کنید.',
                        style: TextStyle(fontSize: 15, color: salminaGreyText)
                    ),
                    SizedBox(height: 20),
                    // ListView.builder دیگر نیازی به Expanded ندارد چون داخل SingleChildScrollView است
                    // و Column دارای mainAxisSize.min است.
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // اسکرول توسط SingleChildScrollView والد انجام می‌شود
                      itemCount: features.length,
                      itemBuilder: (itemBuilderContext, index) {
                        return _buildFeatureListItem(
                            itemBuilderContext,
                            (index == features.length - 1 && features.length > 4 && features.length > 5) ? '...' : (index + 1).toString(), // برای نمایش '...' اگر تعداد زیاد باشد
                            features[index]
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    buildTextButton('رفتن به صفحه اصلی', () {
                      Navigator.pop(bc);
                      navigateToProfilePage(context);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).then((_) {
    print("FeatureIntroScreen modal closed.");
  }).catchError((error) {
    print("Error showing FeatureIntroScreen: $error");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا در نمایش صفحه: $error', textDirection: TextDirection.rtl))
    );
  });
}