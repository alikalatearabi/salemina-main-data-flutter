import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSliderBottomSheet extends StatefulWidget {
  final String title;

  final String description;

  final double minValue;

  final double maxValue;

  final double initialValue;

  final ValueChanged<double>? onValueChanged;

  const CustomSliderBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<CustomSliderBottomSheet> createState() => _CustomSliderBottomSheetState();
}

class _CustomSliderBottomSheetState extends State<CustomSliderBottomSheet> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          SfSlider(
            shouldAlwaysShowTooltip: true,
            min: widget.minValue,
            max: widget.maxValue,
            value: _currentValue,
            showLabels: true,
            interval: (widget.maxValue - widget.minValue) / 2,
            enableTooltip: true,
            onChanged: null,
            inactiveColor: Colors.red,
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop(_currentValue);
            },
            child: const Text(
              'متوجه شدم',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
