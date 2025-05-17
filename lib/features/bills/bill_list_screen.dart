import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/repo/bill_list_repo.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

enum BillTypeEnum { bills, collabils }

class BillListScreen extends StatefulWidget {
  static String routeName = '/bills';
  final String? age;

  const BillListScreen({
    super.key,
    this.age = '22',
  });

  @override
  State<BillListScreen> createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> {
  final _billlistRepo = BillListRepo();
  final _scrollController = ScrollController();
  BillStatusEnum filterValue = BillStatusEnum.all;
  String age = '';

  int filterStatus(String status) {
    final query = _billlistRepo.getBillsInfiniteQuery();
    final value = query.state.data?.first.statistics
        .firstWhere(
          (element) => element.PROC_RESULT == status,
          orElse: () => BillListStatistics(
            count: 0,
            PROC_RESULT: status,
          ),
        )
        .count;
    return value!;
  }

  void _onFilterTap(BillStatusEnum value) {
    setState(() {
      filterValue = value;
    });
  }

  void _onListTileTap(String billNo) {
    context.push('/bills/$billNo');
  }

  void _onScroll() {
    final query = _billlistRepo.getBillsInfiniteQuery(status: filterValue);
    if (_isBottom && query.state.status != QueryStatus.loading) {
      query.getNextPage();
    }
  }

  // 최하단 판별
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  // void _onNthTap(String str) {
  //   setState(() {
  //     age = str;
  //   });
  // }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    setState(() {
      age = widget.age ?? '22';
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InfiniteQueryBuilder<BillListModelResponse, int>(
        query: _billlistRepo.getBillsInfiniteQuery(status: filterValue),
        builder: (ontext, state, query) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // SliverToBoxAdapter(
                  //   child: Row(
                  //     children: [
                  //       ...(state.data?.billsNthStatistics ?? []).map(
                  //         (e) => GestureDetector(
                  //           onTap: () => _onNthTap(e),
                  //           child: NthTab(
                  //             age: age,
                  //             text: e,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SliverToBoxAdapter(
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
                  SliverList.list(
                    children: [
                      const Divider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListFilter(
                          items: [
                            ...BillStatusEnum.values.map(
                              (v) => ListFilterItem(
                                name: v.koreanName,
                                value: getBillStatus(v.englishName),
                                backgroundColor: getColorByBillStatus(
                                  getBillStatus(v.englishName),
                                ).backgroundColor,
                                onTap: (value) {
                                  _onFilterTap(value);
                                },
                                active:
                                    filterValue.englishName == v.englishName,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ...state.data!.expand((page) {
                            return page.items.map((item) {
                              return ListTile(
                                onTap: () => _onListTileTap(item.BILL_NO!),
                                leading: BillStatusLabel(
                                  status: getBillStatus(item.PROC_RESULT!),
                                ),
                                title: FractionallySizedBox(
                                  child: Text(
                                    item.BILL_NAME ?? '',
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
                                    // Text(item.COMMITTEE ?? ''),
                                    Row(
                                      children: [
                                        Text(
                                          "${item.AGE}대",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          ' ${getyyyyMMdd(DateTime.parse(item.PROPOSE_DT!))}~',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right_sharp,
                                  size: Sizes.size32,
                                ),
                              );
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
