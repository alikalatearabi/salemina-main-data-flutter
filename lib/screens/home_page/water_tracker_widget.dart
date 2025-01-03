import 'package:flutter/material.dart';

class WaterTrackerWidget extends StatelessWidget {
  final int consumedGlasses;
  final int totalGlasses;
  final Function(int)? onGlassTap;

  const WaterTrackerWidget({
    Key? key,
    required this.consumedGlasses,
    required this.totalGlasses,
    this.onGlassTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'آب',
                  style: TextStyle(
                    color: Color(0xFF013C04),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(146, 228, 226, 226),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$consumedGlasses از $totalGlasses لیوان',
                    style: const TextStyle(
                      color: Color(0xFF232A34),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(totalGlasses, (index) {
                return GestureDetector(
                  onTap: () => onGlassTap?.call(index + 1),
                  child: Icon(
                    Icons.water_drop,
                    color: index < consumedGlasses
                        ? Colors.blue
                        : Colors.grey,
                    size: 30,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
