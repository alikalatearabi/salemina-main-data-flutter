import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../enums/page_type.dart';

class RadioOptionItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String value;
  final String? groupValue;
  final Function(String?) onChanged;
  final IconData? icon;
  final bool isSimple;
  final PageType pageType;

  const RadioOptionItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.icon,
    this.isSimple = false,
    this.pageType = PageType.general,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = groupValue == value;
    Color backgroundColor = Colors.white;
    Color borderColor = defaultBorderColor;
    Color titleColor = Colors.black87;
    Color subtitleColor = Colors.black54;
    FontWeight titleFontWeight = FontWeight.normal;

    if (pageType == PageType.dietType || pageType == PageType.difficulty) {
      if (isSelected) { borderColor = selectedBorderColor; titleFontWeight = FontWeight.bold; }
    } else if (pageType == PageType.dateOption) {
      backgroundColor = isSelected ? primaryGreen.withOpacity(0.1) : Colors.white;
      borderColor = isSelected ? primaryGreen : Colors.grey.shade300;
      titleColor = Colors.black87;
      titleFontWeight = isSelected ? FontWeight.bold : FontWeight.normal;
    }

    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Radio<String>(value: value, groupValue: groupValue, onChanged: onChanged, activeColor: primaryGreen),
            if (icon != null) ...[Icon(icon, color: isSelected ? primaryGreen : Colors.black54), const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: titleFontWeight, color: titleColor), textAlign: TextAlign.right),
                  if (subtitle != null && !isSimple) ...[const SizedBox(height: 4), Text(subtitle!, style: TextStyle(fontSize: 12, color: subtitleColor), textAlign: TextAlign.right)]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}