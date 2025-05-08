import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/home_page/barcode_scanner_screen.dart';

class InvalidProductDisplay extends StatefulWidget {
  final String scannedCode;

  const InvalidProductDisplay({
    Key? key,
    required this.scannedCode,
  }) : super(key: key);

  @override
  State<InvalidProductDisplay> createState() => _InvalidProductDisplayState();
}

class _InvalidProductDisplayState extends State<InvalidProductDisplay> {



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 25,left: 24,right: 24,top: 10),
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
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BarcodeScannerScreen(),
                        ),
                      );
                    },
                    icon: Icon(CupertinoIcons.multiply,
                    size:24 ,),
                  ),
                  Text(
                    "محصول یافت نشد!",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text(
                "می‌توانید این محصول را به کتابخانه محصولات اضافه کنید و ۱۰۰۰ امتیاز دریافت کنید.",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
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
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.plus,
                color: Color(0xFF015B05),
                size: 24,),
                SizedBox(width: 4,),
                const Text(
                  "افزودن به محصولات سالمینا",
                  style: TextStyle(
                      color: Color(0xFF015B05),
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
