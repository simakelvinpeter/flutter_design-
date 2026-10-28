import 'package:flutter/material.dart';
import 'order_tracking_screen.dart';
import 'demo_order.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'Cash on delivery';
  String address = 'Dereboyu Lefkosa\nToros Apt. Door 405';
  String contact = '+908743251578\nokeefe@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/Grocerylogo.png',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.shopping_basket,
                size: 40,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Payment',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 2) {
            _showContactDialog(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your demo cart is shown on this page.')),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 46, 43, 212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Address',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddressDialog(context),
                        ),
                      ],
                    ),
                    Text(address),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Contact Information',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showContactDialog(context),
                        ),
                      ],
                    ),
                    Text(contact),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Items',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
            const SizedBox(height: 16),
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                    label: Text(paymentMethod),
                    backgroundColor: Colors.blue[100]),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: _choosePaymentMethod,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(r'Total $12.00',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => OrderConfirmationDialog(
                        order: DemoOrder(address: address, contact: contact, paymentMethod: paymentMethod),
                      ),
                    );
                  },
                  child:
                      const Text('Place demo order', style: TextStyle(color: Colors.white)),
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

  Future<void> _showAddressDialog(BuildContext context) async {
    final value = await _editDetails('Edit Address', address, false);
    if (value != null && mounted) setState(() => address = value);
  }

  Future<void> _showContactDialog(BuildContext context) async {
    final value = await _editDetails('Edit Contact Information', contact, true);
    if (value != null && mounted) setState(() => contact = value);
  }

  Future<String?> _editDetails(String title, String current, bool isContact) {
    final form = GlobalKey<FormState>();
    var draft = current;
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Form(
          key: form,
          child: TextFormField(
            initialValue: current,
            maxLines: 3,
            maxLength: 250,
            onChanged: (value) => draft = value.trim(),
            validator: (value) {
              if ((value ?? '').trim().isEmpty) return 'Please enter your details';
              if (isContact && !RegExp(r'\+?[0-9][0-9\s()-]{5,}').hasMatch(value!)) {
                return 'Please include a valid phone number';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (form.currentState!.validate()) Navigator.pop(dialogContext, draft);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _choosePaymentMethod() async {
    final chosen = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Payment Method'),
        children: ['Cash on delivery', 'Card (demo only)'].map((method) =>
          SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, method),
            child: Text(method),
          ),
        ).toList(),
      ),
    );
    if (chosen != null && mounted) setState(() => paymentMethod = chosen);
  }

}

class OrderConfirmationDialog extends StatelessWidget {
  const OrderConfirmationDialog({super.key, required this.order});

  final DemoOrder order;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.blue, size: 48),
            const SizedBox(height: 16),
            const Text('Congratulations!!!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 8),
            const Text('Demo order created. No payment was collected and no delivery was booked.',
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                final navigator = Navigator.of(context);
                navigator.pop();
                navigator.push(
                  MaterialPageRoute(
                      builder: (_) => OrderTrackingScreen(order: order)),
                );
              },
              child: const Text('Track order',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
