import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                iconEnabledColor: const Color(0xFF018A08),
                                items: ['قاشق غذاخوری', 'گرم', 'میلی‌لیتر']
                                    .map((u) => DropdownMenuItem<String>(
                                  value: u,
                                  alignment: Alignment.centerRight,
                                  child: Text(u, textAlign: TextAlign.right),
                                ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() => _selectedUnit = val!);
                                },
                              ),
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (val) => setState(() => _consumption = val),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'میزان مصرف خود را وارد کنید.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'وضعیت مصرف امروز',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Icon(
                              _expanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_expanded)
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _metrics.length,
                          itemBuilder: (context, index) {
                            final m = _metrics[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: LinearProgressIndicator(
                                        minHeight: 6,
                                        value: (m.current / m.goal).clamp(0.0, 1.0),
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation<Color>(m.barColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF018A08),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * 0.8769,
                    MediaQuery.of(context).size.height * 0.0610,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("تأیید و ذخیره",
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ],
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
