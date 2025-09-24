import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/custom_bottom_navigation_bar.dart';
import 'package:main_app/screens/home_page/home_content.dart';
import '../models/user_data_model.dart';
import '../services/home_service.dart';
import '../../search_page/search_page.dart';
import '../../scanner_page/scanner_page.dart';
import '../../dashboard_page/dashboard_page.dart';
import '../../profile_page/profile_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // This future will hold the data for the home screen
  late Future<UserData> _userDataFuture;
  final HomeService _homeService = HomeService();

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first created
    _userDataFuture = _homeService.getHomePageData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // A function to reload data if needed
  void _reloadData() {
    setState(() {
      _userDataFuture = _homeService.getHomePageData();
    });
  }

  Widget _buildPageContent(int index) {
    if (index == 0) {
      return FutureBuilder<UserData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load data.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _reloadData,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return HomeContent(userData: snapshot.data!);
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      );
    }
    // Return other pages based on index
    return [
      Container(), // Placeholder for HomeContent
      const SearchPage(),
      const ProductScannerScreen(),
      const DashboardPage(),
      const ProfilePage(),
    ][_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: _buildPageContent(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}