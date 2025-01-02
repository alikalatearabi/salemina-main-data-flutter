import 'package:flutter/material.dart';


class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  WaterTrackerState createState() => WaterTrackerState();
}

class WaterTrackerState extends State<WaterTracker> {
  int _selectedCups = 0;
  final int _totalCups = 9;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and count display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.green.shade50,
                              Colors.green.shade50,
                              Colors.white,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                            center: Alignment.center,
                            radius: 0.8,
                          ),
                        ),
                        child: const Icon(
                          Icons.water_drop,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'آب',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_selectedCups از $_totalCups لیوان',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Clickable water drops
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _totalCups,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        // Update selected cups based on user click
                        if (index < _selectedCups) {
                          _selectedCups = index; // Deselect cup
                        } else {
                          _selectedCups = index + 1; // Select cup
                        }
                      });
                    },
                    child: Icon(
                      Icons.water_drop_outlined,
                      color: index < _selectedCups
                          ? Colors.blue
                          : Colors.grey[300],
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
