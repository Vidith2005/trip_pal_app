import 'package:flutter/material.dart';
import 'package:untitled1/screens/chat_bot_screen.dart';
import 'package:untitled1/screens/explore_page.dart';
import 'package:untitled1/screens/medical_page.dart';
import 'package:untitled1/screens/cab_booking_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    MedicalPage(),
    CabBookingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _openChatBot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatBotScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack to overlay chat button
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _openChatBot,
              child: const Icon(Icons.chat, size: 40),
            ),
          ),
        ],
      ),

      // SOS button (center docked)
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('🚨 SOS Activated!')),
          );
        },
        child: const Text(
          'SOS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.explore),
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 40), // space for SOS
            IconButton(
              icon: const Icon(Icons.medical_services),
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.local_taxi),
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------- Dashboard-style Home Page --------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'title': 'Explore', 'icon': Icons.explore, 'color': Colors.orangeAccent},
      {'title': 'Cab Booking', 'icon': Icons.local_taxi, 'color': Colors.blueAccent},
      {'title': 'Medical', 'icon': Icons.medical_services, 'color': Colors.redAccent},
      {'title': 'Chat Bot', 'icon': Icons.chat, 'color': Colors.green},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🏠 Welcome!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a service below',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  itemCount: features.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final feature = features[index];
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${feature['title']} clicked!')),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: feature['color'],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: feature['color'].withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(feature['icon'], size: 50, color: Colors.white),
                            const SizedBox(height: 12),
                            Text(
                              feature['title'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
