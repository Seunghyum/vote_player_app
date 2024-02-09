import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillsScreen extends StatefulWidget {
  final Candidate candidate;
  const BillsScreen({super.key, required this.candidate});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  int filterStatus(String status) {
    return widget.candidate.bills
        .where((element) => element.status == status)
        .length;
  }

  void _onFilterTap(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Hero(
                tag: '대표 발의',
                child: BillStatusDonutChart(
                  passed: filterStatus(BillStatusEnum.passed.koreanName),
                  pending: filterStatus(BillStatusEnum.pending.koreanName),
                  amendmentPassed: filterStatus(
                    BillStatusEnum.amendmentPassed.koreanName,
                  ),
                  alternativePassed: filterStatus(
                    BillStatusEnum.alternativePassed.koreanName,
                  ),
                  termExpiration: filterStatus(
                    BillStatusEnum.termExpiration.koreanName,
                  ),
                  dispose: filterStatus(BillStatusEnum.dispose.koreanName),
                  withdrawal: filterStatus(
                    BillStatusEnum.withdrawal.koreanName,
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: [
                Gaps.v24,
                const Text(
                  '대표 발의 상세',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size18,
                  ),
                ),
                const Divider(),
                ListFilter(
                  items: [
                    ListFilterItem(
                      name: '전체',
                      value: 'all',
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      onTap: (value) => _onFilterTap('all'),
                    ),
                    ...BillStatusEnum.values.map(
                      (v) => ListFilterItem(
                        name: v.koreanName,
                        value: v.englishName,
                        backgroundColor:
                            getColorByBillStatus(getBillStatus(v.koreanName))
                                .backgroundColor,
                        onTap: (value) => _onFilterTap(value),
                      ),
                    ),
                  ],
                ),
                ...widget.candidate.bills.map(
                  (e) => ListTile(
                    leading: BillStatusLabel(
                      status: getBillStatus(e.status),
                    ),
                    title: FractionallySizedBox(
                      child: Text(
                        e.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.committee),
                        Row(
                          children: [
                            Text(
                              e.nth,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(' ${getyyyyMMdd(e.date)}~'),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_sharp,
                      size: Sizes.size32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
