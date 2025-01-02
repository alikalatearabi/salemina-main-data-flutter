import 'package:flutter/material.dart';

class NutritionStats extends StatelessWidget {
  const NutritionStats({super.key});

  Widget _buildNutritionStat(String label, String value, bool isWhite) {
    final textColor = isWhite ? Colors.white : Colors.black;
    final secondaryColor = isWhite ? Colors.white70 : Colors.grey;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 12,
          ),
        ),
        Container(
          width: 50,
          height: 4,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: isWhite ? Colors.white30 : Colors.green.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNutritionStat('چربی', '٥٥٥', true),
          _buildNutritionStat('قند', '٥٥٥', true),
          _buildNutritionStat('اسید چرب', '٥٥٥', true),
          _buildNutritionStat('نمک', '٥٥٥', true),
        ],
      ),
    );
  }
}
