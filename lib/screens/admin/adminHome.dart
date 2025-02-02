import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:medxecure/screens/welcomeback/welcomeback.dart';

class MedicineAdmin extends StatefulWidget {
  const MedicineAdmin({super.key});

  @override
  State<MedicineAdmin> createState() => _MedicineAdminState();
}

class _MedicineAdminState extends State<MedicineAdmin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isSearchFocused = false;
  int _currentIndex = 0;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _expiryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  void _showAddMedicineDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1A1B2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add New Medicine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Medicine Name',
                    icon: Icons.medical_services,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _quantityController,
                    label: 'Quantity',
                    icon: Icons.inventory,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Price per Unit',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Enter License No.',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Enter Lot No.',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _expiryController,
                    label: 'Expiry Date',
                    icon: Icons.calendar_today,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                      );
                      if (picked != null) {
                        _expiryController.text = picked.toString().split(' ')[0];
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white.withOpacity(0.7)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF70FACC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: const Text('Add Medicine'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF70FACC).withOpacity(0.3),
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(icon, color: const Color(0xFF70FACC)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add medicine logic here
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine added successfully')),
      );
    }
  }

  Widget _buildContent() {
    switch (_currentIndex) {
      case 0:
        return _buildSuppliersList();
      case 1:
        return _buildTransactionsList();
      default:
        return Container();
    }
  }

  Widget _buildSuppliersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummySuppliers.length,
      itemBuilder: (context, index) {
        final supplier = dummySuppliers[index];
        return Card(
          color: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: const Color(0xFF70FACC).withOpacity(0.3),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              supplier.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Stock ID: ${supplier.stockId}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  'Date: ${supplier.date}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  'Contact: ${supplier.contact}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyTransactions.length,
      itemBuilder: (context, index) {
        final transaction = dummyTransactions[index];
        return Card(
          color: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: const Color(0xFF70FACC).withOpacity(0.3),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.medicineName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF70FACC),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Transaction ID: ${transaction.id}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  'Date: ${transaction.date}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  'Quantity: ${transaction.quantity}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Text(
                  'Type: ${transaction.type}',
                  style: TextStyle(
                    color: transaction.type == 'IN' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Update the build method in the _MedicineAdminState class:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicineDialog,
        backgroundColor: const Color(0xFF70FACC),
        child: const Icon(Icons.add, color: Color(0xFF1A1B2E)),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return CustomPaint(
                painter: BackgroundPainter(_controller.value),
                size: Size.infinite,
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF70FACC).withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF70FACC).withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF70FACC).withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Color(0xFF70FACC),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back,',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Admin User',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add navigation to login page
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>WelcomeScreen()));
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Color(0xFF70FACC),
                            ),
                            label: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: isSearchFocused
                              ? Colors.white.withOpacity(0.15)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSearchFocused
                                ? const Color(0xFF70FACC)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: isSearchFocused
                                  ? const Color(0xFF70FACC)
                                  : Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onTap: () => setState(() => isSearchFocused = true),
                                onSubmitted: (_) =>
                                    setState(() => isSearchFocused = false),
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.5)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF1A1B2E),
        selectedItemColor: const Color(0xFF70FACC),
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Suppliers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}

// Model classes and dummy data
class Supplier {
  final String name;
  final String stockId;
  final String date;
  final String contact;

  Supplier({
    required this.name,
    required this.stockId,
    required this.date,
    required this.contact,
  });
}

class Transaction {
  final String id;
  final String medicineName;
  final double amount;
  final String date;
  final int quantity;
  final String type; // 'IN' or 'OUT'

  Transaction({
    required this.id,
    required this.medicineName,
    required this.amount,
    required this.date,
    required this.quantity,
    required this.type,
  });
}

// Dummy data
final List<Supplier> dummySuppliers = [
  Supplier(
    name: 'MedPharm Supplies',
    stockId: 'SP001',
    date: '2025-02-01',
    contact: '+1 234-567-8901',
  ),
  Supplier(
    name: 'Global Healthcare',
    stockId: 'SP002',
    date: '2025-02-02',
    contact: '+1 234-567-8902',
  ),
  Supplier(
    name: 'PharmaCare Distribution',
    stockId: 'SP003',
    date: '2025-02-03',
    contact: '+1 234-567-8903',
  ),
  Supplier(
    name: 'MediCore Supplies',
    stockId: 'SP004',
    date: '2025-02-04',
    contact: '+1 234-567-8904',
  ),
];

final List<Transaction> dummyTransactions = [
  Transaction(
    id: 'TRX001',
    medicineName: 'Paracetamol',
    amount: 500.00,
    date: '2025-02-01',
    quantity: 1000,
    type: 'IN',
  ),
  Transaction(
    id: 'TRX002',
    medicineName: 'Amoxicillin',
    amount: 750.00,
    date: '2025-02-01',
    quantity: 500,
    type: 'IN',
  ),
  Transaction(
    id: 'TRX003',
    medicineName: 'Paracetamol',
    amount: 50.00,
    date: '2025-02-02',
    quantity: 100,
    type: 'OUT',
  ),
  Transaction(
    id: 'TRX004',
    medicineName: 'Ibuprofen',
    amount: 300.00,
    date: '2025-02-02',
    quantity: 200,
    type: 'IN',
  ),
  Transaction(
    id: 'TRX005',
    medicineName: 'Amoxicillin',
    amount: 150.00,
    date: '2025-02-03',
    quantity: 100,
    type: 'OUT',
  ),
];

class BackgroundPainter extends CustomPainter {
  final double value;

  BackgroundPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF70FACC).withOpacity(0.1),
          const Color(0xFF1A1B2E).withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    for (var i = 0; i < 5; i++) {
      final xOffset = size.width * 0.1 * math.sin(value * math.pi * 2 + i);
      final yOffset = size.height * 0.1 * math.cos(value * math.pi * 2 + i);
      path.addOval(
        Rect.fromCenter(
          center: Offset(
            size.width * (0.2 + (i * 0.2)) + xOffset,
            size.height * (0.2 + (i * 0.2)) + yOffset,
          ),
          width: size.width * 0.3,
          height: size.height * 0.3,
        ),
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}