import 'package:flutter/material.dart';
import 'demo_order.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key, required this.order});

  final DemoOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Tracking',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 2) {
            showDialog<void>(context: context, builder: (context) => AlertDialog(
              title: const Text('Contact Information'),
              content: Text(order.contact),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
            ));
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blue[50],
                    child: const Icon(Icons.shopping_cart,
                        size: 40, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Demo Order Details:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Order ID: ${order.id}'),
                  Text('Order Date: ${order.date}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Order Confirm',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(order.date, style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('Packaging',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    const Text('Not started', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Text('Delivered',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    const Text('Demo only',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Items',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  _buildItemRowWithAsset(
                    assetPath: 'assets/type c charger.png',
                    name: 'Type C Charger',
                    qty: '1',
                    price: r'$8',
                  ),
                  const SizedBox(height: 8),
                  _buildItemRowWithAsset(
                    assetPath: 'assets/avocado.png',
                    name: 'Avocado',
                    qty: '1',
                    price: r'$4',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payment',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(order.paymentMethod),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 170, child: Text(order.address)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRowWithAsset({
    required String assetPath,
    required String name,
    required String qty,
    required String price,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            assetPath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 40,
              height: 40,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(name)),
        Text(qty),
        const SizedBox(width: 8),
        Text(price),
      ],
    );
  }
}
