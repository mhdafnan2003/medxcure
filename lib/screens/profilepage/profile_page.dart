import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Profile Info Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2B3E),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Profile Picture
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF00BFAE).withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: const Color(0xFF252736),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Name, Age and Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '28 years',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'johndoe@gmail.com',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Stats Row
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252736),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('Appointments', '12'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white12,
                          ),
                          _buildStatColumn('Completed', '8'),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white12,
                          ),
                          _buildStatColumn('Cancelled', '2'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Health Metrics Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Health Metrics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          // Page 1: Health Score and Heart Rate
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _buildHealthCard(
                                  title: 'Health Score',
                                  value: '61.3',
                                  unit: 'pts',
                                  color: const Color(0xFF2A2B3E),
                                  iconColor: const Color(0xFF00BFAE),
                                  icon: Icons.show_chart,
                                  painter: HealthScoreChartPainter(),
                                ),
                                const SizedBox(width: 16),
                                _buildHealthCard(
                                  title: 'Heart Rate',
                                  value: '86',
                                  unit: 'bpm',
                                  color: const Color(0xFF2A2B3E),
                                  iconColor: Colors.redAccent,
                                  icon: Icons.favorite,
                                  painter: HeartRateChartPainter(),
                                ),
                              ],
                            ),
                          ),
                          // Page 2: SpO2 and Blood Pressure
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _buildHealthCard(
                                  title: 'SpO2',
                                  value: '98',
                                  unit: '%',
                                  color: const Color(0xFF2A2B3E),
                                  iconColor: Colors.blue,
                                  icon: Icons.water_drop_outlined,
                                  painter: SpO2ChartPainter(),
                                ),
                                const SizedBox(width: 16),
                                _buildHealthCard(
                                  title: 'Blood Pressure',
                                  value: '120/80',
                                  unit: 'mmHg',
                                  color: const Color(0xFF2A2B3E),
                                  iconColor: Colors.purple,
                                  icon: Icons.favorite_border,
                                  painter: BPChartPainter(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(2, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFF00BFAE)
                                : Colors.white24,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Profile Options
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.security_outlined,
                      title: 'Security',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {},
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthCard({
    required String title,
    required String value,
    required String unit,
    required Color color,
    required Color iconColor,
    required IconData icon,
    required CustomPainter painter,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF252736),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: CustomPaint(
                size: const Size(double.infinity, 40),
                painter: painter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.white70,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white54,
      ),
      onTap: onTap,
    );
  }
}

// Custom Painters remain unchanged
class HealthScoreChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00BFAE)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.8);

    for (double i = 0; i < size.width; i++) {
      final y = size.height * 0.5 +
          math.sin(i * 0.1) * 10 +
          math.cos(i * 0.05) * 15;
      path.lineTo(i, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeartRateChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);

    double width = size.width;
    double height = size.height;

    for (double i = 0; i < width; i += 50) {
      path.lineTo(i + 10, height / 2 - 20);
      path.lineTo(i + 20, height / 2 + 20);
      path.lineTo(i + 30, height / 2 - 20);
      path.lineTo(i + 40, height / 2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SpO2ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double i = 0; i < size.width; i++) {
      final y = size.height * 0.5 +
          math.sin(i * 0.05) * 20;
      path.lineTo(i, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BPChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    for (double i = 0; i < size.width; i += 40) {
      path.lineTo(i + 10, size.height * 0.3);
      path.lineTo(i + 20, size.height * 0.7);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}