import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'health_helpers.dart';

class HealthStatusWidget extends StatefulWidget {
  final String? healthIcon;
  final String? healthText;
  final int? healthLevel;
  final int maxHealthLevel;

  const HealthStatusWidget({
    super.key,
    this.healthIcon,
    this.healthText,
    this.healthLevel,
    this.maxHealthLevel = 6, // Default value
  });

  @override
  State<HealthStatusWidget> createState() => _HealthStatusWidgetState();
}

class _HealthStatusWidgetState extends State<HealthStatusWidget> {
  bool _isLoading = true;
  String _healthIcon = 'emoji';
  String _healthText = 'سلامتی متوسط';
  int _healthLevel = 4;

  @override
  void initState() {
    super.initState();
    _fetchHealthData();
  }

  Future<void> _fetchHealthData() async {
    try {
      final healthData = await calculateHealthScore();
      if (mounted) {
        setState(() {
          _healthIcon = healthData['healthIcon'] ?? 'emoji';
          _healthText = healthData['healthText'] ?? 'سلامتی متوسط';
          _healthLevel = healthData['score'] ?? 4;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching health data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use provided values or calculated values
    final icon = widget.healthIcon ?? _healthIcon;
    final text = widget.healthText ?? _healthText;
    final level = widget.healthLevel ?? _healthLevel;

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
        child: _isLoading && widget.healthLevel == null
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/emoji.svg',
                    width: 56,
                    height: 56,
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                            color: Color(0xFF25A749),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: List.generate(widget.maxHealthLevel, (index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.10,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                height: 8,
                                decoration: BoxDecoration(
                                  color: index < level
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
