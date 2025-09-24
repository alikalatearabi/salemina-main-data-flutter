import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/health_warning.dart';

class RiskDetailsModal extends StatelessWidget {
  final HealthWarning warning;
  const RiskDetailsModal({super.key, required this.warning});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9, // 90% ارتفاع صفحه
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 25),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Grab Handle
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3E6EA),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.multiply, size: 24),
                ),
                Expanded(
                  child: Text(
                    warning.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 40), // For centering title
              ],
            ),
            const SizedBox(height: 16),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      warning.fullDescription,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14, height: 1.8, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    if (warning.relatedProducts.isNotEmpty)
                      const Text(
                        'محصولات مرتبط',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(height: 8),
                    ...warning.relatedProducts.map((product) => _RelatedProductItem(product: product)),
                  ],
                ),
              ),
            ),
            // "Got it" Button
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0F2E9),
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'متوجه شدم',
                style: TextStyle(
                  color: Color(0xFF018A08),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatedProductItem extends StatelessWidget {
  final RelatedProduct product;
  const _RelatedProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product.calories} کالری در هر ۱۴۵ گرم',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildNutrientInfo('چربی', product.fat, Colors.yellow.shade700),
                    const SizedBox(width: 8),
                    _buildNutrientInfo('نمک', product.salt, Colors.pink.shade300),
                    const SizedBox(width: 8),
                    _buildNutrientInfo('شکر', product.sugar, Colors.blue.shade300),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            // child: Image.network(product.imageUrl), // if you have image urls
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String name, String value, Color color) {
    return Row(
      children: [
        Text(
          '$value گرم',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 4),
        Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
      ],
    );
  }
}