// lib/widgets/product_card_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildEditIcon({double size = 20}) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFFE6F4EA).withOpacity(0.7),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Icon(Icons.edit_outlined, color: Colors.green[700], size: size),
  );
}

Widget buildFullProductCard(Map<String, dynamic>? productData, BuildContext context) {
  if (productData == null) return SizedBox(width:  MediaQuery.of(context).size.width/2-20);

  return Container(
    width:  MediaQuery.of(context).size.width/2-20,
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildEditIcon(),
            SizedBox(width: 15,),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/eges.png",
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Expanded(
                      child: Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey[600]),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          productData['name'],
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          productData['brand'],
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget buildAddProductFullCardButton({
  required BuildContext context,
  required VoidCallback onTap,
  required double height,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width:  MediaQuery.of(context).size.width/2-20,
      height:height,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.green[700], size: 30),
          const SizedBox(height: 8),
          Text(
            "افزودن محصول",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green[700], fontSize: 13),
          ),
        ],
      ),
    ),
  );
}

Widget buildStickyProductSummary(Map<String, dynamic> productData) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric( horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          buildEditIcon(size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productData['name'],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start, // راست چین در RTL
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  productData['brand'],
                  style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                  textAlign: TextAlign.start, // راست چین در RTL
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}