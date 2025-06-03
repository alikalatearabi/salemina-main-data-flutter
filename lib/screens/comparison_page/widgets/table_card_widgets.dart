// lib/widgets/table_card_widgets.dart
import 'package:flutter/material.dart';

// کارت جدول
Widget buildTableCard({
  required String title,
  String? subTitle,
  required List<Widget> rows,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey[350]!, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // برای راست چین شدن عنوان در RTL
      children: [
        Container(
          decoration: BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16.0),
        ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, right: 16.0, left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,// ترتیب فرزندان برای RTL: آیکن، فاصله، متن
              children: [
                Icon(Icons.info_outline, color: Colors.grey[500], size: 20),
                Row(
                  children: [
                    if (subTitle != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0), // فاصله از سمت راست متن اصلی
                        child: Text(
                          subTitle,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          textAlign: TextAlign.start, // راست چین
                        ),
                      ),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                      textAlign: TextAlign.start, // راست چین
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ...rows,
        const SizedBox(height: 8),
      ],
    ),
  );
}

// ستون نمایش ماده مغذی (برای هر محصول در جدول)
Widget buildNutrientDisplayColumn(String nutrientName, String? value, Color dotColor) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    child: Row( // ترتیب فرزندان برای RTL: نقطه، فاصله، متن
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end, // راست چین
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nutrientName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
              textAlign: TextAlign.start, // راست چین
            ),
            const SizedBox(height: 2),
            Text(
              value ?? "-",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.start, // راست چین
            ),
          ],
        ),
      ],
    ),
  );
}

// ردیف ماده مغذی در جدول (شامل دو ستون محصول)
Widget buildNutrientRow({
  required String nutrientKeyBase,
  required String displayName,
  required Map<String, dynamic>? p1Data,
  required Map<String, dynamic>? p2Data,
  required Color p1DotColor,
  required Color p2DotColor,
}) {
  String? p1Value = p1Data?[nutrientKeyBase]?.toString();
  String? p2Value = p2Data?[nutrientKeyBase]?.toString();

  return Column( // برای قرار دادن Divider زیر این ردیف اگر لازم باشد (در buildRowsWithDividers)
    children: [
      IntrinsicHeight(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // ستون محصول اول (سمت راست در RTL)
            Expanded(
              child: buildNutrientDisplayColumn(displayName, p1Value, p1DotColor),
            ),
            VerticalDivider(width: 1.0, thickness: 0.5, color: Colors.grey[300]),
            // ستون محصول دوم (سمت چپ در RTL)
            Expanded(
              child: buildNutrientDisplayColumn(
                displayName,
                p2Value,
                p2Data != null ? p2DotColor : Colors.transparent, // نقطه شفاف اگر محصول دوم نیست
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

List<Widget> buildRowsWithDividers(List<Widget Function()> rowBuilders) {
  List<Widget> widgets = [];
  for (int i = 0; i < rowBuilders.length; i++) {
    widgets.add(rowBuilders[i]());
    if (i < rowBuilders.length - 1) {
      widgets.add(Divider(height: 1, thickness: 0.5, color: Colors.grey[200], indent: 16, endIndent: 16));
    }
  }
  return widgets;
}