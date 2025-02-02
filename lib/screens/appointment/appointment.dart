import 'package:flutter/material.dart';
import 'package:medxecure/screens/booking/booking.dart';


class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome Back',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          'Mr. Williamson',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Search Banner
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Looking for\ndesired doctor?',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Find your doctor',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [Text('See All'), Icon(Icons.chevron_right)],
                      ),
                    ),
                  ],
                ),
              ),

              // Category Icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(Icons.psychology, 'Neurology'),
                    _buildCategoryItem(Icons.favorite, 'Cardiology'),
                    _buildCategoryItem(Icons.elderly, 'Orthopedics'),
                    _buildCategoryItem(Icons.medical_services, 'Pathology'),
                  ],
                ),
              ),

              // Popular Doctors Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Doctors',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [Text('See All'), Icon(Icons.chevron_right)],
                      ),
                    ),
                  ],
                ),
              ),

              // Doctor Cards
              _buildDoctorCard(
                'Chloe Kelly',
                'M.Ch (Neuro)',
                '4.5',
                '2530',
                '50.99',
                context,
              ),
              _buildDoctorCard(
                'Lauren Hemp',
                'Spinal Surgery',
                '4.5',
                '2530',
                '50.99',
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.teal),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }

  Widget _buildDoctorCard(
    String name,
    String specialization,
    String rating,
    String reviews,
    String fee,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://placeholder.com/doctor'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(specialization, style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [const Icon(Icons.star, color: Colors.amber, size: 16), Text(' $rating ($reviews)')],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DoctorProfilePage())),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
