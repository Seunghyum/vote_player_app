import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/bill_detail_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

enum BillTypeEnum { bills, collabils }

class BillsScreen extends StatefulWidget {
  final BillTypeEnum type;
  final Candidate candidate;
  const BillsScreen({super.key, required this.candidate, required this.type});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  BillStatusEnum filterValue = BillStatusEnum.passed;
  Iterable<Bill> filteredList = [];
  int filterStatus(String status) {
    final list = widget.type == BillTypeEnum.bills
        ? widget.candidate.bills
        : widget.candidate.collabills;
    return list.where((element) => element.status == status).length;
  }

  void _onFilterTap(BillStatusEnum value) {
    setState(() {
      filterValue = value;

      if (value == BillStatusEnum.all) {
        filteredList = widget.candidate.bills;
      } else {
        final list = widget.type == BillTypeEnum.bills
            ? widget.candidate.bills
            : widget.candidate.collabills;
        filteredList = list.where((e) {
          return getBillStatus(e.status).englishName == value.englishName;
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      filteredList = widget.candidate.bills.where((e) {
        return getBillStatus(e.status) == filterValue;
      });
    });
    super.initState();
  }

  void _onListTileTap({required Bill bill}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return BillDetailScreen(
            bill: bill,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BillAppBar(
        title: Text(widget.candidate.koName),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Hero(
                tag:
                    '${widget.type == BillTypeEnum.bills ? '대표' : '공동'}발의-${widget.candidate.id}',
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
                Text(
                  '${widget.type == BillTypeEnum.bills ? '대표' : '공동'}발의 상세',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size18,
                  ),
                ),
                const Divider(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListFilter(items: [
                    ...BillStatusEnum.values.map(
                      (v) => ListFilterItem(
                        name: v.koreanName,
                        value: getBillStatus(v.englishName),
                        backgroundColor:
                            getColorByBillStatus(getBillStatus(v.englishName))
                                .backgroundColor,
                        onTap: (value) {
                          _onFilterTap(value);
                        },
                        active: filterValue.englishName == v.englishName,
                      ),
                    )
                  ]),
                ),
                ...filteredList.map(
                  (e) => ListTile(
                    onTap: () => _onListTileTap(bill: e),
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
