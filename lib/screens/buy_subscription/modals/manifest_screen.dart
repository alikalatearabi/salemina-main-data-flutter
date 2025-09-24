import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../ui_helpers.dart';

void showManifestScreen(BuildContext context, {required VoidCallback onNext}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true, shape: modalShape, backgroundColor: Colors.white,
    builder: (bc) => Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('سالمینا یعنی سبک زندگی سالم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(Icons.arrow_forward_ios, color: salminaGreen), onPressed: onNext),
          ]),
          SizedBox(height: 20),
          SvgPicture.asset(
            'assets/Illustration.svg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('برای داشتن یه زندگی سالم هیچوقت دیر نیست...',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 10),
          Text('با حمایت و همراهی شماری از متخصصین تغذیه، کارشناسان  و پزشکان، سالمینا متولد شد و امیدواریم بتونیم زندگیتونو پر از سلامتی بکنیم.',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 50),
          buildPrimaryButton('ادامه', onNext),
        ]),
      ),
    ),
  );
}