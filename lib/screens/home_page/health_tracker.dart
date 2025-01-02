import 'package:flutter/material.dart';

class HealthTracker extends StatelessWidget {
  final double healthValue;

  const HealthTracker({super.key, required this.healthValue});

  @override
  Widget build(BuildContext context) {
    bool isHealthy = healthValue >= 0.5;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        isHealthy ? 'سلامت کامل' : 'ریسک بالا',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              isHealthy
                                  ? Colors.green.shade50
                                  : Colors.red.shade100,
                              Colors.white,
                            ],
                            stops: const [0.0, 0.7],
                            center: Alignment.center,
                            radius: 0.8,
                          ),
                        ),
                        child: Icon(
                          isHealthy
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          color:
                              isHealthy ? Colors.green : const Color(0xFFD44661),
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: healthValue,
                  backgroundColor: Colors.grey[200],
                  color: isHealthy ? Colors.green : const Color(0xFFD44661),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
