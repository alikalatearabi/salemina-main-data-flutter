
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../utility/english_to_persian_number.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../enums/page_type.dart';
import '../widgets/macro_circular_percent.dart';
import '../widgets/radio_option_item.dart';
import '../widgets/plan_detail_table.dart';
import '../widgets/persian_date_picker_modal_content.dart';


class ChooseYourPlanController {
  final BuildContext context;

  String? selectedDietType;
  Map<String, String> planDetailsData = {
    "قد": "۱۷۵ cm", "وزن": "۸۸ kg", "وزن ایده‌آل": "۷۴ kg",
    "برنامه غذایی": "معمولی", "میزان فعالیت": "متوسط", "آلرژی‌ها": "۳ مورد",
  };
  String? selectedPlanDifficulty;
  String? selectedStartDateOption;
  DateTime? selectedCalendarDate;
  Jalali? selectedJalaliDate;

  Map<String, bool> planDetailsEditMode = {};
  Map<String, TextEditingController> planDetailsControllers = {};

  ChooseYourPlanController(this.context) {
    planDetailsData.forEach((key, value) {
      planDetailsEditMode[key] = false;
      planDetailsControllers[key] = TextEditingController(text: value);
    });
  }

  void startPlanSelectionFlow() {
    _showSelectPlanTypeModal();
  }

  String monthToString(int month){
    switch(month){
      case 1: return "فروردین";
      case 2: return "اردیبهشت";
      case 3: return "خرداد";
      case 4: return "تیر";
      case 5: return "مرداد";
      case 6: return "شهریور";
      case 7: return "مهر";
      case 8: return "آبان";
      case 9: return "آذر";
      case 10: return "دی";
      case 11: return "بهمن";
      case 12: return "اسفند";
    }
    return "ماه";
  }

  String _formatJalaliToCompactString(Jalali j) {
    return "${toPersianNumber(j.day.toString())} ${monthToString(j.month)} ${toPersianNumber(j.year.toString())}";
  }

  String _formatJalaliToFullString(Jalali j) {
    return "${toPersianNumber(j.day.toString())} ${monthToString(j.month)} ${toPersianNumber(j.year.toString())}";
  }

  bool _isJalaliBefore(Jalali date1, Jalali date2) {
    if (date1.year < date2.year) return true;
    if (date1.year > date2.year) return false;
    if (date1.month < date2.month) return true;
    if (date1.month > date2.month) return false;
    return date1.day < date2.day;
  }


