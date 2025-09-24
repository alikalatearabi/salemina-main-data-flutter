import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../ui_helpers.dart';
import 'buy_premium_plan_screen.dart'; // برای بازگشت به صفحه خرید

void showPaymentFailedScreen(BuildContext context, {required String price}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true, shape: modalShape, backgroundColor: Colors.white,
    builder: (bc) => Directionality(textDirection: TextDirection.rtl, child: Padding(
      padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ SizedBox(width: 40), Text('پرداخت ناموفق', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
        SizedBox(height: 20),
        SvgPicture.asset(
          'assets/Illustration (4).svg',
          width: 200,
          height: 200,
        ),
        SizedBox(height: 20), Text('پرداخت شما ناموفق بود.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: salminaRed)),
        SizedBox(height: 5), Text('برای خرید اشتراک، لطفا مجدد تلاش کنید...', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: salminaGreyText)),
        SizedBox(height: 20),
        Container(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: salminaLightGreyBorder), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 3)]),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("۲۳:۵۵:۵۵", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: salminaRed)), // Placeholder timer
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [ Text('پلاتینیوم', style: TextStyle(fontWeight: FontWeight.bold)), Text(price, style: TextStyle(fontSize: 15)), Text('نامحدود ∞', style: TextStyle(color: salminaIconGrey))])
          ]),
        ),
        SizedBox(height: 30),
        buildPrimaryButton('پرداخت مجدد', () { Navigator.pop(context); showBuyPremiumPlanScreen(context); }),
        SizedBox(height: 10),
        buildTextButton('بازگشت به صفحه اصلی', () => navigateToProfilePage(context)),
      ]),
    )),
  );
}