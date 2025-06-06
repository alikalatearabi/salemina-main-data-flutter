import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../ui_helpers.dart';

void showPlanProsScreen(BuildContext context, {required VoidCallback onNext}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true, shape: modalShape, backgroundColor: Colors.white,
    builder: (bc) => Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('نقشه راه با پلن پرمیوم سالمینا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(Icons.arrow_forward_ios, color: salminaGreen), onPressed: onNext),
          ]),
          SizedBox(height: 20),
          SvgPicture.asset(
            'assets/Illustration (1).svg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('با خرید اشتراک سالمینا، ۷ روز هفته هواتو داریم.', style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600))),
          SizedBox(height: 10),
          Text('استفاده از تمام امکانات سالمینا رایگان است، ولی مزایای اشتراک سالمینا هم کم نیست:',  style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 15),
          buildBenefitItem('۱', 'مزیت پلن پرمیوم'), buildBenefitItem('۲', 'مزیت پلن پرمیوم'),
          buildBenefitItem('۳', 'مزیت پلن پرمیوم'), buildBenefitItem('۴', 'مزیت پلن پرمیوم'),
          buildBenefitItem('...', 'و کلی مزیت دیگه پلن پرمیوم'),
          SizedBox(height: 30),
          buildPrimaryButton('ادامه', onNext),
        ]),
      ),
    ),
  );
}