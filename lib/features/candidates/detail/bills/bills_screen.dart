import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/bill_list_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/candidates_bills/models/candidates_bills_response_model.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/candidates_bills/repo/candidates_bills_repo.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/nth_tab.dart';
import 'package:vote_player_app/features/candidates/models/candidate_model.dart';
import 'package:vote_player_app/features/candidates/repo/candidates_repo.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillsScreen extends StatefulWidget {
  static String routeName = '/candidates/:id/bills';
  final String id;
  late BillTypeEnum? type;
  final String? age;

  BillsScreen({
    super.key,
    this.type = BillTypeEnum.bills,
    required this.age,
    required this.id,
  });

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _scrollController = ScrollController();
  final _candidatesRepo = CandidatesRepo();
  BillStatusEnum filterValue = BillStatusEnum.all;
  String age = '';

  int filterStatus(String status) {
    final query = _candidatesRepo.getCandidateByIdQuery(id: widget.id);
    final target = widget.type == BillTypeEnum.bills
        ? query.state.data?.billsStatusStatistics
        : query.state.data?.collabillsStatusStatistics;
    final value = target
        ?.firstWhere(
          (element) => element.name == status && element.age == age,
          orElse: () => BillsStatisticsItem(name: status, value: 0, age: ''),
        )
        .value;
    return value!.isFinite ? value : 1;
  }

  void _onFilterTap(BillStatusEnum value) {
    setState(() {
      filterValue = value;
      CandidatesBillsRepo().getCandidatesBillsInfiniteQuery(
        id: widget.id,
        status: filterValue,
        age: age,
        type: widget.type,
      );
    });
  }

  void _onListTileTap(String billNo) {
    context.push('/candidates/${widget.id}/bills/$billNo'); // TODO: billId 적용
  }

  void _onScroll() {
    final query = CandidatesBillsRepo().getCandidatesBillsInfiniteQuery(
      id: widget.id,
      status: filterValue,
      age: age,
      type: widget.type,
    );
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

  void _onNthTap(String str) {
    setState(() {
      age = str;
    });
  }

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
    return QueryBuilder(
      query: _candidatesRepo.getCandidateByIdQuery(id: widget.id),
      builder: (BuildContext context, QueryState<Candidate> state) {
        return Scaffold(
          appBar: BillAppBar(
            title: Text(
              '${widget.type == BillTypeEnum.bills ? '대표' : '공동'}발의 상세',
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      ...(state.data?.billsNthStatistics ?? []).map(
                        (e) => GestureDetector(
                          onTap: () => _onNthTap(e),
                          child: NthTab(
                            age: age,
                            text: e,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Hero(
                    tag:
                        '${widget.type == BillTypeEnum.bills ? '대표' : '공동'}발의-${state.data?.id ?? ''}',
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
                              active: filterValue.englishName == v.englishName,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InfiniteQueryBuilder<CandidatesBillsResponse, int>(
                      query:
                          CandidatesBillsRepo().getCandidatesBillsInfiniteQuery(
                        id: widget.id,
                        status: filterValue,
                        age: age,
                        type: widget.type,
                      ),
                      builder: (context, state, query) {
                        final list = state.data;
                        return Column(
                          children: [
                            ...list!.expand((page) {
                              return page.result.map((item) {
                                return ListTile(
                                  onTap: () => _onListTileTap(item.billNo!),
                                  leading: BillStatusLabel(
                                    status: getBillStatus(item.status!),
                                  ),
                                  title: FractionallySizedBox(
                                    child: Text(
                                      item.name!,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.size16,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.committee!),
                                      Row(
                                        children: [
                                          Text(
                                            "${item.age}대",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(' ${getyyyyMMdd(item.date!)}~'),
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
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