  void _showSelectPlanTypeModal({String? initialSelection}) {
    String? currentSelection = initialSelection ?? selectedDietType;
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              decoration: modalBoxDecoration(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SizedBox(width: 24), Text("انتخاب رژیم", style: titleTextStyle(), textAlign: TextAlign.right), const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54)]),
                    const SizedBox(height: 10),
                    Text("برای رسیدن به وزن ایده‌آل خودت، برنامه سلامت دلخواهت رو انتخاب کن.", style: TextStyle(color: Colors.black,fontSize: 14), textAlign: TextAlign.right),
                    const SizedBox(height: 20),
                    RadioOptionItem(title: "کالری شماری", subtitle: "شما می‌توانید با برنامه غذایی خودتان، کالری مصرفی روزانه خود را مشاهده و مدیریت نمایید.", value: "کالری شماری", groupValue: currentSelection, onChanged: (val) => modalSetState(() => currentSelection = val), pageType: PageType.dietType),
                    RadioOptionItem(title: "برنامه غذایی مخصوص", subtitle: "با رعایت وعده‌های غذایی پیشنهادی سالمینا، طی مدت مشخص به وزن ایده‌آل خود می‌رسید.", value: "برنامه غذایی مخصوص", groupValue: currentSelection, onChanged: (val) => modalSetState(() => currentSelection = val), pageType: PageType.dietType),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
                          label: const Text("تایید و ادامه", style: TextStyle(color: Colors.white)),
                          onPressed: currentSelection == null ? null : () {
                            selectedDietType = currentSelection;
                            Navigator.pop(context);
                            if (selectedDietType == "برنامه غذایی مخصوص") _showPlanDetailsModal();
                            else _showPlanDifficultyModal();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, disabledBackgroundColor: Colors.grey.shade300, padding: const EdgeInsets.symmetric(vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showPlanDetailsModal() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, modalSetState) {
          return Container(
            decoration: modalBoxDecoration(), padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  // ... (کدهای قبلی برای عنوان مدال و نمودارها) ...
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SizedBox(width: 24), Text("برنامه غذایی مخصوص", style: titleTextStyle(), textAlign: TextAlign.right), const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54)]),
                    const SizedBox(height: 10),
                    Text("رژیم کاهش وزن معمولی", style: titleTextStyle(fontSize: 16), textAlign: TextAlign.right),
                    const SizedBox(height: 10),
                    Text("با توجه به BMI محاسبه شده متناسب با وزن و قد و وزن هدف شما، برنامه غذایی زیر توسط متخصصین تغذیه سالمینا تهیه شده است.", style: subtitleTextStyle(), textAlign: TextAlign.right),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      MacroCircularPercentWidget(title: "پروتئین", percent: 0.50, percentText: "%۵۰"), // استفاده از ویجت جدا شده
                      MacroCircularPercentWidget(title: "کربوهیدرات", percent: 0.20, percentText: "%۲۰"),
                      MacroCircularPercentWidget(title: "چربی", percent: 0.30, percentText: "%۳۰"),
                    ]),
                    const SizedBox(height: 20),
                    Text("برای تغییر مشخصات خود، می‌توانید در زیر مشخصات خود را مشاهده و یا تغییر دهید.", style: subtitleTextStyle(), textAlign: TextAlign.right),
                    const SizedBox(height: 15),
                    // استفاده از ویجت جدید
                    PlanDetailTable(
                      controllers: planDetailsControllers,
                      editMode: planDetailsEditMode,
                      modalSetState: modalSetState,
                      planDetailsData: planDetailsData, // پاس دادن داده‌های اولیه
                    ),
                    const SizedBox(height: 10),
                    Text("در صورت تایید و ادامه، لطفا انتخاب رژیم را بزنید.", style: subtitleTextStyle(color: Colors.black87), textAlign: TextAlign.right),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("تایید و ادامه", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            // ذخیره مقادیر ویرایش شده
                            planDetailsControllers.forEach((key, controller) {
                              if (planDetailsEditMode[key] ?? false) { // فقط اگر در حالت ویرایش بود، ذخیره کن
                                planDetailsData[key] = controller.text;
                                planDetailsEditMode[key] = false; // خروج از حالت ویرایش
                              }
                            });
                            // modalSetState((){}); // دیگر نیازی به این نیست چون در خود PlanDetailTable انجام می‌شود
                            Navigator.pop(context);
                            _showPlanDifficultyModal();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, padding: const EdgeInsets.symmetric( vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _showPlanDifficultyModal({String? initialSelection}) {
    String? currentSelection = initialSelection ?? selectedPlanDifficulty;
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              decoration: modalBoxDecoration(), padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SizedBox(width: 24), Text("سختی رژیم غذایی", style: titleTextStyle(), textAlign: TextAlign.right), const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54)]),
                    const SizedBox(height: 10),
                    Text("میزان سختی رژیم غذایی خود را مشخص کنید.", style: subtitleTextStyle(), textAlign: TextAlign.right),
                    const SizedBox(height: 20),
                    RadioOptionItem(title: "آسان", subtitle: "کاهش وزن ۲ کیلوگرم در ماه", value: "آسان", groupValue: currentSelection, onChanged: (val) => modalSetState(() => currentSelection = val), pageType: PageType.difficulty),
                    RadioOptionItem(title: "متوسط", subtitle: "کاهش وزن ۳ کیلوگرم در ماه", value: "متوسط", groupValue: currentSelection, onChanged: (val) => modalSetState(() => currentSelection = val), pageType: PageType.difficulty),
                    RadioOptionItem(title: "سخت", subtitle: "کاهش وزن ۵ کیلوگرم در ماه", value: "سخت", groupValue: currentSelection, onChanged: (val) => modalSetState(() => currentSelection = val), pageType: PageType.difficulty),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
                          label: const Text("تایید و ادامه", style: TextStyle(color: Colors.white)),
                          onPressed: currentSelection == null ? null : () { selectedPlanDifficulty = currentSelection; Navigator.pop(context); _showStartingDayModal(); },
                          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, disabledBackgroundColor: Colors.grey.shade300, padding: const EdgeInsets.symmetric(vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showStartingDayModal() {
    String? currentRadioSelection = selectedStartDateOption;
    Jalali initialJalaliDate = selectedJalaliDate ?? Jalali.now();
    if(_isJalaliBefore(initialJalaliDate, Jalali.now())) initialJalaliDate = Jalali.now();

    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            String calendarOptionText = "انتخاب از روی تقویم";
            if (currentRadioSelection == "تقویم" && selectedJalaliDate != null) {
              calendarOptionText = _formatJalaliToCompactString(selectedJalaliDate!);
            }
            return Container(
              decoration: modalBoxDecoration(), padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SizedBox(width: 24), Text("تعیین شروع برنامه", style: titleTextStyle(), textAlign: TextAlign.right), const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54)]),
                    const SizedBox(height: 10),
                    Text("قراره برنامه غذاییت رو از کی شروع کنیم؟", style: subtitleTextStyle(), textAlign: TextAlign.right),
                    const SizedBox(height: 20),
                    RadioOptionItem(title: "امروز", value: "امروز", groupValue: currentRadioSelection, onChanged: (val) => modalSetState(() { currentRadioSelection = val; selectedJalaliDate = Jalali.now(); selectedCalendarDate = selectedJalaliDate!.toDateTime(); }), isSimple: true, pageType: PageType.dateOption),
                    RadioOptionItem(title: "فردا", value: "فردا", groupValue: currentRadioSelection, onChanged: (val) => modalSetState(() { currentRadioSelection = val; selectedJalaliDate = Jalali.now().addDays(1); selectedCalendarDate = selectedJalaliDate!.toDateTime(); }), isSimple: true, pageType: PageType.dateOption),
                    RadioOptionItem(title: calendarOptionText, value: "تقویم", groupValue: currentRadioSelection, icon: Icons.calendar_today_outlined, onChanged: (val) async { modalSetState(() => currentRadioSelection = val); _showPersianDatePickerModal(initialJalaliDate, (pickedJalaliDate) { modalSetState(() { selectedJalaliDate = pickedJalaliDate; selectedCalendarDate = pickedJalaliDate.toDateTime(); currentRadioSelection = "تقویم"; }); }); }, isSimple: true, pageType: PageType.dateOption),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
                          label: const Text("تایید و ادامه", style: TextStyle(color: Colors.white)),
                          onPressed: currentRadioSelection == null || selectedJalaliDate == null ? null : () { selectedStartDateOption = currentRadioSelection; Navigator.pop(context); _showFinalWordsModal(); },
                          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, disabledBackgroundColor: Colors.grey.shade300, padding: const EdgeInsets.symmetric(vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showPersianDatePickerModal(Jalali initialDate, Function(Jalali) onDateSelected) {
    showModalBottomSheet(
        context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container( // Wrapper برای محتوای مدال
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: modalBoxDecoration(),
            padding: const EdgeInsets.fromLTRB(20,0,20,0), // کاهش پدینگ بالا برای جا دادن دکمه بستن
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PersianDatePickerModalContent(
                initialDate: initialDate,
                onDateSelected: onDateSelected,
              ),
            ),
          );
        }
    );
  }


  void _showFinalWordsModal() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: modalBoxDecoration(), padding: const EdgeInsets.fromLTRB(20,20,20,0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 10),
                Center(child: Text("تا تهش هواتو داریم!", style: titleTextStyle(), textAlign: TextAlign.center)),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/Illustration (1).svg',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text("طبق تخمین ما، تا ${selectedJalaliDate != null ? _formatJalaliToFullString(selectedJalaliDate!) : "مشخص شده"} به وزن 55 کیلوگرم میرسی.", style: titleTextStyle(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text("در طول این مسیر، همراهی و راهنمایی کامل سالمینا رو خواهی داشت.\nتوی این مسیر تنها نیستی و قبل از تو خیلی از کاربران ما به وزن ایده‌آلشون رسیدن.\nفقط کافیه در هر شرایطی ادامه بدی و هدفت یادت نره.", style: TextStyle(color: Colors.black), textAlign: TextAlign.start),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
                      label: const Text("بزن بریم به سمت سلامتی", style: TextStyle(color: Colors.white)),
                      onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content: Text('برنامه با موفقیت تنظیم شد! به صفحه اصلی هدایت می‌شوید...', textDirection: TextDirection.rtl))); },
                      style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}