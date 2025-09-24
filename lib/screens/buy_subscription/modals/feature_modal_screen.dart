// lib/buy_subscription_flow/modals/feature_modal_screen.dart
import 'package:flutter/material.dart';
import '../constants.dart';

void showFeatureModalScreen(BuildContext context, {required String featureTitle}) { // این context از _buildFeatureListItem می‌آید
  // برای دیباگ
  print("Attempting to show FeatureModalScreen for '$featureTitle' with context: $context");

  showModalBottomSheet(
    context: context, // از context پاس داده شده برای نمایش این مودال استفاده می‌شود
    isScrollControlled: true,
    shape: modalShape,
    backgroundColor: Colors.white,
    builder: (bc) { // bc، builder context خودِ این مودال (FeatureModalScreen) است
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(20.0).copyWith(bottom: MediaQuery.of(bc).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    Text(featureTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    // برای بستن این مودال، از bc استفاده می‌کنیم
                    IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(bc))
                  ]
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: salminaLightGreyBorder,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/images/feature_video_placeholder.png'),
                        fit: BoxFit.cover,
                        onError: (e, s) {})),
                child: Center(child: Icon(Icons.play_circle_outline, size: 60, color: Colors.white.withOpacity(0.8))),
              ),
              SizedBox(height: 20),
              Text('متن کپشن یا جمله توصیفی برای کاربر به این شکل در اینجا استفاده می‌شود.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: salminaGreyText)),
              SizedBox(height: 30),
              OutlinedButton(
                // برای بستن این مودال، از bc استفاده می‌کنیم
                onPressed: () => Navigator.pop(bc),
                child: Text('متوجه شدم', style: TextStyle(fontSize: 16, color: salminaGreyText)),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[400]!),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
      );
    },
  ).then((_) {
    print("FeatureModalScreen for '$featureTitle' closed.");
  }).catchError((error) {
    print("Error showing FeatureModalScreen for '$featureTitle': $error");
  });
}