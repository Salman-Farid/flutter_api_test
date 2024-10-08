import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/views/profile/profile_view.dart';

import '../../controllers/mainscreen_controller.dart';
import '../Dashboard/dashboard.dart';
import '../home/home.dart';
import '../order_management/orderlist_screen.dart';
import '../review/product_review.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/mainScreen";
  final MainController controller = Get.put(MainController());
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          controller.changePage(index);
        },
        children: [
          HomeScreen(),
          DashboardScreen(),
          OrderListScreen(),
          ProductReviewScreen(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent, // Remove splash color
            highlightColor: Colors.transparent, // Remove highlight color
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Colors.blue, // Selected item color
            unselectedItemColor: Colors.grey, // Unselected item color
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.changePage(index);
              _pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Order'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Review'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
            ],
          ),
        );
      }),
    );
  }
}
