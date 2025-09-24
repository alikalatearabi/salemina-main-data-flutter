import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/utils.dart';

import 'custom_indicator_bottom_sheet.dart';
import 'food_item_data.dart';

class FoodInfoCard extends StatelessWidget {
  final List<FoodItemData> foodItems;

  const FoodInfoCard({super.key, required this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF929EAA).withOpacity(0.24)),
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
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomIndicatorBottomSheet(
                            title: 'اطلاعات شاخص',
                            description: 'توضیحات تکمیلی درباره شاخص های تغذیه‌ای',
                            minValue: 0,
                            maxValue: 100,
                            initialValue: 50,
                          );
                        },
                      );
                    },
                    child: Icon(Icons.info_outline, color: Color(0xFF464E59), size: 18)
                ),
                const Text(
                  'اطلاعات تغذیه ای',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
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
                    Divider(thickness:1, color: Color(0xFF929EAA).withOpacity(0.24)),
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
                  style: TextStyle(fontSize: 12, color: Color(0xFF232A34),fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 12, color: Color(0xFF657381)),
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
              fontSize:12,
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
