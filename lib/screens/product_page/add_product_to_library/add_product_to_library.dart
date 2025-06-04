import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

enum ModalScreenState {
  scanning,
  productNotFound,
  addProduct,
}

class ProductScanModal extends StatefulWidget {
  const ProductScanModal({super.key});

  @override
  State<ProductScanModal> createState() => _ProductScanModalState();
}

class _ProductScanModalState extends State<ProductScanModal> {
  final _formKeyAddProduct = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();

  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Directionality( // برای راست چین شدن محتوای این شیت
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('دوربین'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(ctx).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('گالری'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطا در انتخاب عکس: $e', textDirection: TextDirection.rtl)),
        );
      }
    }
  }


  Widget _buildAddProductUI() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.elliptical(600, 50)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKeyAddProduct,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  const Text('افزودن محصول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('لطفا برای ثبت محصول، اطلاعات زیر را وارد کنید.', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 14, color: Colors.black54,)),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: DottedBorder(
                  color: Colors.green,
                  strokeWidth: 1.5,
                  dashPattern: const [6, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _selectedImageFile == null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/ic_cloud_upload.svg', width: 40, height: 40, colorFilter: const ColorFilter.mode(Color(0xFF018A08), BlendMode.srcIn)),
                        const SizedBox(height: 8),
                        const Text('عکس مشخصات محصول', style: TextStyle(color: Color(0xFF018A08), )),
                      ],
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.file(_selectedImageFile!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _productNameController,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'نام محصول',
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF018A08))),
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'لطفا نام محصول را وارد کنید';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productDescriptionController,
                textDirection: TextDirection.rtl,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'توضیحات محصول (اختیاری)',
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF018A08))),
                ),
                style: const TextStyle(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyAddProduct.currentState?.validate() == true) {
                    // TODO: Handle product submission with _selectedImageFile
                    print('Product Name: ${_productNameController.text}');
                    print('Description: ${_productDescriptionController.text}');
                    if (_selectedImageFile != null) print('Image Path: ${_selectedImageFile!.path}');

                    final messenger = ScaffoldMessenger.of(context);
                    Navigator.of(context).pop(); // Close modal
                    messenger.hideCurrentSnackBar();
                    messenger.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.fromLTRB(24,0,24,60),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(seconds: 3),
                        backgroundColor: const Color(0xFF323232),
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Container(
                                height: 40, width: 40,
                                decoration: BoxDecoration(color: const Color(0xFF284740), borderRadius: BorderRadius.circular(8)),
                                child: Center(child: SvgPicture.asset('assets/icons/ic_check.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(Color(0xFF4BD772), BlendMode.srcIn),)),
                              ),
                              const SizedBox(width: 16),
                              const Flexible(child: Text('محصول با موفقیت ثبت شد.', style: TextStyle(color: Colors.white,))),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF018A08),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.87, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("تأیید و ثبت محصول", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    currentWidget = _buildAddProductUI();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: currentWidget,
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }
}

class CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool isTopLeft, isTopRight, isBottomLeft, isBottomRight;

  CornerPainter({
    required this.color,
    this.strokeWidth = 5.0,
    this.isTopLeft = false,
    this.isTopRight = false,
    this.isBottomLeft = false,
    this.isBottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // گرد کردن انتهای خطوط

    final path = Path();
    final double L = size.width; // طول خطوط گوشه

    if (isTopLeft) {
      path.moveTo(L, 0); path.lineTo(0, 0); path.lineTo(0, L);
    } else if (isTopRight) {
      path.moveTo(0, 0); path.lineTo(L, 0); path.lineTo(L, L);
    } else if (isBottomLeft) {
      path.moveTo(0, L); path.lineTo(0, 0); path.lineTo(L, 0);
    } else if (isBottomRight) {
      path.moveTo(L, L); path.lineTo(0, L); path.lineTo(0, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CornerPainter oldDelegate) => false;
}