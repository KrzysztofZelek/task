import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:recruitment_task/view/comment_page.dart';
import 'package:recruitment_task/view/photo_page.dart';
import 'package:recruitment_task/view/no_internet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription internetSubcription;
  bool hasInternet = false;
  int selectedIndex = 0;
  final screens = [
    const LandingPage(),
    const CommentPage(),
  ];
  @override
  void initState() {
    super.initState();
    internetSubcription =
        InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  void dispose() {
    internetSubcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Photos',
            icon: Icon(Icons.photo),
          ),
          BottomNavigationBarItem(
            label: 'Comments',
            icon: Icon(Icons.comment),
          ),
        ],
      ),
      body: hasInternet ? screens[selectedIndex] : const NoInternetPage(),
    );
  }
}
