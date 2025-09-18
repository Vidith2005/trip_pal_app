import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  final Map<String, List<Map<String, String>>> _categoryItems = {
    'Restaurants': List.generate(
      6,
          (index) => {
        'title': 'Restaurant ${index + 1}',
        'image': 'https://picsum.photos/200?random=${index + 10}',
      },
    ),
    'Cafes': List.generate(
      6,
          (index) => {
        'title': 'Cafe ${index + 1}',
        'image': 'https://picsum.photos/200?random=${index + 20}',
      },
    ),
    'Tourist Sites': List.generate(
      6,
          (index) => {
        'title': 'Tourist Site ${index + 1}',
        'image': 'https://picsum.photos/200?random=${index + 30}',
      },
    ),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categoryItems.keys.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: _categoryItems.keys.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categoryItems.keys.map((category) {
                final items = _categoryItems[category]!
                    .where((item) => item['title']!.toLowerCase().contains(_searchController.text.toLowerCase()))
                    .toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item['title']} tapped!')),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                item['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
