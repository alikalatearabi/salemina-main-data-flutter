import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DietaryAndHealthConsiderations extends StatefulWidget {

  const DietaryAndHealthConsiderations({
    Key? key,
  }) : super(key: key);

  @override
  State<DietaryAndHealthConsiderations> createState() => _DietaryAndHealthConsiderationsState();
}

class _DietaryAndHealthConsiderationsState extends State<DietaryAndHealthConsiderations> {


  @override
  void initState() {
    super.initState();
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
          const SizedBox(height: 10),
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
                _healthItem('assets/icons/activity.svg', 'میزان فعالیت', 'متوسط'),
                _healthItem('assets/icons/liver.svg', 'بیماری‌ها', 'کبد چرب'),
                _healthItem('assets/icons/weight.svg', 'وضعیت اندام‌ها', 'معمولی'),
                _healthItem('assets/icons/vegetarian.svg', 'ترجیحات غذایی', 'گیاه خواری (Vegetarianism)'),
                _healthItem('assets/icons/allergy.svg', 'آلرژی‌ها', '۳ مورد'),
                _healthItem('assets/icons/water.svg', 'میزان آب', '۹ لیوان'),
              ],
            ),
          ),
        ],
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
