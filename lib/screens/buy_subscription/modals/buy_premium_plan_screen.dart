import 'package:flutter/material.dart';
import '../constants.dart';
import '../ui_helpers.dart';
import 'unlimited_plan_screen.dart';
import 'payment_success_screen.dart';
import 'payment_failed_screen.dart';
import 'feature_intro_screen.dart';

class BuyPremiumPlanScreen extends StatefulWidget {
  @override
  _BuyPremiumPlanScreenState createState() => _BuyPremiumPlanScreenState();
}

class _BuyPremiumPlanScreenState extends State<BuyPremiumPlanScreen> {
  int _selectedPlanIndex = 4; // پیشفرض روی پلاتینیوم نامحدود
  final List<Map<String, String>> _plans = [
    {'title': 'برنزی', 'duration': '۱ ماهه', 'price': '۹۹,۰۰۰ تومان'},
    {'title': 'نقره‌ای', 'duration': '۳ ماهه', 'price': '۱۹۹,۰۰۰ تومان'},
    {'title': 'طلایی', 'duration': '۶ ماهه', 'price': '۲۹۹,۰۰۰ تومان'},
    {'title': 'طلایی', 'duration': '۱ ساله', 'price': '۳۹۹,۰۰۰ تومان'},
    {'title': 'پلاتینیوم', 'duration': 'نامحدود ∞', 'price': '۴۹۹,۰۰۰ تومان', 'tag': 'بهترین انتخاب'},
  ];

  Widget _buildPlanOption(int index, Map<String, String> planData) {
    bool isSelected = _selectedPlanIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlanIndex = index;
        });
        // اگر روی پلن نامحدود کلیک شد، مودال فعلی بسته شده و مودال پلن نامحدود باز می‌شود
        // برای سایر پلن‌ها، فقط انتخاب ذخیره می‌شود و کاربر باید روی دکمه "خرید اشتراک" کلیک کند.
        if (planData['duration'] == 'نامحدود ∞') {
          // بستن مودال فعلی (BuyPremiumPlanScreen)
          // این context مربوط به ویجت BuyPremiumPlanScreen است، پس برای pop کردن مودال استفاده می‌شود.
          Navigator.pop(context);
          showUnlimitedPlanScreen(context, price: planData['price']!);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelected ? salminaLightGreyBorder : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? Colors.black : salminaLightGreyBorder)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(planData['title']!, style: TextStyle(fontSize: 12, color: salminaIconGrey)),
            SizedBox(height: 4,),
            Text(planData['duration']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (planData['tag'] != null)
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFDEE2E7),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(planData['tag']!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              if (planData['tag'] != null) SizedBox(height: 5),
              Text(planData['price']!, style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // اینجا دیگر نیازی به Padding برای viewInsets.bottom نیست،
    // چون در showBuyPremiumPlanScreen مدیریت می‌شود.
    // همچنین SingleChildScrollView هم به builder مودال منتقل می‌شود.
    return Column(
      mainAxisSize: MainAxisSize.min, // مهم برای SingleChildScrollView در builder
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('خرید اشتراک', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              // `context` اینجا، context ویجت BuyPremiumPlanScreen است که توسط showModalBottomSheet ایجاد شده.
              // پس برای pop کردن خود مودال استفاده می‌شود.
              IconButton(icon: Icon(Icons.arrow_forward_ios, color: salminaGreen), onPressed: () {
                Navigator.pop(context);
              })
            ]
        ),
        SizedBox(height: 10),
        Text(
            'برای استفاده از تمام امکانات سالمینا و دسترسی به بیش از ۱۰۰ دستور پخت انواع غذا لطفا اشتراک پریمیوم تهیه کنید.',
            style: TextStyle(fontSize: 14, color: salminaGreyText)),
        SizedBox(height: 15),
        ..._plans.map((plan) => _buildPlanOption(_plans.indexOf(plan), plan)).toList(),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFD4D9DE))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // برای تراز کردن متن‌ها به شروع
            children: [
              Text('اشتراک پرمیوم رایگان ۷ روزه',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF103865))),
              SizedBox(height: 4,),
              Text('شما می توانید به مدت ۷ روز از تمام امکانات پرمیوم سالمینا استفاده کنید.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, color: Color(0xFF103865))),
            ],
          ),
        ),
        SizedBox(height: 25),
        buildPrimaryButton('خرید اشتراک', () {
          bool paymentSucceeded = true; // Simulate payment
          Navigator.pop(context); // بستن مودال BuyPremiumPlanScreen
          if (_selectedPlanIndex == 4) { // اگر پلن پلاتینیوم (نامحدود) انتخاب شده بود
            // `context`ی که به showUnlimitedPlanScreen پاس داده می‌شود باید context والد مودال BuyPremiumPlanScreen باشد.
            // که در showBuyPremiumPlanScreen موجود است.
            // این کار باید از طریق builder مودال هندل شود یا context اصلی پاس داده شود.
            // با توجه به اینکه Navigator.pop(context) خود مودال را می‌بندد،
            // باید context والد را برای مودال بعدی استفاده کنیم.
            // این قسمت نیاز به اصلاح در نحوه پاس دادن context والد دارد اگر اینجا هستیم.
            // اما چون Navigator.pop(context) خود این ویجت را از بین میبرد،
            // بهتر است این منطق در onPressed دکمه داخل showModalBottomSheet باشد.
            // فعلا فرض میکنیم context والد در دسترس است (که نیست).
            // **این بخش نیاز به بازنگری دارد اگر Navigator.pop(context) اینجا باشد.**
            // **بهتر است `Navigator.pop(context)` بعد از فراخوانی مودال بعدی باشد، یا context والد به `buildPrimaryButton` پاس داده شود.**
            // **راه حل ساده‌تر: `Navigator.pop(context)` را به builder مودال منتقل کنیم.**

            // موقتا برای ادامه کار:
            // فرض می‌کنیم context والد به نحوی در دسترس است.
            // در واقع، این context باید context ای باشد که showBuyPremiumPlanScreen با آن فراخوانی شده.
            showUnlimitedPlanScreen(this.context, price: _plans[_selectedPlanIndex]['price']!);
          } else {
            if (paymentSucceeded)
              showPaymentSuccessScreen(this.context);
            else
              showPaymentFailedScreen(this.context, price: _plans[_selectedPlanIndex]['price']!);
          }
        }),
        SizedBox(height: 10),
        Center(child: buildTextButton('اشتراک پرمیوم رایگان ۷ روزه', () {
          Navigator.pop(context); // بستن مودال BuyPremiumPlanScreen
          showFeatureIntroScreen(this.context); // استفاده از context والد
          ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
              content: Text('اشتراک ۷ روزه رایگان فعال شد!', textDirection: TextDirection.rtl)));
        })),
        SizedBox(height: 10),
      ],
    );
  }
}

