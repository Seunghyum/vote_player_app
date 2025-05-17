import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/bill_list_screen.dart';
import 'package:vote_player_app/features/region/region_screen.dart';
import 'package:vote_player_app/features/main_navigation/widgets/nav_tab.dart';
import 'package:vote_player_app/features/candidates/list/candidates_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static String routeName = '/';
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const CandidatesScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const BillListScreen(),
          ),
          // Offstage(
          //   offstage: _selectedIndex != 2,
          //   child: const RegionScreen(),
          // ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              text: "국회의원",
              icon: Icons.how_to_reg_outlined,
              selectedIcon: Icons.how_to_reg,
              isSelected: _selectedIndex == 0,
              onTap: () => _onTap(0),
            ),
            NavTab(
              text: "법률안",
              icon: Icons.my_library_books_outlined,
              selectedIcon: Icons.my_library_books,
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
            ),
            // NavTab(
            //   text: "지역",
            //   icon: Icons.where_to_vote_outlined,
            //   selectedIcon: Icons.where_to_vote,
            //   isSelected: _selectedIndex == 2,
            //   onTap: () => _onTap(2),
            // ),
          ],
        ),
      ),
    );
  }
}
