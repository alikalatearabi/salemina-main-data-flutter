import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header Content
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'خانه',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'خرید اشتراک',
                                  style: TextStyle(
                                    color: Colors.white, // White text color
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Circular Progress Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green[400],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: CircularProgressIndicator(
                                value: 0.75,
                                strokeWidth: 12,
                                backgroundColor: Colors.green[300]!,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                '٥٥٥٥',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'از ٥٥٥٥ کیلوکالری',
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Nutrition Stats
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNutritionStat('چربی', '٥٥٥', true),
                          _buildNutritionStat('قند', '٥٥٥', true),
                          _buildNutritionStat('اسید چرب', '٥٥٥', true),
                          _buildNutritionStat('نمک', '٥٥٥', true),
                        ],
                      ),
                    ),
                    // Add Meal Button
                    Transform.translate(
                      offset: const Offset(0, 20),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF82C786),
                                width: 1,
                              ),
                              elevation: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.green[700]),
                                const SizedBox(width: 8),
                                Text(
                                  'مصرف وعده غذایی',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30), // Space for overlapping button
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton('رتبه‌بندی خوشه‌ها', Icons.bar_chart),
                  _buildActionButton('مقایسه محصولات', Icons.compare_arrows),
                ],
              ),
            ),
            // Health Tracker
            _buildHealthTracker(0.3),
            // Water Tracker
            const WaterTracker(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'خانه',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'داشبورد',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'جستجو',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'پروفایل',
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionStat(String label, String value, bool isWhite) {
    final textColor = isWhite ? Colors.white : Colors.black;
    final secondaryColor = isWhite ? Colors.white70 : Colors.grey;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 12,
          ),
        ),
        Container(
          width: 50,
          height: 4,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: isWhite ? Colors.white30 : Colors.green.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.green.shade200,
                  Colors.green.shade100,
                  Colors.green.shade50,
                  Colors.white,
                ],
                stops: const [0.0, 0.2, 0.8, 1.0],
                center: Alignment.center,
                radius: 0.8,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget _buildHealthTracker(double healthValue) {
  bool isHealthy = healthValue >= 0.5;

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      isHealthy ? 'سلامت کامل' : 'ریسک بالا',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            isHealthy
                                ? Colors.green.shade50
                                : Colors.red.shade100,
                            Colors.white,
                          ],
                          stops: const [0.0, 0.7],
                          center: Alignment.center,
                          radius: 0.8,
                        ),
                      ),
                      child: Icon(
                        isHealthy
                            ? Icons.sentiment_very_satisfied
                            : Icons.sentiment_very_dissatisfied,
                        color: isHealthy ? Colors.green : const Color(0xFFD44661),
                        size: 26,
                      ),
                    ),
                  ],
                ),
                if (!isHealthy)
                  GestureDetector(
                    onTap: () {
                      // Handle click event for "هشدارها"
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'هشدارها',
                            style: TextStyle(
                              color: Color(0xFFD44661),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFD44661),
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: healthValue,
                backgroundColor: Colors.grey[200],
                color: isHealthy ? Colors.green : const Color(0xFFD44661),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  _WaterTrackerState createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int _selectedCups = 0; // Number of selected cups of water
  final int _totalCups = 9; // Total number of cups available

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and count display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.green.shade50,
                              Colors.green.shade50,
                              Colors.white,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                            center: Alignment.center,
                            radius: 0.8,
                          ),
                        ),
                        child: const Icon(
                          Icons.water_drop,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'آب',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_selectedCups از $_totalCups لیوان',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Clickable water drops
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _totalCups,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        // Update selected cups based on user click
                        if (index < _selectedCups) {
                          _selectedCups = index; // Deselect cup
                        } else {
                          _selectedCups = index + 1; // Select cup
                        }
                      });
                    },
                    child: Icon(
                      Icons.water_drop_outlined,
                      color: index < _selectedCups
                          ? Colors.blue
                          : Colors.grey[300],
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
