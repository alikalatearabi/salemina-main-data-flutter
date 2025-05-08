import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddingMeal extends StatefulWidget {
  const AddingMeal({Key? key}) : super(key: key);

  @override
  State<AddingMeal> createState() => _AddingMealState();
}

class _AddingMealState extends State<AddingMeal> {
  final _formKey = GlobalKey<FormState>();
  String _consumption = '';
  String _selectedUnit = 'قاشق غذاخوری';
  bool _expanded = false;

  final List<_Metric> _metrics = [
    _Metric(name: 'کالری', current: 845, diff: 42, goal: 2000, barColor: Color(0xFF464E59)),
    _Metric(name: 'چربی', current: 55, diff: 0.8, goal: 70, barColor: Color(0xFFF5AE32)),
    _Metric(name: 'اسیدهای چرب ترانس', current: 0.8, diff: 0.1, goal: 2, barColor: Color(0xFF8348F9)),
    _Metric(name: 'قند', current: 7, diff: 0.7, goal: 30, barColor: Color(0xFFF2506E)),
    _Metric(name: 'نمک', current: 0.8, diff: 0.2, goal: 5, barColor: Color(0xFF4BB4D7)),
  ];

  Widget _buildThreeSegmentBar(_Metric m) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final curFraction = (m.current / m.goal).clamp(0.0, 1.0);
          final diffFraction = (m.diff / m.goal).clamp(0.0, 1.0 - curFraction);
          final curWidth  = totalWidth * curFraction;
          final diffWidth = totalWidth * diffFraction;
          final remWidth  = totalWidth - curWidth - diffWidth;
          return Row(
            children: [
              Container(width: curWidth, height: 6, color: m.barColor),
              Container(width: diffWidth, height: 6, color: m.barColor.withOpacity(0.4)),
              Container(width: remWidth, height: 6, color: Colors.grey.shade200),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final maxHeight = MediaQuery.of(context).size.height * 0.8;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 25, left: 24, right: 24, top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(600, 50)),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'افزودن به لیست مصرف',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'لطفا میزان مصرف خود را وارد کنید.',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'مثلا: 12 $_selectedUnit',
                            prefixIcon: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: DropdownButtonHideUnderline(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    value: _selectedUnit,
                                    isDense: true,
                                    isExpanded: false,
                                    underline: const SizedBox(),
                                    style: const TextStyle(
                                      color: Color(0xFF018A08),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                    dropdownColor: Colors.white,
                                    icon: const Icon(CupertinoIcons.chevron_down, size: 12, color: Color(0xFF018A08)),
                                    items: ['قاشق غذاخوری', 'گرم', 'میلی‌لیتر']
                                        .map((u) => DropdownMenuItem<String>(
                                      value: u,
                                      alignment: Alignment.centerRight,
                                      child: Text(u, textAlign: TextAlign.right),
                                    ))
                                        .toList(),
                                    onChanged: (val) => setState(() => _selectedUnit = val!),
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onChanged: (val) => setState(() => _consumption = val),
                          validator: (val) => val == null || val.isEmpty ? 'میزان مصرف خود را وارد کنید' : null,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => setState(() => _expanded = !_expanded),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFFF9FAFB),
                                borderRadius: _expanded? BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),) : BorderRadius.circular(8),
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'وضعیت مصرف امروز',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                                ),
                                _expanded ?
                                SvgPicture.asset(
                                  'assets/icons/arrow-up.svg',
                                  width: 20,
                                  height: 20,
                                  color: Color(0xFF232A34),
                                )
                                :
                                SvgPicture.asset(
                                  'assets/icons/arrow-down.svg',
                                  width: 20,
                                  height: 20,
                                  color: Color(0xFF232A34),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_expanded)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _metrics.length,
                            itemBuilder: (context, index) {
                              final m = _metrics[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(m.name, style: const TextStyle(fontSize: 13)),
                                        Text(
                                          '${m.current.toStringAsFixed(1)}  +${m.diff.toStringAsFixed(1)}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    _buildThreeSegmentBar(m),
                                  ],
                                ),
                              );
                            },
                          ),
                        if (_expanded)
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        final messenger = ScaffoldMessenger.of(context);
                        Navigator.of(context).pop();
                        messenger.showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            duration: const Duration(seconds: 2),
                            content: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      messenger.hideCurrentSnackBar();
                                    },
                                    child: Icon(Icons.close, size: 20, color: Color(0xFF647482)),
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'میزان مصرف با موفقیت ثبت شد.',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF284740),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_check.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF018A08),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.8769,
                        MediaQuery.of(context).size.height * 0.061,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "تأیید و ذخیره",
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Metric {
  final String name;
  final double current;
  final double diff;
  final double goal;
  final Color barColor;

  _Metric({
    required this.name,
    required this.current,
    required this.diff,
    required this.goal,
    required this.barColor,
  });
}
