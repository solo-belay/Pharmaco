import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> categories = [
    'Pain Relief',
    'Cold & Flu',
    'Allergy',
    'Digestive',
    'Vitamins',
    'Other',
  ];
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _filteredMedicines = [];

  // Sample medicine data
  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
    },
    {
      'name': 'Doliprane 1000',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
    },
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
    },
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
    },
    {
      'name': 'Doliprane 1000',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
    },
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
    },
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
    },
    {
      'name': 'Doliprane 1000',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
    },
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredMedicines = medicines;
    _searchController.addListener(_filterMedicines);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeTab(),
            Center(child: Text('Chat Page')), // Placeholder
            _buildCategoryTab(),
            Center(child: Text('Appointments Page')), // Placeholder
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, WelcomeBack',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[300],
                          ),
                        ),
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                        onPressed: () {
                          _showCartDialog();
                        },
                      ),
                      if (_cartItems.isNotEmpty)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${_cartItems.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.blue),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Search medicines...',
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.62,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = _filteredMedicines[index];
                return _buildMedicineCard(medicine);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedCategoryIndex == index ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.62,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = _filteredMedicines[index];
                return _buildMedicineCard(medicine);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  medicine['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.medication,
                      size: 40,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    medicine['name'],
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    medicine['pharmacy'],
                    style: const TextStyle(
                      fontSize: 7,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    medicine['price'],
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 8,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            medicine['rating'],
                            style: const TextStyle(
                              fontSize: 7,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _addToCart(medicine);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> medicine) {
    setState(() {
      // Check if item already exists in cart
      bool itemExists = false;
      for (var item in _cartItems) {
        if (item['name'] == medicine['name']) {
          item['quantity'] = (item['quantity'] ?? 1) + 1;
          itemExists = true;
          break;
        }
      }
      if (!itemExists) {
        _cartItems.add({
          ...medicine,
          'quantity': 1,
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine['name']} added to cart'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Shopping Cart'),
          content: SizedBox(
            width: double.maxFinite,
            child: _cartItems.isEmpty
                ? const Center(
                    child: Text('Your cart is empty'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2F5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.medication,
                                size: 20,
                                color: Colors.blue,
                              );
                            },
                          ),
                        ),
                        title: Text(
                          item['name'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          '${item['price']} x ${item['quantity']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                setState(() {
                                  if (item['quantity'] > 1) {
                                    item['quantity']--;
                                  } else {
                                    _cartItems.removeAt(index);
                                  }
                                });
                                Navigator.pop(context);
                                _showCartDialog();
                              },
                            ),
                            Text('${item['quantity']}'),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() {
                                  item['quantity']++;
                                });
                                Navigator.pop(context);
                                _showCartDialog();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            if (_cartItems.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement checkout functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Checkout functionality coming soon!'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Checkout'),
              ),
          ],
        );
      },
    );
  }

  void _filterMedicines() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMedicines = medicines;
      } else {
        _filteredMedicines = medicines.where((medicine) {
          return medicine['name'].toString().toLowerCase().contains(query) ||
                 medicine['pharmacy'].toString().toLowerCase().contains(query);
        }).toList();
      }
    });
  }
}