import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../utility/english_to_persian_number.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class PersianDatePickerModalContent extends StatefulWidget {
  final Jalali initialDate;
  final Function(Jalali) onDateSelected;

  const PersianDatePickerModalContent({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<PersianDatePickerModalContent> createState() => _PersianDatePickerModalContentState();
}

class _PersianDatePickerModalContentState extends State<PersianDatePickerModalContent> {
  late Jalali today;
  late int tempSelectedDay;
  late int tempSelectedMonth;
  late int tempSelectedYear;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  final List<String> persianMonths = ["فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"];
  final int yearPickerRange = 10;
  late List<int> years;
  late List<int> months;
  late List<int> days;

  @override
  void initState() {
    super.initState();
    today = Jalali.now();
    Jalali safeInitialDate = _isJalaliBefore(widget.initialDate, today) ? today : widget.initialDate;

    tempSelectedDay = safeInitialDate.day;
    tempSelectedMonth = safeInitialDate.month;
    tempSelectedYear = safeInitialDate.year;

    _populateDateLists();
    _initializeControllers();
  }

  void _populateDateLists() {
    years = List<int>.generate(yearPickerRange, (i) => today.year + i);
    months = _getValidMonths(tempSelectedYear);
    days = _getValidDays(tempSelectedYear, tempSelectedMonth);
  }
  void _initializeControllers() {
    // اطمینان از اینکه مقادیر اولیه در لیست‌های جدید وجود دارند
    if (!years.contains(tempSelectedYear)) tempSelectedYear = years.first;
    if (!months.contains(tempSelectedMonth)) tempSelectedMonth = months.first;
    if (!days.contains(tempSelectedDay)) tempSelectedDay = days.first;

    dayController = FixedExtentScrollController(initialItem: days.indexOf(tempSelectedDay));
    monthController = FixedExtentScrollController(initialItem: months.indexOf(tempSelectedMonth));
    yearController = FixedExtentScrollController(initialItem: years.indexOf(tempSelectedYear));
  }


  bool _isJalaliBefore(Jalali date1, Jalali date2) {
    if (date1.year < date2.year) return true;
    if (date1.year > date2.year) return false;
    if (date1.month < date2.month) return true;
    if (date1.month > date2.month) return false;
    return date1.day < date2.day;
  }

  List<int> _getValidYears() {
    return List<int>.generate(yearPickerRange, (i) => today.year + i);
  }

  List<int> _getValidMonths(int selectedYear) {
    int startMonth = (selectedYear == today.year) ? today.month : 1;
    return List<int>.generate(12 - startMonth + 1, (i) => startMonth + i);
  }

  List<int> _getValidDays(int selectedYear, int selectedMonth) {
    int startDay = (selectedYear == today.year && selectedMonth == today.month) ? today.day : 1;
    int daysInMonth;
    try { daysInMonth = Jalali(selectedYear, selectedMonth, 1).monthLength; } catch (_) { daysInMonth = 31; }
    return List<int>.generate(daysInMonth - startDay + 1, (i) => startDay + i);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            Text("انتخاب تاریخ شروع", style: titleTextStyle(), textAlign: TextAlign.right),
            const SizedBox(width: 40)
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPersianListWheel(
                    controller: dayController,
                    itemCount: days.length,
                    initialItem: days.indexOf(tempSelectedDay),
                    onSelectedItemChanged: (index) {
                      setState(() { tempSelectedDay = days[index]; });
                    },
                    itemBuilder: (context, index) => _buildPersianDateItem(days[index], tempSelectedDay),
                    width: 70,
                  ),
                  _buildPersianListWheel(
                    controller: monthController,
                    itemCount: months.length,
                    initialItem: months.indexOf(tempSelectedMonth),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        tempSelectedMonth = months[index];
                        days = _getValidDays(tempSelectedYear, tempSelectedMonth);
                        if (!days.contains(tempSelectedDay)) tempSelectedDay = days.first;
                        dayController.jumpToItem(days.indexOf(tempSelectedDay));
                      });
                    },
                    itemBuilder: (context, index) => _buildPersianDateItem(persianMonths[months[index] - 1], persianMonths[tempSelectedMonth - 1], isMonth: true),
                    width: 110,
                  ),
                  _buildPersianListWheel(
                    controller: yearController,
                    itemCount: years.length,
                    initialItem: years.indexOf(tempSelectedYear),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        tempSelectedYear = years[index];
                        months = _getValidMonths(tempSelectedYear);
                        if (!months.contains(tempSelectedMonth)) tempSelectedMonth = months.first;
                        monthController.jumpToItem(months.indexOf(tempSelectedMonth));
                        days = _getValidDays(tempSelectedYear, tempSelectedMonth);
                        if (!days.contains(tempSelectedDay)) tempSelectedDay = days.first;
                        dayController.jumpToItem(days.indexOf(tempSelectedDay));
                      });
                    },
                    itemBuilder: (context, index) => _buildPersianDateItem(years[index], tempSelectedYear),
                    width: 90,
                  ),
                ],
              ),
              IgnorePointer(child: Container(margin: const EdgeInsets.only(bottom: 0), width: MediaQuery.of(context).size.width * 0.85, height: 50, decoration: BoxDecoration(border: Border.all(color: primaryGreen, width: 1.5), borderRadius: BorderRadius.circular(12)))),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
              label: const Text("ورود/ثبت نام با شماره موبایل", style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                try {
                  final pickedJalali = Jalali(tempSelectedYear, tempSelectedMonth, tempSelectedDay);
                  if (_isJalaliBefore(pickedJalali, today)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تاریخ انتخاب شده نمی‌تواند قبل از امروز باشد.', textDirection: TextDirection.rtl)));
                    return;
                  }
                  widget.onDateSelected(pickedJalali);
                  Navigator.pop(context);
                } on ArgumentError catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تاریخ انتخاب شده معتبر نیست.', textDirection: TextDirection.rtl)));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا در انتخاب تاریخ: $e', textDirection: TextDirection.rtl)));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, padding: const EdgeInsets.symmetric( vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPersianListWheel({required FixedExtentScrollController controller, required int itemCount, required int initialItem, required ValueChanged<int> onSelectedItemChanged, required IndexedWidgetBuilder itemBuilder, double width = 80}) {
    final int safeInitialItem = (itemCount <= 0 || initialItem < 0 || initialItem >= itemCount) ? 0 : initialItem;
    // در initState کنترلرها با آیتم امن ساخته می‌شوند، اینجا فقط از آنها استفاده می‌کنیم.
    return SizedBox(
      width: width, height: 180,
      child: itemCount <= 0 ? const Center(child: Text("-")) : ListWheelScrollView.useDelegate(
        controller: controller, // استفاده مستقیم از کنترلر پاس داده شده
        itemExtent: 50, diameterRatio: 1.2, physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(builder: itemBuilder, childCount: itemCount),
      ),
    );
  }

  Widget _buildPersianDateItem(dynamic item, dynamic selectedItem, {bool isMonth = false}) {
    return Center(
      child: Text(
        toPersianNumber(item.toString()), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: isMonth ? 16 : 20, fontWeight: item == selectedItem ? FontWeight.bold : FontWeight.normal, color: item == selectedItem ? Colors.black87 : Colors.grey.shade500),
      ),
    );
  }
}