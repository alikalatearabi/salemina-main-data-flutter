import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app/screens/scanner_page/product_detail.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../home_page/barcode_scanner_screen.dart';
import '../product_page/product_page.dart';

class ValidProductDisplay extends StatefulWidget {
  final String scannedCode;

  const ValidProductDisplay({
    Key? key,
    required this.scannedCode,
  }) : super(key: key);

  @override
  State<ValidProductDisplay> createState() => _ValidProductDisplayState();
}

class _ValidProductDisplayState extends State<ValidProductDisplay> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 0),
      decoration:  const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(600,50),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration:  const BoxDecoration(
              color: Color(0xFFE3E6EA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(CupertinoIcons.multiply,
                size:24 ,),
            ),
          ),
          SizedBox(height: 0,),
          ProductDetail(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF018A08),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.87692307692307692307692307692308,
                MediaQuery.of(context).size.height * 0.06106870229007633587786259541985,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "افزودن به لیست مصرف",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.87692307692307692307692307692308,
                MediaQuery.of(context).size.height * 0.06106870229007633587786259541985,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(
                color: Color(0xFF018A08),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "مشاهده جزئیات",
                  style: TextStyle(
                      color: Color(0xFF018A08),
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
