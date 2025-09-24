import '../models/health_warning.dart';

class MockWarningService {
  Future<List<HealthWarning>> getHealthWarnings() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      HealthWarning(
        id: 1,
        title: 'فشار خون بالا',
        riskTagLevel: RiskTagLevel.high,
        fullDescription: 'توضیحات تکمیلی در مورد هر یک از هشدارها به این صورت در یک مودال بر اساس طول متن توضیحات به این صورت کوچک یا حتی تمام صفحه میتواند نمایش داده شود. میتوان لیست محصولات پر خطر را به کاربر نمایش داد که برای بهبود سلامتی خود در مصرف محصولات زیر احتیاط کند.',
        relatedProducts: [
          RelatedProduct(name: 'نام محصول در حالت خیلی خیلی طولانی...', imageUrl: '', calories: '۵۵۵۵', sugar: '۰.۵۵', salt: '۰.۷۸', fat: '۰.۵۵'),
          RelatedProduct(name: 'یک محصول دیگر', imageUrl: '', calories: '۱۲۳', sugar: '۰.۲', salt: '۰.۳', fat: '۰.۱'),
        ],
      ),
      HealthWarning(id: 2, title: 'مشکلات کلیوی', riskTagLevel: RiskTagLevel.medium, fullDescription: 'توضیحات مربوط به مشکلات کلیوی...', relatedProducts: []),
      HealthWarning(id: 3, title: 'پوکی استخوان', riskTagLevel: RiskTagLevel.high, fullDescription: 'توضیحات مربوط به پوکی استخوان...', relatedProducts: []),
      HealthWarning(id: 4, title: 'دیابت نوع ۲', riskTagLevel: RiskTagLevel.low, fullDescription: 'توضیحات مربوط به دیابت...', relatedProducts: []),
      HealthWarning(id: 5, title: 'خطر بیماری‌های قلبی و عروقی', riskTagLevel: RiskTagLevel.medium, fullDescription: 'توضیحات مربوط به بیماری قلبی...', relatedProducts: []),
    ];
  }
}