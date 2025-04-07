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

  Color _getInactiveColor(double value) {
    if (value >= 0 && value < 25) {
      return Colors.green[800]!;
    } else if (value >= 25 && value < 50) {
      return Colors.green[400]!;
    } else if (value >= 50 && value < 75) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 15),
      decoration:  const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(600,50),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration:  const BoxDecoration(
              color: Color(0xFFE3E6EA),
              borderRadius: BorderRadius.all(
                 Radius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 40,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.title,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Column(
            children: [
              SfSlider(
                shouldAlwaysShowTooltip: true,
                enableTooltip: true,
                min: widget.minValue,
                max: widget.maxValue,
                value: _currentValue,
                interval: (widget.maxValue - widget.minValue) / 4,
                showLabels: false,
                inactiveColor: _getInactiveColor(_currentValue),
                onChanged: null,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("کم"),
                    Text("متوسط"),
                    Text("خوب"),
                    Text("زیاد"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.87692307692307692307692307692308,
                MediaQuery.of(context).size.height * 0.06106870229007633587786259541985,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "متوجه شدم",
                  style: TextStyle(
                    color: Color(0xFF015B05),
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
