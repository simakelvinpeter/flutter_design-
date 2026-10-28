# GroceryAppNEU design assignment

A Flutter checkout and order-tracking UI assignment. The original blue-and-white design and product assets are preserved.

## Run

Install Flutter stable, then run:

```sh
flutter pub get
flutter run
```

```sh
flutter analyze --no-fatal-infos
flutter test
```

## Try the flow

Edit the delivery address and contact details. Blank addresses and contacts without a phone number are rejected. Choose cash on delivery or the clearly marked demo card option. Place a demo order and open tracking: the same address, payment choice, current date and generated order ID appear there. Home/Cart returns to checkout; Profile shows the contact details.

This is a local UI assignment. It does not collect money, submit orders to a shop, or track a real courier. The sample cart contains one charger and one avocado, totaling $12. Details are held in memory for this demonstration and reset when the app restarts.

The shared order is in lib/demo_order.dart. Checkout is in lib/payment_screen.dart; tracking is in lib/order_tracking_screen.dart. Widget tests check validation and the complete checkout-to-tracking flow. GitHub Actions runs the Flutter checks because this workstation does not have Flutter installed.
