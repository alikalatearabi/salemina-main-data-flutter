import 'package:flutter/material.dart';

class AddMealButton extends StatelessWidget {
  final Function onPressed;

  const AddMealButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () => onPressed(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(
                color: Color(0xFF82C786),
                width: 1,
              ),
              elevation: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text(
                  'مصرف وعده غذایی',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
