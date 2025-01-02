import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[400],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: CircularProgressIndicator(
                value: 0.75,
                strokeWidth: 12,
                backgroundColor: Colors.green[300]!,
                color: Colors.white,
              ),
            ),
          ),
          const Column(
            children: [
              Text(
                '٥٥٥٥',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'از ٥٥٥٥ کیلوکالری',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
