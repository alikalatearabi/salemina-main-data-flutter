import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../ui_helpers.dart';
import '../data/testimonial_data.dart'; // Import testimonial data

Widget _buildTestimonialCard(Map<String, dynamic> data) {
  return Card(
    color: Colors.white,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(padding: const EdgeInsets.all(15.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            backgroundImage: AssetImage(data['avatar'] ?? 'assets/images/default_avatar.png'),
            onBackgroundImageError: (_, __) {}, backgroundColor: salminaLightGreyBorder,
            child: (data['avatar'] == null || data['avatar'].isEmpty) ? Icon(Icons.person, color: salminaIconGrey) : null,
          ),
          SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(data['user'], style: TextStyle(fontSize: 12, color: salminaIconGrey)),
          ])),
          Row(children: List.generate(5, (i) => Icon(Icons.star, color: i < data['stars'] ? Colors.amber : salminaLightGreyBorder, size: 18))),
        ]),
        SizedBox(height: 10),
        Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        SizedBox(height: 10),
        Text(data['comment'], style: TextStyle(fontSize: 14, height: 1.3, color: salminaGreyText), maxLines: 3, overflow: TextOverflow.ellipsis),
      ]),
      if (data['strengths'] != null && (data['strengths'] as List).isNotEmpty)
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 8),
          ...(data['strengths'] as List<String>).take(2).map((item) => buildChecklistItem(item)).toList(),
        ]),
    ])),
  );
}

void showTestimonialScreen(BuildContext context, {required VoidCallback onNext}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true, shape: modalShape, backgroundColor: Colors.white,
    builder: (bc) => Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('از انتخاب سالمینا ممنونیم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(icon: Icon(Icons.arrow_forward_ios, color: salminaGreen), onPressed: onNext),
            ]),
            SizedBox(height: 20),
            SvgPicture.asset(
              'assets/Illustration (2).svg',
              width: 200,
              height: 200,
            ),SizedBox(height: 20),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('نظر کاربران سالمینا در شبکه های مجازی',textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
           SizedBox(height: 10),
            Text('از تمام انتقادات و پیشنهادات شما برای بهبود سالمینا استقبال می‌کنیم و از اعتمادتان به سالمینا سپاسگزاریم.', style: TextStyle(fontSize: 14, color: Colors.black)),
          ])),
          SizedBox(height: 20),
          Container(height: 240, child: ListView.builder(
            scrollDirection: Axis.horizontal, padding: EdgeInsets.symmetric(horizontal: 12), itemCount: testimonialData.length,
            itemBuilder: (ctx, index) => SizedBox(width: MediaQuery.of(ctx).size.width * 0.75, child: _buildTestimonialCard(testimonialData[index])),
          )),
          SizedBox(height: 30),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: buildPrimaryButton('ادامه', onNext)),
        ]),
      ),
    ),
  );
}