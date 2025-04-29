import 'package:flutter/material.dart';
import 'package:main_app/models/user_data.dart';
import 'package:main_app/screens/personal_info/height_page.dart';
import 'package:main_app/services/user_service.dart';
import 'package:main_app/utility/english_to_persian_number.dart';
import 'package:shamsi_date/shamsi_date.dart';

class BirthdayPage extends StatefulWidget {
  final int userId;
  
  const BirthdayPage({super.key, required this.userId});

  @override
  BirthdayPageState createState() => BirthdayPageState();
}

class BirthdayPageState extends State<BirthdayPage> {
  bool _isButtonEnabled = true;
  bool _isLoading = false;
  late UserData userData;

  // Get today's date in Jalali
  final Jalali today = Jalali.now();
  late int selectedDay = today.day;
  late int selectedMonth = today.month;
  late int selectedYear = today.year;

  final List<String> persianMonths = [
    "فروردین",
    "اردیبهشت",
    "خرداد",
    "تیر",
    "مرداد",
    "شهریور",
    "مهر",
    "آبان",
    "آذر",
    "دی",
    "بهمن",
    "اسفند"
  ];

  @override
  void initState() {
    super.initState();
    userData = UserData.getInstance(widget.userId);
    
    // Pre-fill birthdate if it already exists
    if (userData.birthYear != null && userData.birthMonth != null && userData.birthDay != null) {
      selectedYear = userData.birthYear!;
      selectedMonth = userData.birthMonth!;
      selectedDay = userData.birthDay!;
    }
  }

  Future<void> _submitBasicInfo() async {
    setState(() {
      _isLoading = true;
      _isButtonEnabled = false;
    });
    
    try {
      // Save birth date to UserData model
      userData.birthYear = selectedYear;
      userData.birthMonth = selectedMonth;
      userData.birthDay = selectedDay;
      
      // Submit data to API if all data is available
      if (userData.hasCompletedBasicInfo) {
        await UserService.submitBasicInfoWithJalali(
          userId: userData.userId,
          name: userData.name!,
          gender: userData.gender!,
          birthYear: userData.birthYear!,
          birthMonth: userData.birthMonth!,
          birthDay: userData.birthDay!,
        );
      }
      
      // Navigate to next page
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeightPage(userId: widget.userId),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isButtonEnabled = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ClipPath(
          clipper: ArcClipper(),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 60,
              bottom: 30,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  const Text(
                    'تاریخ تولد خود را مشخص کنید',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBirthdayField(),
                  const Spacer(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Submit button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isButtonEnabled ? _submitBasicInfo : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled
              ? const Color(0xFF018A08)
              : const Color(0x929EABCC),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: _isLoading 
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
        label: const Text(
          "تایید و ادامه",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ),
    );
  }

  // Header widget
  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Text(
                "تاریخ تولد",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF018A08),
                width: 2.0,
              ),
            ),
            child: const Text(
              "۳ از ۱۲",
              style: TextStyle(
                color: Color(0xFF018A08),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayField() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Day picker, with dynamic limit based on selected year and month
            _buildListWheel(
              itemCount: _getMaxDayCount(),
              initialItem: _getMaxDayCount() - selectedDay,
              onSelectedItemChanged: (index) => setState(() {
                selectedDay = _getMaxDayCount() - index;
              }),
              itemBuilder: (context, index) => _buildDateItem(
                _getMaxDayCount() - index,
                selectedDay,
                isMonth: false,
              ),
              width: 80,
            ),
            // Month picker, limited if current year is selected
            _buildListWheel(
              itemCount: _getMaxMonthCount(),
              initialItem: _getMaxMonthCount() - selectedMonth,
              onSelectedItemChanged: (index) => setState(() {
                selectedMonth = _getMaxMonthCount() - index;
                if (selectedYear == today.year &&
                    selectedMonth == today.month) {
                  selectedDay =
                      selectedDay > today.day ? today.day : selectedDay;
                }
              }),
              itemBuilder: (context, index) => _buildDateItem(
                persianMonths[_getMaxMonthCount() - 1 - index],
                persianMonths[selectedMonth - 1],
                isMonth: true,
              ),
              width: 120, // Wider for month names
            ),
            // Year picker, limited to current year
            _buildListWheel(
              itemCount: today.year - 1300 + 1,
              initialItem: (today.year - 1300 + 1) - (selectedYear - 1300) - 1,
              onSelectedItemChanged: (index) => setState(() {
                selectedYear = today.year - index;
                if (selectedYear == today.year) {
                  selectedMonth =
                      selectedMonth > today.month ? today.month : selectedMonth;
                  if (selectedMonth == today.month) {
                    selectedDay =
                        selectedDay > today.day ? today.day : selectedDay;
                  }
                }
              }),
              itemBuilder: (context, index) => _buildDateItem(
                today.year - index,
                selectedYear,
                isMonth: false,
              ),
              width: 80,
            ),
          ],
        ),
        IgnorePointer(
          child: Container(
            margin: const EdgeInsets.only(bottom: 18),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF018A08), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  // Build a single item with opacity based on selection
  Widget _buildDateItem(dynamic item, dynamic selectedItem, {bool isMonth = false}) {
    return Text(
      toPersianNumber(item.toString()),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: isMonth ? 15 : 22, // Smaller font for month names
        color:
            item == selectedItem ? Colors.black : Colors.black.withOpacity(0.4),
      ),
    );
  }

  // Calculate max days based on selected year and month
  int _getMaxDayCount() {
    if (selectedYear == today.year && selectedMonth == today.month) {
      return today.day;
    }
    return 31;
  }

  // Calculate max months based on selected year
  int _getMaxMonthCount() {
    if (selectedYear == today.year) {
      return today.month;
    }
    return 12;
  }

  // Reusable ListWheel for days, months, years
  Widget _buildListWheel({
    required int itemCount,
    required int initialItem,
    required ValueChanged<int> onSelectedItemChanged,
    required IndexedWidgetBuilder itemBuilder,
    double width = 80,
  }) {
    return SizedBox(
      width: width,
      height: 150,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        controller: FixedExtentScrollController(initialItem: initialItem),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: itemBuilder,
          childCount: itemCount,
        ),
      ),
    );
  }
}

// Custom clipper for the arc shape at the top
class ArcClipper extends CustomClipper<Path> {
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
