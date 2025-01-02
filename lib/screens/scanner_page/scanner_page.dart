import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String scannedResult = "";

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        setState(() {
          scannedResult = result.rawContent; // Update with scanned data
        });
        Navigator.pop(context, scannedResult); // Return the result
      }
    } catch (e) {
      setState(() {
        scannedResult = "Failed to scan: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scanBarcode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Close the scanner screen
          },
        ),
        title: const Text(
          'اسکن محصول',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          scannedResult.isEmpty
              ? const Text(
                  'در حال اسکن...',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              : Text(
                  'نتیجه: $scannedResult',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
        ],
      ),
    );
  }
}
