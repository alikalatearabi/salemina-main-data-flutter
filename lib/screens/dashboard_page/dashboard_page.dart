import 'package:flutter/material.dart';
import 'package:main_app/screens/dashboard_page/weekly_content.dart';
import 'package:main_app/screens/dashboard_page/yearly_content.dart';

import 'daily_content.dart';
import 'monthly_content.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  const Align(
          alignment: Alignment.centerRight,
          child: Text('داشبورد',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        ),
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.87692307692307692307692307692308,
            height: MediaQuery.of(context).size.height*0.05089058524173027989821882951654,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
                _selectedIndex == 2,
                _selectedIndex == 3,
              ],
              onPressed: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              fillColor: Colors.transparent,
              selectedColor: Colors.black,
              color: Colors.black,
              borderColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              renderBorder: false,
              children: [
                _buildToggleButton('سالانه', _selectedIndex == 0),
                _buildToggleButton('ماهانه', _selectedIndex == 1),
                _buildToggleButton('هفتگی', _selectedIndex == 2),
                _buildToggleButton('روزانه', _selectedIndex == 3),
              ],
            ),
          ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: _getContentForSelectedIndex(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContentForSelectedIndex() {
    switch (_selectedIndex) {
      case 3:
        return  DailyContent();
      case 2:
        return  WeeklyContent();
      case 1:
        return  MonthlyContent();
      case 0:
        return  YearlyContent();
      default:
        return  DailyContent();
    }
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.21,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 1)]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

}
