import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/home_page/risk_details_modal.dart';
import 'package:main_app/screens/home_page/services/mock_warning_service.dart';

import 'health_helpers.dart';
import 'models/health_warning.dart';

class HealthWarningsPage extends StatefulWidget {
  final HealthStatusInfo statusInfo;

  const HealthWarningsPage({super.key, required this.statusInfo});

  @override
  State<HealthWarningsPage> createState() => _HealthWarningsPageState();
}

class _HealthWarningsPageState extends State<HealthWarningsPage> {
  late Future<List<HealthWarning>> _warningsFuture;
  final MockWarningService _warningService = MockWarningService();

  @override
  void initState() {
    super.initState();
    _warningsFuture = _warningService.getHealthWarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'هشدارهای سلامتی',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(widget.statusInfo.iconAsset, width: 80, height: 80),
            const SizedBox(height: 24),
            Text(
              widget.statusInfo.title,
              style: TextStyle(
                color: widget.statusInfo.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'با توجه به بیماری‌ها و ترجیحات غذایی شما و محصولاتی که به لیست مصرف افزوده‌اید، سلامتی شما را رصد میکنیم. برای حفظ سلامتی خود لطفا به هشدارهای زیر توجه نمایید.',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14, height: 1.8, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<HealthWarning>>(
                    future: _warningsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('خطا در دریافت اطلاعات'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('هیچ هشداری یافت نشد'));
                      }

                      final warnings = snapshot.data!;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: warnings.length,
                        itemBuilder: (context, index) {
                          return _WarningListItem(warning: warnings[index]);
                        },
                        separatorBuilder: (context, index) => const Divider(height: 1),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WarningListItem extends StatelessWidget {
  final HealthWarning warning;
  const _WarningListItem({required this.warning});

  // Helper to get tag properties
  Map<String, dynamic> _getTagProperties(RiskTagLevel level) {
    switch (level) {
      case RiskTagLevel.high:
        return {'text': 'ریسک بالا', 'bgColor': Colors.red.shade100, 'textColor': Colors.red.shade800};
      case RiskTagLevel.medium:
        return {'text': 'ریسک متوسط', 'bgColor': Colors.orange.shade100, 'textColor': Colors.orange.shade800};
      case RiskTagLevel.low:
        return {'text': 'ریسک کم', 'bgColor': Colors.yellow.shade200, 'textColor': Colors.yellow.shade900};
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagProps = _getTagProperties(warning.riskTagLevel);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RiskDetailsModal(warning: warning),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: tagProps['bgColor'],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tagProps['text'],
                style: TextStyle(color: tagProps['textColor'], fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.ltr,
                children: [
                  Flexible(
                    child: Text(
                      warning.title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEF1F3),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      warning.id.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
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