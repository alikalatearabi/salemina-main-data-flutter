import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'health_helpers.dart';

class HealthStatusWidget extends StatelessWidget {
  final HealthStatusInfo statusInfo;
  final int maxHealthLevel;
  final VoidCallback? onWarningPressed;

  const HealthStatusWidget({
    super.key,
    required this.statusInfo,
    this.maxHealthLevel = 5,
    this.onWarningPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool showWarningButton = statusInfo.levelValue < maxHealthLevel;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            statusInfo.iconAsset,
            width: 56,
            height: 56,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      statusInfo.title,
                      style: TextStyle(
                        color: statusInfo.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (showWarningButton)
                      _buildWarningButton(),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(maxHealthLevel, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        height: 8,
                        decoration: BoxDecoration(
                          color: index < statusInfo.levelValue
                              ? statusInfo.color
                              : const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningButton() {
    return InkWell(
      onTap: onWarningPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFFDE7EA),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          children: [
            Text(
              '+۱۰ هشدار',
              style: TextStyle(
                color: Color(0xFFD93F54),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_right_rounded,
              color: Color(0xFFD93F54),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}