import 'package:flutter/material.dart';
import 'modals/manifest_screen.dart';
import 'modals/plan_pros_screen.dart';
import 'modals/testimonial_screen.dart';
import 'modals/buy_premium_plan_screen.dart';

void showSalminaPurchaseModals(BuildContext context) {
  showManifestScreen(context, onNext: () {
    Navigator.pop(context); // Close Manifest
    showPlanProsScreen(context, onNext: () {
      Navigator.pop(context); // Close PlanPros
      showTestimonialScreen(context, onNext: () {
        Navigator.pop(context); // Close Testimonial
        showBuyPremiumPlanScreen(context);
      });
    });
  });
}