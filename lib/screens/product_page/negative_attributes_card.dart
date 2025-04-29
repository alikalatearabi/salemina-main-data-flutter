import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/home_page/utils.dart';

import 'food_item_data.dart';

class NegativeAttributesCard extends StatelessWidget {
  final List<FoodItemData> foodItems;

  const NegativeAttributesCard({Key? key, required this.foodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF929EAA).withOpacity(0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Text(
                        'توضیحات',
                        style: TextStyle(
                          color: Color(0xFF018A08),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.info,
                        color: Color(0xFF018A08),
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/close-circle-2.svg',
                      width: 16,
                      height: 16,
                      color: const Color(0xFFD24661),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ویژگی های منفی',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...foodItems.map((item) {
            Color effectiveStatusTextColor = item.statusTextColor ?? Colors.black;
            Color effectiveStatusBgColor = effectiveStatusTextColor.withOpacity(0.2);
            
            // Convert value to Persian
            String valueStr = '${item.value} ${item.unit}';
            try {
              valueStr = '${toPersianNumber(item.value.toString())} ${item.unit}';
            } catch (e) {
              // Keep original value in case of error
            }
            
            return Container(
              padding: const EdgeInsets.only(bottom: 2, top: 2, left: 16, right: 16),
              child: Column(
                children: [
                  _buildInfoRow(
                    label: item.label,
                    value: valueStr,
                    status: item.status,
                    statusTextColor: effectiveStatusTextColor,
                    statusBgColor: effectiveStatusBgColor,
                    icon: item.icon,
                  ),
                  if (item != foodItems.last)
                    Divider(thickness: 1, color: const Color(0xFF929EAA).withOpacity(0.24)),
                  if (item == foodItems.last)
                    SizedBox(height: 8,)
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required String status,
    required Color statusTextColor,
    required Color statusBgColor,
    required Widget icon,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            icon,
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF232A34), fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF657381)),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: statusTextColor,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}

