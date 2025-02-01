import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Doctor Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://placeholder.com/doctor'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Dr. Eion Morgan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'MBBS, MD (Neurology)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(' 4.5 (2530)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Specialization Tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSpecializationTag('Neurologist'),
                  const SizedBox(width: 8),
                  _buildSpecializationTag('Neuromedicine'),
                  const SizedBox(width: 8),
                  _buildSpecializationTag('Medicine'),
                ],
              ),
            ),

            // Doctor Biography
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Doctor Biography',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Eion Morgan is a dedicated pediatrician with over 15 years of experience in caring for children\'s health. She is passionate about ensuring the well-being of your little ones and believes in a holistic approach.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            // Schedules
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Schedules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: const [
                      Text('Oct 2023'),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ],
              ),
            ),

            // Calendar Days
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDateCard('15', 'Mon', true),
                  _buildDateCard('16', 'Tue', false),
                  _buildDateCard('17', 'Wed', false),
                  _buildDateCard('18', 'Thu', false),
                  _buildDateCard('19', 'Fri', false),
                  _buildDateCard('20', 'Sat', false),
                  _buildDateCard('21', 'Sun', false),
                ],
              ),
            ),

            // Time Slots Section
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Choose Times',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Time of Day Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _buildTimeOfDayButton('Morning', false)),
                  Expanded(child: _buildTimeOfDayButton('Afternoon', true)),
                  Expanded(child: _buildTimeOfDayButton('Evening', false)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Time Slots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _buildTimeSlotButton('09-10 AM', true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTimeSlotButton('10-11 AM', false)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTimeSlotButton('11-12 AM', false)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTimeSlotButton('12-01 PM', false)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Book Appointment Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Book Appointment (\$50.99)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecializationTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }

  Widget _buildDateCard(String date, String day, bool isSelected) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.teal : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOfDayButton(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.teal : Colors.grey[100],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildTimeSlotButton(String time, bool isSelected) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey[100],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(time),
    );
  }
}