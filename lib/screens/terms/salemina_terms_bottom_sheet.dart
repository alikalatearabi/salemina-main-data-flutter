import 'package:flutter/material.dart';

class SaleminaTermsBottomSheet extends StatelessWidget {
  const SaleminaTermsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height * 0.92;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black54,
        child: GestureDetector(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: _TermsTopArcClipper(),
              child: Container(
                height: height,
                color: Colors.white,
                child: _buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                const Text(
                  'قوانین و مقررات سالمینا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 12),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'بیانیه استقلال سالمینا\n'
                  'در سالمینا، ما به استقلال و بی‌طرفی کامل متعهد هستیم. تمام اطلاعات و توصیه‌های تغذیه‌ای که ارائه می‌دهیم، بر اساس داده‌ها و تحلیل‌های علمیِ معتبر و به‌روز است و هیچ‌گونه تأثیر یا فشاری از سوی تولیدکنندگان یا توزیع‌کنندگان مواد غذایی بر نحوه ارائه اطلاعات وجود ندارد. هدف ما این است که به شما در انتخاب‌های غذایی سالم و آگاهانه کمک کنیم و این مهم را تنها با پایبندی به اصول صداقت، شفافیت و استقلال در تمامی خدماتمان دنبال می‌کنیم.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F5E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'متوجه شدم',
                  style: TextStyle(
                    color: Color(0xFF015B05),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsTopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 30);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
