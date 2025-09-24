import 'package:flutter/material.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16.0),
        ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0, right: 16.0, left: 16.0),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.info_outline, color: Colors.grey[500], size: 20),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    if (subTitle != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          subTitle,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                      textAlign: TextAlign.start,
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

Widget buildNutrientDisplayColumn(String nutrientName, String? value, Color dotColor) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    child: Row(
      textDirection: TextDirection.ltr,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nutrientName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 2),
            Text(
              value ?? "-",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    ),
  );
}

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

  return Column(
    children: [
      IntrinsicHeight(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: buildNutrientDisplayColumn(displayName, p1Value, p1DotColor),
            ),
            VerticalDivider(width: 1.0, thickness: 0.5, color: Colors.grey[300]),
            Expanded(
              child: buildNutrientDisplayColumn(
                displayName,
                p2Value,
                p2Data != null ? p2DotColor : Colors.transparent,
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