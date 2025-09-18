import 'package:flutter/material.dart';

class CabBookingPage extends StatefulWidget {
  const CabBookingPage({super.key});

  @override
  State<CabBookingPage> createState() => _CabBookingPageState();
}

class _CabBookingPageState extends State<CabBookingPage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _bookCab() {
    if (_pickupController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter pickup and destination")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Cab booked from ${_pickupController.text} to ${_destinationController.text}",
        ),
      ),
    );
    _pickupController.clear();
    _destinationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book a Cab"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find and book cabs easily",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Pickup and Destination fields
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                labelText: "Pickup Location",
                prefixIcon: const Icon(Icons.my_location),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: "Destination",
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Book button
            Center(
              child: ElevatedButton.icon(
                onPressed: _bookCab,
                icon: const Icon(Icons.local_taxi),
                label: const Text("Book Now"),
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nearby cabs
            const Text(
              "Nearby Cabs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _buildCabTile("Swift Sedan", "2 min away", "₹200 approx"),
            _buildCabTile("SUV XL", "5 min away", "₹350 approx"),
            _buildCabTile("Mini Cab", "3 min away", "₹180 approx"),

            const SizedBox(height: 30),

            // Recent bookings
            const Text(
              "Recent Bookings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _buildBookingTile("Airport → Hotel Plaza", "₹450", "Completed"),
            _buildBookingTile("Station → City Center", "₹220", "Completed"),
          ],
        ),
      ),
    );
  }

  Widget _buildCabTile(String name, String eta, String price) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.local_taxi, color: Colors.blue),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(eta),
        trailing: Text(
          price,
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildBookingTile(String route, String price, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.history, color: Colors.grey),
        title: Text(route),
        subtitle: Text("Status: $status"),
        trailing: Text(price,
            style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
