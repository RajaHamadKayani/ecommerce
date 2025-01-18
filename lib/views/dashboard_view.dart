import 'package:ecommerce_app/views/cart_view.dart';
import 'package:ecommerce_app/views/home_view.dart';
import 'package:ecommerce_app/views/profile_view.dart';
import 'package:ecommerce_app/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
    int _currentIndex = 0;

  final List<Widget> _screens = [
   HomeView(),
   WishlistScreen(),
   CartView(),
   ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/home.svg',
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/wishlist.svg',
              height: 24,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/cart.svg',
              height: 24,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/profile.svg',
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}