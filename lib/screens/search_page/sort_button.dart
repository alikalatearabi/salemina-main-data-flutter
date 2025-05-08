import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dietary_and_health_considerations.dart';

class SortButton extends StatefulWidget {
  final int? initialIndex;

  const SortButton({
    Key? key,
    this.initialIndex,
  }) : super(key: key);

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  late int selectedIndex;
  late bool infoSelected=false;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 25, left: 24, right: 24, top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(600, 50),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE3E6EA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (!infoSelected)
          Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'مرتب‌سازی بر اساس',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                _buildSortItem('سالمترین', 0),
                _buildSortItem('کمترین کالری', 1),
                _buildSortItem('کمترین قند', 2),
                _buildSortItem('کمترین چربی', 3),
                _buildSortItem('کمترین اسید چرب', 4),
                _buildSortItem('کمترین نمک', 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          infoSelected = true;
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/info-circle.svg',
                        width: 20,
                        height: 20,
                        color: Color(0xFF232A34),
                      ),
                    ),
                    _buildSortItem('بر اساس ملاحظات غذایی و سلامتی', 6),
                  ],
                ),
              ],
            ),
          ),
          if (infoSelected)
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF9FDF9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'ملاحظات غذایی و سلامتی',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _healthItem('assets/icons/biking.svg', 'میزان فعالیت', 'متوسط'),
                  _healthItem('assets/icons/stethoscope.svg', 'بیماری‌ها', 'کبد چرب'),
                  _healthItem('assets/icons/dinner.svg', 'وضعیت اشتها', 'معمولی'),
                  _healthItem('assets/icons/apple.svg', 'ترجیحات غذایی', 'گیاه خواری (Vegetarianism)'),
                  _healthItem('assets/icons/virus.svg', 'آلرژی‌ها', '۳ مورد'),
                  _healthItem('assets/icons/Glass of Water.svg', 'میزان آب', '۹ لیوان'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSortItem(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.pop(context, index);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: selectedIndex,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  selectedIndex = value!;
                });

                Future.delayed(const Duration(milliseconds: 150), () {
                  Navigator.pop(context, value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _healthItem(String iconPath, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF018A08),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            color: Color(0xFF018A08),
          ),
        ],
      ),
    );
  }
}
