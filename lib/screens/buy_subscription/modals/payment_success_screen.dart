// lib/buy_subscription_flow/modals/payment_success_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../ui_helpers.dart';
import 'feature_intro_screen.dart';

void showPaymentSuccessScreen(BuildContext context) { // این context، context والد است (مثلا از BuyPremiumPlanScreen یا هرجایی که این مودال فراخوانی شده)
  // برای دیباگ
  print("Attempting to show PaymentSuccessScreen with context: $context");

  showModalBottomSheet(
    context: context, // از context والد برای نمایش این مودال استفاده می‌شود
    isScrollControlled: true,
    shape: modalShape,
    backgroundColor: Colors.white,
    builder: (bc) { // bc، builder context خودِ این مودال (PaymentSuccessScreen) است
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    Text('پرداخت موفق', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(bc))
                  ]
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                'assets/Illustration (5).svg',
                width: 200,
                height: 200,
              ),SizedBox(height: 20),
              Text('خرید اشتراک شما با موفقیت انجام شد.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: salminaGreen)),
              SizedBox(height: 5),
              Text('اشتراک نامحدود سالمینا برای شما فعال شد...', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: salminaGreyText)),
              SizedBox(height: 30),
              buildPrimaryButton('مشاهده امکانات پرمیوم', () {
                Navigator.pop(bc); // بستن مودال PaymentSuccess با bc
                // <<<<< نکته کلیدی اینجاست >>>>>
                // از 'context' اصلی که به showPaymentSuccessScreen پاس داده شده استفاده می‌کنیم.
                // این context باید همچنان معتبر باشد و MediaQuery داشته باشد.
                Future.delayed(Duration.zero, () { // اطمینان از اینکه pop قبلی کامل شده
                  showFeatureIntroScreen(context);
                });
              }),
              SizedBox(height: 10),
              buildTextButton('رفتن به صفحه اصلی', () {
                Navigator.pop(bc); // بستن این مودال (PaymentSuccess) با bc
                navigateToProfilePage(context); // ناوبری به پروفایل با context اصلی (والد)
              }),
            ],
          ),
        ),
      );
    },
  ).then((_) {
    print("PaymentSuccessScreen modal closed.");
  }).catchError((error) {
    print("Error showing PaymentSuccessScreen: $error");
  });
}