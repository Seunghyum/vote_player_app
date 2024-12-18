import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_bills_service.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

enum BillTypeEnum { bills, collabils }

class BillsScreen extends StatefulWidget {
  static String routeName = '/candidates/:id/bills';
  final String id;
  BillStatusEnum? currentStatus;
  late BillTypeEnum? type;
  BillsScreen({
    super.key,
    this.type = BillTypeEnum.bills,
    this.currentStatus,
    required this.id,
  });

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  BillStatusEnum filterValue = BillStatusEnum.passed;

  int filterStatus(String status) {
    final query = getCandidateByIdQuery(id: widget.id);
    final target = widget.type == BillTypeEnum.bills
        ? query.state.data?.billsStatusStatistics
        : query.state.data?.collabillsStatusStatistics;
    return target
            ?.firstWhere(
              (element) => element.name == status,
              orElse: () => BillsStatisticsItem(name: status, value: 0),
            )
            .value ??
        0;
  }

  void _onFilterTap(BillStatusEnum value) {
    setState(() {
      filterValue = value;
    });
  }

  void _onListTileTap() {
    context.push('/candidates/${widget.id}/bills?type=${widget.type}');
  }

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getCandidateByIdQuery(id: widget.id),
      builder: (BuildContext context, QueryState<Candidate> state) {
        return Scaffold(
          appBar: BillAppBar(
            title: Text(state.data?.koName ?? ''),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: CustomScrollView(
              slivers: [
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
                      query: getCandidatesBillsInfiniteQuery(
                        id: widget.id,
                        status: filterValue,
                        type: widget.type,
                      ),
                      builder: (context, state, query) {
                        final list = state.data;
                        return Column(
                          children: [
                            ...list!.expand((page) {
                              return page.result.map((item) {
                                return ListTile(
                                  onTap: () => _onListTileTap(),
                                  leading: BillStatusLabel(
                                    status: getBillStatus(item.status),
                                  ),
                                  title: FractionallySizedBox(
                                    child: Text(
                                      item.name,
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
                                      Text(item.committee),
                                      Row(
                                        children: [
                                          Text(
                                            item.nth,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(' ${getyyyyMMdd(item.date)}~'),
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
