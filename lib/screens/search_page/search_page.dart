import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;

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
        body: Padding(
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
                        suffixIcon: SvgPicture.asset(
                          'assets/icons/scan.svg',
                          color:Color(0xFF464E59),
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
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildExpansionCard(
                        title: 'ادویه‌جات',
                        count: 3,
                        isExpanded: _isExpanded1,
                        onExpansionChanged: (val) {
                          setState(() {
                            _isExpanded1 = val;
                          });
                        },
                        children: [
                          _buildItemRow(
                            index: 1,
                            productName: 'آویشن',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k1.png',
                          ),
                          _buildItemRow(
                            index: 2,
                            productName: 'زعفران',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k2.png',
                          ),
                          _buildItemRow(
                            index: 3,
                            productName: 'فلفل سیاه',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k3.png',
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                              },
                              child: const Text(
                                'مشاهده همه',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildExpansionCard(
                        title: 'تنقلات',
                        count: 3,
                        isExpanded: _isExpanded2,
                        onExpansionChanged: (val) {
                          setState(() {
                            _isExpanded2 = val;
                          });
                        },
                        children: [
                          _buildItemRow(
                            index: 1,
                            productName: 'آبنبات',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k1.png',
                          ),
                          _buildItemRow(
                            index: 2,
                            productName: 'شکلات',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k2.png',
                          ),
                          _buildItemRow(
                            index: 3,
                            productName: 'کاکایو',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k3.png',
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                              },
                              child: const Text(
                                'مشاهده همه',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildExpansionCard(
                        title: 'حبوبات',
                        count: 3,
                        isExpanded: _isExpanded3,
                        onExpansionChanged: (val) {
                          setState(() {
                            _isExpanded3 = val;
                          });
                        },
                        children: [
                          _buildItemRow(
                            index: 1,
                            productName: 'نخود',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k1.png',
                          ),
                          _buildItemRow(
                            index: 2,
                            productName: 'لوبیا چیتی',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k2.png',
                          ),
                          _buildItemRow(
                            index: 3,
                            productName: 'عدس',
                            brandName: 'برند محصول',
                            imagePath: 'assets/k3.png',
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                              },
                              child: const Text(
                                'مشاهده همه',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionCard({
    required String title,
    required int count,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E4E7), width: 1),
      ),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            initiallyExpanded: isExpanded,
            onExpansionChanged: onExpansionChanged,
            title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$count مورد',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            children: [
              Container(
                color: Color(0xFFF9FAFB),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow({
    required int index,
    required String productName,
    required String brandName,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  brandName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getCircleColor(index),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCircleColor(int index) {
    switch (index) {
      case 1:
        return const Color(0xFF58C74F);
      case 2:
        return const Color(0xFFF4BA00);
      case 3:
        return const Color(0xFFE52F2F);
      default:
        return Colors.blueGrey;
    }
  }
}
