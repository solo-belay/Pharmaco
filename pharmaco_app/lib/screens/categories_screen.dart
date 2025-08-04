import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? _selectedCategory;
  final List<Map<String, dynamic>> _cartItems = [];

  // Sample medicine data with categories
  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Paracetamol',
      'price': '200Birr',
      'rating': '4.5',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
      'category': 'Pain Relief',
    },
    {
      'name': 'Doliprane 1000',
      'price': '250Birr',
      'rating': '4.2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
      'category': 'Pain Relief',
    },
    {
      'name': 'Ibuprofen',
      'price': '180Birr',
      'rating': '4.0',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
      'category': 'Pain Relief',
    },
    {
      'name': 'Amoxicillin',
      'price': '350Birr',
      'rating': '4.8',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
      'category': 'Antibiotics',
    },
    {
      'name': 'Azithromycin',
      'price': '400Birr',
      'rating': '4.6',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
      'category': 'Antibiotics',
    },
    {
      'name': 'Vitamin C',
      'price': '120Birr',
      'rating': '4.3',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
      'category': 'Vitamins',
    },
    {
      'name': 'Vitamin D',
      'price': '150Birr',
      'rating': '4.1',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
      'category': 'Vitamins',
    },
    {
      'name': 'Omeprazole',
      'price': '280Birr',
      'rating': '4.4',
      'image': 'assets/images/logo.png',
      'pharmacy': 'HealthPlus Pharmacy',
      'category': 'Digestive Health',
    },
    {
      'name': 'Loratadine',
      'price': '200Birr',
      'rating': '4.0',
      'image': 'assets/images/logo.png',
      'pharmacy': 'City Pharmacy',
      'category': 'Allergy',
    },
    {
      'name': 'Cetirizine',
      'price': '180Birr',
      'rating': '4.2',
      'image': 'assets/images/logo.png',
      'pharmacy': 'MediCare Pharmacy',
      'category': 'Allergy',
    },
  ];

  final List<String> categories = [
    'All',
    'Pain Relief',
    'Antibiotics',
    'Vitamins',
    'Digestive Health',
    'Allergy',
    'Cardiovascular',
    'Diabetes',
    'Respiratory',
  ];

  List<Map<String, dynamic>> get filteredMedicines {
    if (_selectedCategory == null || _selectedCategory == 'All') {
      return medicines;
    }
    return medicines.where((medicine) => medicine['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Medicine Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
                ],
              ),
            ),
            
            // Categories Horizontal List
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category || 
                                   (_selectedCategory == null && category == 'All');
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category == 'All' ? null : category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Medicines Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = filteredMedicines[index];
                    return _buildMedicineCard(medicine);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medicine Image
          Expanded(
            flex: 3,
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
          
                     // Medicine Details
           Expanded(
             flex: 2,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           medicine['name'],
                           style: const TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                           ),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                         const SizedBox(height: 2),
                         Text(
                           medicine['category'],
                           style: const TextStyle(
                             fontSize: 10,
                             color: Colors.blue,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         const SizedBox(height: 2),
                         Text(
                           medicine['pharmacy'],
                           style: const TextStyle(
                             fontSize: 9,
                             color: Colors.grey,
                           ),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ],
                     ),
                   ),
                   
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Text(
                           medicine['price'],
                           style: const TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                             color: Colors.blue,
                           ),
                         ),
                       ),
                       GestureDetector(
                         onTap: () => _addToCart(medicine),
                         child: Container(
                           padding: const EdgeInsets.all(4),
                           child: const Icon(
                             Icons.add_shopping_cart,
                             size: 16,
                             color: Colors.blue,
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
} 