void showBuyPremiumPlanScreen(BuildContext context) { // این `context`، context والد است.
  showModalBottomSheet(
    context: context, // از context والد برای نمایش مودال استفاده می‌شود
    isScrollControlled: true,
    shape: modalShape, // شکل کلی مودال
    backgroundColor: Colors.transparent, // برای اینکه borderRadius دیده شود
    builder: (bc) { // `bc` context خودِ مودال (BuyPremiumPlanScreen) است
      final screenHeight = MediaQuery.of(bc).size.height;
      final topPadding = MediaQuery.of(bc).padding.top;
      final bottomInset = MediaQuery.of(bc).viewInsets.bottom;

      final availableHeight = screenHeight - topPadding - bottomInset;
      final maxHeight = availableHeight * 0.95; // 90% ارتفاع قابل استفاده

      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset), // برای کیبورد
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // رنگ پس زمینه مودال
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(600, 50)), // همان modalShape
          ),
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            // محتوای اصلی ویجت BuyPremiumPlanScreen با padding لازم
            // SingleChildScrollView اینجا برای اسکرول کل محتوای BuyPremiumPlanScreen است
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0, bottom: 20.0), // پدینگ داخلی
                // ویجت BuyPremiumPlanScreen را اینجا نمونه‌سازی می‌کنیم.
                // توجه: `Navigator.pop(context)` داخل BuyPremiumPlanScreen باید با `bc` (builder context) انجام شود
                // یا اینکه `context` والد به نحوی به آن پاس داده شود.
                // راه ساده‌تر: `BuyPremiumPlanScreen` دیگر مسئول بستن خود از طریق دکمه "خرید اشتراک" یا "رایگان ۷ روزه" نیست
                // بلکه این کار پس از کلیک، در خود `showBuyPremiumPlanScreen` مدیریت می‌شود.
                // یا اینکه BuyPremiumPlanScreen یک callback برای بستن دریافت کند.

                // روش فعلی شما: BuyPremiumPlanScreen خودش را می‌بندد.
                // این به این معنی است که `Navigator.pop(context)` در `_BuyPremiumPlanScreenState`
                // باید از `context` خود ویجت استفاده کند که همان `bc` است.
                // اما شما `context` را از `build` متد می‌گیرید که درست است.

                // مشکل اصلی در onPressed دکمه "خرید اشتراک" و "رایگان ۷ روزه" است.
                // وقتی `Navigator.pop(context)` در آنها فراخوانی می‌شود، مودال `BuyPremiumPlanScreen` بسته می‌شود.
                // سپس وقتی `showUnlimitedPlanScreen(this.context, ...)` فراخوانی می‌شود،
                // `this.context` دیگر معتبر نیست چون ویجت از درخت حذف شده.
                // راه حل: از `context` والد (همین `context` که به `showBuyPremiumPlanScreen` پاس داده شده) استفاده کنید.

                // برای این کار، BuyPremiumPlanScreen نباید خودش Navigator.pop کند و سپس مودال جدید باز کند.
                // بلکه باید نتیجه را به `showBuyPremiumPlanScreen` برگرداند یا `context` والد را برای فراخوانی بعدی استفاده کند.

                // اصلاح شده: BuyPremiumPlanScreen یک ویجت ساده است و منطق ناوبری بعد از pop در builder هندل می‌شود.
                // این روش تمیزتر است.
                child: BuyPremiumPlanScreenContent(
                  parentContext: context, // پاس دادن context والد برای ناوبری‌های بعدی
                  closeModal: () => Navigator.pop(bc), // تابع برای بستن مودال از داخل
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


// یک ویجت جدید برای محتوای BuyPremiumPlanScreen ایجاد می‌کنیم
// تا بتوانیم context والد و تابع بستن را به آن پاس دهیم.
class BuyPremiumPlanScreenContent extends StatefulWidget {
  final BuildContext parentContext; // Context از showBuyPremiumPlanScreen
  final VoidCallback closeModal;

  BuyPremiumPlanScreenContent({required this.parentContext, required this.closeModal});

  @override
  _BuyPremiumPlanScreenContentState createState() => _BuyPremiumPlanScreenContentState();
}

class _BuyPremiumPlanScreenContentState extends State<BuyPremiumPlanScreenContent> {
  int _selectedPlanIndex = 4;
  final List<Map<String, String>> _plans = [
    {'title': 'برنزی', 'duration': '۱ ماهه', 'price': '۹۹,۰۰۰ تومان'},
    {'title': 'نقره‌ای', 'duration': '۳ ماهه', 'price': '۱۹۹,۰۰۰ تومان'},
    {'title': 'طلایی', 'duration': '۶ ماهه', 'price': '۲۹۹,۰۰۰ تومان'},
    {'title': 'طلایی', 'duration': '۱ ساله', 'price': '۳۹۹,۰۰۰ تومان'},
    {'title': 'پلاتینیوم', 'duration': 'نامحدود ∞', 'price': '۴۹۹,۰۰۰ تومان', 'tag': 'بهترین انتخاب'},
  ];

  Widget _buildPlanOption(int index, Map<String, String> planData) {
    bool isSelected = _selectedPlanIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() { _selectedPlanIndex = index; });
        if (planData['duration'] == 'نامحدود ∞') {
          widget.closeModal(); // بستن مودال فعلی
          // استفاده از parentContext برای نمایش مودال بعدی
          showUnlimitedPlanScreen(widget.parentContext, price: planData['price']!);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelected ? salminaLightGreyBorder : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? Colors.black : salminaLightGreyBorder)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(planData['title']!, style: TextStyle(fontSize: 12, color: salminaIconGrey)),
            SizedBox(height: 4,),
            Text(planData['duration']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (planData['tag'] != null)
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFDEE2E7),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(planData['tag']!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              if (planData['tag'] != null) SizedBox(height: 5),
              Text(planData['price']!, style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('خرید اشتراک', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: Icon(Icons.arrow_forward_ios, color: salminaGreen), onPressed: widget.closeModal) // استفاده از تابع بستن
            ]
        ),
        SizedBox(height: 10),
        Text(
            'برای استفاده از تمام امکانات سالمینا و دسترسی به بیش از ۱۰۰ دستور پخت انواع غذا لطفا اشتراک پریمیوم تهیه کنید.',
            style: TextStyle(fontSize: 14, color: salminaGreyText)),
        SizedBox(height: 15),
        ..._plans.map((plan) => _buildPlanOption(_plans.indexOf(plan), plan)).toList(),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFD4D9DE))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اشتراک پرمیوم رایگان ۷ روزه',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF103865))),
              SizedBox(height: 4,),
              Text('شما می توانید به مدت ۷ روز از تمام امکانات پرمیوم سالمینا استفاده کنید.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, color: Color(0xFF103865))),
            ],
          ),
        ),
        SizedBox(height: 25),
        buildPrimaryButton('خرید اشتراک', () {
          widget.closeModal(); // بستن مودال فعلی
          bool paymentSucceeded = true; // Simulate payment
          if (_selectedPlanIndex == 4) {
            showUnlimitedPlanScreen(widget.parentContext, price: _plans[_selectedPlanIndex]['price']!);
          } else {
            if (paymentSucceeded)
              showPaymentSuccessScreen(widget.parentContext);
            else
              showPaymentFailedScreen(widget.parentContext, price: _plans[_selectedPlanIndex]['price']!);
          }
        }),
        SizedBox(height: 10),
        Center(child: buildTextButton('اشتراک پرمیوم رایگان ۷ روزه', () {
          widget.closeModal(); // بستن مودال فعلی
          showFeatureIntroScreen(widget.parentContext);
          ScaffoldMessenger.of(widget.parentContext).showSnackBar(SnackBar(
              content: Text('اشتراک ۷ روزه رایگان فعال شد!', textDirection: TextDirection.rtl)));
        })),
        SizedBox(height: 10),
      ],
    );
  }
}