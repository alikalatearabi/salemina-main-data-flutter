import 'package:flutter/material.dart';

class HealthStatusWidget extends StatelessWidget {
  final String healthIcon;
  final String healthText;
  final int healthLevel;
  final int maxHealthLevel;

  const HealthStatusWidget({
    super.key,
    required this.healthIcon,
    required this.healthText,
    required this.healthLevel,
    this.maxHealthLevel = 6, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/$healthIcon.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 16),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    healthText,
                    style: const TextStyle(
                      color: Color(0xFF25A749),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: List.generate(maxHealthLevel, (index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 8,
                          decoration: BoxDecoration(
                            color: index < healthLevel
                                ? Colors.green
                                : Colors.grey[300],
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
      ),
    );
  }
}
