import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import '../constants.dart';
import '../ui_helpers.dart';
import 'payment_success_screen.dart';
import 'payment_failed_screen.dart';

class UnlimitedPlanScreen extends StatefulWidget { final String price; UnlimitedPlanScreen({required this.price}); @override _UnlimitedPlanScreenState createState() => _UnlimitedPlanScreenState(); }
class _UnlimitedPlanScreenState extends State<UnlimitedPlanScreen> {
  Timer? _timer; int _start = 23 * 3600 + 59 * 60 + 59; // 23:59:59
  @override void initState() { super.initState(); startTimer(); }
  void startTimer() { const oneSec = Duration(seconds: 1); _timer = Timer.periodic(oneSec, (Timer t) { if (!mounted) { t.cancel(); return; } if (_start == 0) { setState(() => t.cancel()); } else { setState(() => _start--); }}); }
  @override void dispose() { _timer?.cancel(); super.dispose(); }
  String get timerString { Duration d = Duration(seconds: _start); String td(int n) => n.toString().padLeft(2, "0"); return "${td(d.inHours)}:${td(d.inMinutes.remainder(60))}:${td(d.inSeconds.remainder(60))}"; }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Padding(
      padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ SizedBox(width: 40), Text('خرید اشتراک نامحدود سالمینا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context))]),
        SvgPicture.asset(
          'assets/Illustration (3).svg',
          width: 200,
          height: 200,
        ),
        SizedBox(height: 20),
        Align(
          alignment: AlignmentDirectional.centerStart,
            child: Text('اشتراک نامحدود و همیشگی سالمینا',textAlign: TextAlign.start,textDirection: TextDirection.rtl, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
        SizedBox(height: 5),
        Text('برای استفاده همیشگی و نامحدود از تمام امکانات سالمینا این پیشنهاد تکرار نشدنی برای شما فراهم شده است.', style: TextStyle(fontSize: 15, color: salminaGreyText)),
        SizedBox(height: 15),
        buildBenefitItem('۱', 'مزیت پلن پرمیوم'), buildBenefitItem('۲', 'مزیت پلن پرمیوم'), buildBenefitItem('۳', 'مزیت پلن پرمیوم'), buildBenefitItem('۴', 'مزیت پلن پرمیوم'), buildBenefitItem('...', 'و کلی مزیت دیگه پلن پرمیوم'),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: Color(0xFFEDF0F2) , borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
          child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(timerString, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: salminaRed)),
                Text(widget.price, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('پلاتینیوم', style: TextStyle(color: salminaIconGrey)),
                  Text('نامحدود ∞', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500))
                ])
          ]),
        ),
        SizedBox(height: 30),
        buildPrimaryButton('خرید اشتراک', () { Navigator.pop(context);
          bool paymentSucceeded = true;
          if (paymentSucceeded) showPaymentSuccessScreen(context);
          else showPaymentFailedScreen(context, price: widget.price); }),
      ]),
    ));
  }
}
void showUnlimitedPlanScreen(BuildContext context, {required String price}) {
  showModalBottomSheet(context: context, isScrollControlled: true, shape: modalShape, backgroundColor: Colors.white, builder: (bc) => UnlimitedPlanScreen(price: price));
}