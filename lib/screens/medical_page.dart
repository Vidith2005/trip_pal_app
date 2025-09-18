import 'package:flutter/material.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy data for nearby services
  final List<Map<String, String>> _services = [
    {
      'name': 'City Hospital',
      'type': 'Hospital',
      'distance': '1.2 km',
      'image': 'https://picsum.photos/200?hospital'
    },
    {
      'name': 'MediCare Clinic',
      'type': 'Clinic',
      'distance': '2.5 km',
      'image': 'https://picsum.photos/201?clinic'
    },
    {
      'name': '24x7 Pharmacy',
      'type': 'Pharmacy',
      'distance': '800 m',
      'image': 'https://picsum.photos/202?pharmacy'
    },
    {
      'name': 'First Aid Center',
      'type': 'First Aid',
      'distance': '3.1 km',
      'image': 'https://picsum.photos/203?firstaid'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Services'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search hospitals, pharmacies, clinics...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Emergency contacts
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.red),
                title: const Text(
                  'Emergency Hotline',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Call 108 (India) or your local number'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Calling Emergency...')),
                    );
                  },
                  child: const Text('Call'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of nearby services
            Expanded(
              child: ListView.builder(
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final item = _services[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text('${item['type']} • ${item['distance']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.map, color: Colors.blue),
                        tooltip: 'View on Map',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening map for ${item['name']}'),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
