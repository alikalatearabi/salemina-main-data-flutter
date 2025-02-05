import 'package:flutter/material.dart';

class ActionButtonWithModal extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget Function(BuildContext) modalBuilder;

  const ActionButtonWithModal({
    super.key,
    required this.label,
    required this.icon,
    required this.modalBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: modalBuilder,
        );
      },
      icon: Icon(
        icon,
        color: const Color(0xFF018A08),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF018A08),
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 4,
        side: const BorderSide(
          color: Color(0xFF82C786),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
