import 'package:flutter/material.dart';
import 'package:medxecure/screens/chatbot/chat_screen.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1B2E),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('Consultation History',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 28,
            ),
            onPressed: ()=> {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ChatScreen()))
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          DoctorCard(
            name: 'Darrell Steward',
            specialty: 'Therapist',
            experience: '10 years',
            rating: 5.0,
            estimates: '524 estimates',
            cost: '80\$',
            lastActive: 'January 21, 2024 • 10:30 AM',
          ),
          SizedBox(height: 16),
          DoctorCard(
            name: 'Wade Warren',
            specialty: 'Cardiologist',
            experience: '5 years',
            rating: 5.0,
            estimates: '457 estimates',
            cost: '100\$',
            lastActive: 'March 2, 2024 • 2:15 PM',
          ),
          SizedBox(height: 16),
          DoctorCard(
            name: 'Karl Batchelor',
            specialty: 'Endocrinologist',
            experience: '5 years',
            rating: 5.0,
            estimates: '388 estimates',
            cost: '60\$',
            lastActive: 'March 27, 2024 • 9:45 AM',
          ),
          SizedBox(height: 16),
          DoctorCard(
            name: 'Brett Gasser',
            specialty: 'Dentist',
            experience: '7 years',
            rating: 5.0,
            estimates: '247 estimates',
            cost: '90\$',
            lastActive: 'April 4, 2024 • 3:20 PM',
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final String estimates;
  final String cost;
  final String lastActive;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.estimates,
    required this.cost,
    required this.lastActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          specialty,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          experience,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          estimates,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total cost - $cost',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      lastActive,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add your view report logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1B2E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'View Report',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}