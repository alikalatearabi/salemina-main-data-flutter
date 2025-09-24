import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart'; // مسیر صحیح

class PlanDetailTable extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final Map<String, bool> editMode;
  final StateSetter modalSetState;
  final Map<String, String> planDetailsData;


  const PlanDetailTable({
    super.key,
    required this.controllers,
    required this.editMode,
    required this.modalSetState,
    required this.planDetailsData, // اضافه شد
  });

  Widget _buildGridItem(BuildContext context, String key) {
    bool isEditing = editMode[key] ?? false;
    // اگر در حالت نمایش هستیم و کنترلر خالی است، از داده اولیه استفاده کن
    String displayText = controllers[key]?.text.isNotEmpty ?? false
        ? controllers[key]!.text
        : planDetailsData[key] ?? '';


    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
          left: BorderSide(color: Colors.grey.shade300, width: 0.5),
          right: BorderSide(color: Colors.grey.shade300, width: 0.5),
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // تراز به راست برای زبان فارسی
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded( // برای اینکه متن عنوان در صورت طولانی بودن، به خط بعدی برود
                child: Text(
                  key, // عنوان آیتم مانند "قد", "وزن"
                  style: subtitleTextStyle(color: Colors.black54, fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit_outlined, size: 20, color: primaryGreen),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  modalSetState(() {
                    // منطق ذخیره در کنترلر اصلی انجام می‌شود
                    editMode[key] = !isEditing;
                    if (!isEditing) {
                      // وقتی وارد حالت ویرایش می‌شویم، مطمئن می‌شویم کنترلر مقدار فعلی را دارد
                      controllers[key]?.text = planDetailsData[key] ?? '';
                    } else {
                      // وقتی از حالت ویرایش خارج می‌شویم، مقدار را در planDetailsData هم آپدیت می‌کنیم
                      // این کار باید در کنترلر اصلی انجام شود، اما برای نمایش صحیح اینجا هم لازم است.
                      // planDetailsData[key] = controllers[key]?.text ?? ''; // این خط ممکن است باعث مشکل شود اگر StateSetter فقط UI را آپدیت کند
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          isEditing
              ? SizedBox(
            height: 35, // ارتفاع کمتر برای TextField
            child: TextField(
              controller: controllers[key],
              textAlign: TextAlign.right, // مقدار هم به راست تراز شود
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryGreen),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: primaryGreen, width: 1.0)),
              ),
              // onChanged: (value) { // برای ذخیره آنی، اگر نیاز باشد
              //   controllers[key]?.text = value;
              // },
            ),
          )
              : Text(
            displayText, // مقدار آیتم مانند "۱۷۵ cm"
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryGreen),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keys = controllers.keys.toList();

    return GridView.count(
      crossAxisCount: 2, // دو ستون
      shrinkWrap: true, // برای اینکه GridView ارتفاع محتوای خود را بگیرد
      physics: const NeverScrollableScrollPhysics(), // برای جلوگیری از اسکرول داخلی
      childAspectRatio: 2.0, // نسبت عرض به ارتفاع هر آیتم، تنظیم کنید تا مناسب شود
      children: keys.map((key) => _buildGridItem(context, key)).toList(),
    );
  }
}