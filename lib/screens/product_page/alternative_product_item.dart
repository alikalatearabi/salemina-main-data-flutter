import 'package:flutter/material.dart';
import 'package:main_app/screens/product_page/product_page.dart';
import 'alternative_product.dart';

class AlternativeProductItem extends StatelessWidget {
  final AlternativeProduct product;

  const AlternativeProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductPage()),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imagePath,
                width: MediaQuery.of(context).size.width * 0.1846,
                height: MediaQuery.of(context).size.height * 0.0916,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6512,
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 14),
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Icon(Icons.circle, size: 8, color: Color(0XFF464E59)),
                    const SizedBox(width: 2),
                    Text(product.calories,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Text("در هر ${product.weight}",
                      style: const TextStyle(
                        color: Color(0xFF657380),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6512,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildValueIndicator('چربی', product.values['چربی']!, Color(0XFFAE701E)),
                      _buildValueIndicator('اسید چرب', product.values['اسید چرب']!, Color(0XFF492AB2)),
                      _buildValueIndicator('نمک', product.values['نمک']!, Color(0XFFD44661)),
                      _buildValueIndicator('قند', product.values['قند']!, Color(0XFF286C9A)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueIndicator(String title, String value, Color color) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 2),
        Text(value,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}


