import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/models/candidate_model.dart';

List<String> tabs = ['대표발의', '공동발의'];

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final int billsCount;
  final int collabillsCount;
  const PersistentTabBar({
    required this.collabillsCount,
    required this.billsCount,
  });

  Widget _menuTab({required String title, int? count}) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            Text(
              count != null ? '(${count.toString()})' : '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: Sizes.size12,
                color: Colors.grey,
              ),
            ),
          ],
        ), // TODO: 공동법안 갯수
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        tabs: [
          _menuTab(
            title: '대표법안',
          ),
          _menuTab(
            title: '공동발의',
          ), // TODO
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
