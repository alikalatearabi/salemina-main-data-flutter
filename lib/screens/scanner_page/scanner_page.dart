import 'package:flutter/material.dart';
import 'package:main_app/screens/scanner_page/Invalid_product_display.dart';
import 'package:main_app/screens/scanner_page/valid_product_display.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:main_app/utility/env_config.dart';

class ProductScannerScreen extends StatefulWidget {
  const ProductScannerScreen({super.key});

  @override
  State<ProductScannerScreen> createState() => _ProductScannerScreenState();
}

class _ProductScannerScreenState extends State<ProductScannerScreen> {
  String? scannedCode;
  bool isValid = false;
  bool isLoading = false;
  bool scanned = false;
  Map<String, dynamic>? productData;
  MobileScannerController controller = MobileScannerController();
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  Future<void> fetchProductData(String barcode) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${EnvConfig.apiBaseUrl}/products/barcode/$barcode'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          productData = data;
          isValid = true;
          isLoading = false;
          scanned = true;
        });
      } else {
        setState(() {
          isValid = false;
          isLoading = false;
          scanned = true;
        });
      }
    } catch (e) {
      setState(() {
        isValid = false;
        isLoading = false;
        scanned = true;
      });
      print('Error fetching product data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1D5DB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اسکن محصول',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              final barcode = capture.barcodes.first;
              if (barcode.rawValue != null && mounted) {
                String code = barcode.rawValue!;

                await controller.stop();

                setState(() {
                  scannedCode = code;
                });
                
                // Fetch product data from API
                await fetchProductData(code);
              }
            },
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'محصول یا بارکد آن را جلوی دوربین قرار دهید.',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70, width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF018A08),
              ),
            ),
          if (scannedCode != null && isValid && scanned)
            Align(
              alignment: Alignment.bottomCenter,
              child: ValidProductDisplay(
                scannedCode: scannedCode!,
                productData: productData,
                onClose: () {
                  controller.start();
                  setState(() {
                    scanned = false;
                    scannedCode = null;
                    isValid = false;
                    productData = null;
                  });
                },
              ),
            ),
          if (scannedCode != null && !isValid && scanned)
            Align(
              alignment: Alignment.bottomCenter,
              child: InvalidProductDisplay(
                scannedCode: scannedCode!,
              ),
            ),
        ],
      ),
    );
  }
}
