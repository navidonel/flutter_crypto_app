import 'package:edu/ui/global_widget/bottm_nav.dart';
import 'package:edu/ui/home_page.dart';
import 'package:edu/ui/market_view_page.dart';
import 'package:edu/ui/profile_page.dart';
import 'package:edu/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.compare_arrows),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: _myPage,),
      body: PageView(
        controller: _myPage,
        onPageChanged: (page) {
          print(page);
        },
        children: [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage()
        ],
      ),
    );
  }
}
