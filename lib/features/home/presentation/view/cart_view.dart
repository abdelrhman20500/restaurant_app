import 'package:flutter/material.dart';
import 'package:restaurant_app/Core/utilis/styles.dart';
import 'package:restaurant_app/Core/widget/custom_button.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Strawberry Shake',
      'price': 20.0,
      'quantity': 1,
      'image': 'assets/images/Rectangle 128.png',
    },
    {
      'name': 'Broccoli Lasagna',
      'price': 12.0,
      'quantity': 1,
      'image': 'assets/images/Rectangle 128.png',
    },
  ];

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

  double tax = 5.0;
  double delivery = 3.0;

  double get total => subtotal + tax + delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7CA53),
      body: Column(
        children: [
          // AppBar
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                  ),
                  const Expanded(
                    child: Text(
                      'Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // balance the back icon
                ],
              ),
            ),
          ),

          // White Content
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Items count
                    Text(
                      'You have ${cartItems.length} items in the cart',
                      style:Styles.style16.copyWith(color: Colors.black)),
                    const SizedBox(height: 20),
                    ...cartItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _buildCartItem(index, item);
                    }),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFFFE0D0), thickness: 1),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Tax and Fees', '\$${tax.toStringAsFixed(2)}'),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Delivery', '\$${delivery.toStringAsFixed(2)}'),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Total',
                      '\$${total.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomButton(text: "Checkout", color: const Color(0xFFF7CA53),width: 180,
                      onPressed: (){},),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              item['image'],
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),

          // Name + Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item['price'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFE95425),
                  ),
                ),
              ],
            ),
          ),

          // Delete + Quantity
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    cartItems.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete_outline, color: Color(0xFFE95425), size: 22),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (item['quantity'] > 1) {
                        setState(() => item['quantity']--);
                      }
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE8DF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.remove, size: 16, color: Color(0xFFE95425)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item['quantity']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => item['quantity']++);
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE95425),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}