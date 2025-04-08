import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<String> recentSearches = [
    'ماست', 'برنج', 'نوشابه', 'نعنا خشک', 'پفک', 'شیر', 'آویشن'
  ];

  final List<Map<String, dynamic>> categories = [
    {'title': 'نان ها', 'items': 34, 'image': 'assets/eges.png'},
    {'title': 'فست فود ها', 'items': 55, 'image': 'assets/eges.png'},
    {'title': 'ادویه جات', 'items': 41, 'image': 'assets/eges.png'},
    {'title': 'پلو ها', 'items': 56, 'image': 'assets/eges.png'},
    {'title': 'حبوبات', 'items': 33, 'image': 'assets/eges.png'},
    {'title': 'روغن ها', 'items': 27, 'image': 'assets/eges.png'},
    {'title': 'چاشنی‌ها', 'items': 12, 'image': 'assets/eges.png'},
    {'title': 'سبزیجات', 'items': 18, 'image': 'assets/eges.png'},
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          suffixIcon: IconButton(
                            icon: Icon(Icons.qr_code_scanner),
                            onPressed: () {},
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
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                            Icon(Icons.delete, color: Colors.grey),
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
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(category['image']),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4), BlendMode.darken),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${category['items']} مورد',
                                    style:
                                    TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
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
