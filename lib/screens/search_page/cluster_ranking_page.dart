import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'category_list_screen.dart'; // فایل صفحه دوم

class ClusterRankingPage extends StatelessWidget {
  final List<String> recentSearches = [
    'ماست', 'برنج', 'نوشابه', 'نعنا خشک', 'پفک', 'شیر', 'آویشن'
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'نان ها',
      'items': 34,
      'image': 'assets/k2.png',
      'list': ['نان سنگک', 'نان بربری', 'نان تافتون']
    },
    {
      'title': 'فست فود ها',
      'items': 55,
      'image': 'assets/k1.png',
      'list': ['پیتزا', 'همبرگر', 'هات داگ']
    },
    {
      'title': 'ادویه جات',
      'items': 41,
      'image': 'assets/k4.png',
      'list': ['زردچوبه', 'فلفل سیاه', 'دارچین']
    },
    {
      'title': 'پلو ها',
      'items': 56,
      'image': 'assets/k3.png',
      'list': ['چلوکباب', 'زرشک‌پلو', 'باقالی‌پلو']
    },
    {
      'title': 'حبوبات',
      'items': 33,
      'image': 'assets/k5.png',
      'list': ['لوبیا', 'عدس', 'نخود']
    },
    {
      'title': 'روغن ها',
      'items': 27,
      'image': 'assets/k6.png',
      'list': ['روغن زیتون', 'روغن کنجد', 'روغن آفتابگردان']
    },
    {
      'title': 'چاشنی‌ها',
      'items': 12,
      'image': 'assets/k7.png',
      'list': ['سرکه', 'سس مایونز', 'آبلیمو']
    },
    {
      'title': 'سبزیجات',
      'items': 18,
      'image': 'assets/k8.png',
      'list': ['کاهو', 'گوجه', 'خیار']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'جستجو',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0,left: 24,bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF7F8F9),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: SvgPicture.asset(
                            'assets/icons/scan.svg',
                            color: Color(0xFF464E59),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: 24,
                            maxWidth: 24,
                          ),
                          hintText: 'جستجو محصول',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.ltr,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/bins.svg',
                              width: 24,
                              height: 24,
                              color: Color(0xFFF2506E),
                            ),
                            SizedBox(width: 4),
                            Text('جستجوهای اخیر',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: recentSearches.map((text) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEFF1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(text),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 24),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categories.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryListScreen(
                                      title: category['title'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(category['image']),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      category['title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${category['items']} مورد',
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
