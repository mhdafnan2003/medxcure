import 'package:flutter/material.dart';
import 'dart:convert';

class TrackingInfo {
  final String timestamp;
  final String location;
  final Map<String, double> coordinates;
  final String status;

  TrackingInfo({
    required this.timestamp,
    required this.location,
    required this.coordinates,
    required this.status,
  });

  factory TrackingInfo.fromJson(Map<String, dynamic> json) {
    return TrackingInfo(
      timestamp: json['timestamp'],
      location: json['location'],
      coordinates: Map<String, double>.from(json['coordinates']),
      status: json['status'],
    );
  }
}

class MedicineDetails {
  final String medicineId;
  final String medicineName;
  final String batchNumber;
  final String manufactureDate;
  final String expiryDate;
  final List<TrackingInfo> tracking;

  MedicineDetails({
    required this.medicineId,
    required this.medicineName,
    required this.batchNumber,
    required this.manufactureDate,
    required this.expiryDate,
    required this.tracking,
  });

  factory MedicineDetails.fromJson(Map<String, dynamic> json) {
    return MedicineDetails(
      medicineId: json['medicine_id'],
      medicineName: json['medicine_name'],
      batchNumber: json['batch_number'],
      manufactureDate: json['manufacture_date'],
      expiryDate: json['expiry_date'],
      tracking: (json['tracking'] as List)
          .map((item) => TrackingInfo.fromJson(item))
          .toList(),
    );
  }
}

class DrugDetailsScreen extends StatelessWidget {
  const DrugDetailsScreen({super.key});

  Future<MedicineDetails> _loadMedicineDetails() async {
    const jsonString = '''
    {
      "medicine_id": "MED-789456",
      "medicine_name": "Paracetamol 500mg",
      "batch_number": "BATCH-2025-001",
      "manufacture_date": "2025-01-10",
      "expiry_date": "2027-01-10",
      "tracking": [
        {
          "timestamp": "2025-01-15 08:00 AM",
          "location": "ABC Pharma Ltd, Pune, India",
          "coordinates": { "latitude": 18.5204, "longitude": 73.8567 },
          "status": "Manufactured & Quality Checked"
        },
        {
          "timestamp": "2025-01-16 10:30 AM",
          "location": "Supplier 1: Global Med Distributors, Mumbai",
          "coordinates": { "latitude": 19.0760, "longitude": 72.8777 },
          "status": "Received by Supplier 1"
        },
        {
          "timestamp": "2025-01-18 02:00 PM",
          "location": "Supplier 2: HealthCare Suppliers, Ahmedabad",
          "coordinates": { "latitude": 23.0225, "longitude": 72.5714 },
          "status": "Transferred to Supplier 2"
        },
        {
          "timestamp": "2025-01-20 09:45 AM",
          "location": "XYZ Pharmacy Warehouse, Bangalore",
          "coordinates": { "latitude": 12.9716, "longitude": 77.5946 },
          "status": "Delivered to Pharmacy Warehouse"
        },
        {
          "timestamp": "2025-01-22 11:30 AM",
          "location": "ABC Medical Store, Indiranagar, Bangalore",
          "coordinates": { "latitude": 12.9784, "longitude": 77.6408 },
          "status": "Stocked at Retail Pharmacy"
        },
        {
          "timestamp": "2025-01-25 05:00 PM",
          "location": "Customer: Rahul Sharma, Bangalore",
          "coordinates": { "latitude": 12.9719, "longitude": 77.6412 },
          "status": "Medicine Delivered to Consumer"
        }
      ]
    }
    ''';

    await Future.delayed(const Duration(milliseconds: 500));
    return MedicineDetails.fromJson(json.decode(jsonString));
  }

  void _showRouteHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A2B3E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: FutureBuilder<MedicineDetails>(
            future: _loadMedicineDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF00F7B1),
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'No tracking data available',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              final details = snapshot.data!;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Medicine History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildMedicineInfo(details),
                      const SizedBox(height: 20),
                      const Text(
                        'Tracking History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...details.tracking.asMap().entries.map((entry) {
                        final index = entry.key;
                        final track = entry.value;
                        return _buildTimelineItem(
                          track.status,
                          track.timestamp,
                          track.location,
                          '',
                          isFirst: index == 0,
                          isLast: index == details.tracking.length - 1,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMedicineInfo(MedicineDetails details) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            details.medicineName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Medicine ID: ${details.medicineId}',
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            'Batch Number: ${details.batchNumber}',
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            'Manufacture Date: ${details.manufactureDate}',
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            'Expiry Date: ${details.expiryDate}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
      String title,
      String date,
      String description,
      String time, {
        bool isFirst = false,
        bool isLast = false,
      }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00F7B1),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF00F7B1),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Real',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoSection('Current Destination', 'Bangalore'),
              const SizedBox(height: 16),
              Builder(
                builder: (BuildContext context) {
                  return _buildLocationHistory(
                      'Location History', 'Pune > Bangalore', context);
                },
              ),
              const SizedBox(height: 16),
              _buildInfoSection('Name', 'KLORPO TABLETS 5 mg'),
              const SizedBox(height: 16),
              _buildInfoSection('Licence Number', 'A18'),
              const SizedBox(height: 16),
              _buildInfoSection('Expiry Date', 'Jan 10, 2027'),
              const SizedBox(height: 16),
              _buildInfoSection('LOT Number', '#54654654'),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00F7B1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Check Similarity',
                    style: TextStyle(
                      color: Color(0xFF1A1B2E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF1A1B2E)),
                  label: const Text(
                    'Check Again',
                    style: TextStyle(
                      color: Color(0xFF1A1B2E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00F7B1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
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

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: Colors.white24),
      ],
    );
  }

  Widget _buildLocationHistory(
      String title, String content, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => _showRouteHistory(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: Colors.white24),
      ],
    );
  }
}