import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/nth_tab.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/persistent_tabbar.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';
import 'package:vote_player_app/utils/url.dart';

const tabs = ['대표발의', '공동발의'];

class CandidateDetailScreen extends StatefulWidget {
  static String routeName = '/candidates/:id';
  final String id;
  const CandidateDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen>
    with SingleTickerProviderStateMixin {
  late Future<Candidate> featureCandidate;
  late int billsCount;
  late int collabillsCount;
  String nth = '';

  Future<void> _onLinkTap(String link) async {
    final Uri url = Uri.parse(getNormalizedUrl(link));
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String renderEmptyString(String text) {
    return text.isNotEmpty ? text : '-';
  }

  int filterStatus(String status, BillTypeEnum type) {
    final query = getCandidateByIdQuery(id: widget.id);
    final target = type == BillTypeEnum.bills
        ? query.state.data?.billsStatusStatistics
        : query.state.data?.collabillsStatusStatistics;
    return target
            ?.firstWhere(
              (element) => element.name == status && element.nth == nth,
              orElse: () =>
                  BillsStatisticsItem(name: status, value: 0, nth: ''),
            )
            .value ??
        0;
  }

  List<String> getNthList() {
    final query = getCandidateByIdQuery(id: widget.id);
    return query.state.data?.billsNthStatistics ?? [];
  }

  void _onBillsTap(BillTypeEnum type) {
    print("@@@@ !!!! $nth ");
    context.push(
      '/candidates/${widget.id}/bills?type=${type == BillTypeEnum.bills ? 'bill' : 'collabills'}&nth=$nth',
    );
  }

  void _onNthTap(String str) {
    setState(() {
      nth = str;
    });
  }

  @override
  void initState() {
    super.initState();
    final query = getCandidateByIdQuery(id: widget.id);
    nth = query.state.data?.billsNthStatistics.first ?? '';
  }

  Widget _billsPage({required BillTypeEnum type}) {
    final typeText = type == BillTypeEnum.bills ? '대표' : '공동';
    final query = getCandidateByIdQuery(id: widget.id);
    final candidate = query.state.data;

    if (nth == '') nth = query.state.data?.billsNthStatistics.first ?? '';

    // NOTE 빌드 타임에 실행되므로 setState 없이 실행
    Iterable<BillsStatisticsItem> billsCommitteeStatistics =
        (candidate?.billsCommitteeStatistics ?? []).where(
      (element) => element.nth == nth,
    );
    billsCount =
        billsCommitteeStatistics.fold(0, (sum, next) => sum + next.value);

    Iterable<BillsStatisticsItem> collabillsCommitteeStatistics =
        (candidate?.collabillsCommitteeStatistics ?? []).where(
      (element) => element.nth == nth,
    );
    collabillsCount =
        collabillsCommitteeStatistics.fold(0, (sum, next) => sum + next.value);

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            Row(
              children: [
                ...(query.state.data?.billsNthStatistics ?? []).map(
                  (e) => GestureDetector(
                    onTap: () => _onNthTap(e),
                    child: NthTab(
                      nth: nth,
                      text: e,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _onBillsTap(type),
              child: AbsorbPointer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$typeText 발의',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        const SizedBox(
                          width: Sizes.size8,
                        ),
                        Opacity(
                          opacity: 0.6,
                          child: Text(
                            '총 ${type == BillTypeEnum.bills ? billsCount : collabillsCount}개의 법안',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Sizes.size14,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: 0.6,
                              child: Icon(
                                Icons.chevron_right_sharp,
                                size: Sizes.size32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Hero(
                      tag: '$typeText발의-${candidate?.id}',
                      child: BillStatusDonutChart(
                        passed: filterStatus(
                          BillStatusEnum.passed.koreanName,
                          type,
                        ),
                        pending: filterStatus(
                          BillStatusEnum.pending.koreanName,
                          type,
                        ),
                        amendmentPassed: filterStatus(
                          BillStatusEnum.amendmentPassed.koreanName,
                          type,
                        ),
                        alternativePassed: filterStatus(
                          BillStatusEnum.alternativePassed.koreanName,
                          type,
                        ),
                        termExpiration: filterStatus(
                          BillStatusEnum.termExpiration.koreanName,
                          type,
                        ),
                        dispose: filterStatus(
                          BillStatusEnum.dispose.koreanName,
                          type,
                        ),
                        withdrawal: filterStatus(
                          BillStatusEnum.withdrawal.koreanName,
                          type,
                        ),
                        rejected: filterStatus(
                          BillStatusEnum.rejected.koreanName,
                          type,
                        ),
                      ),
                    ),
                    const Text(
                      '소속 위원회별 대표 발의안 제출 횟수',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    const Divider(),
                    ...(candidate != null
                        ? (typeText == '대표'
                                ? billsCommitteeStatistics
                                : collabillsCommitteeStatistics)
                            .where(
                              (element) => element.name.isNotEmpty,
                            )
                            .map(
                              (bs) => ListTile(
                                title: Row(
                                  children: [
                                    Badge(
                                      isLabelVisible: candidate
                                          .affiliatedCommittee
                                          .contains(bs.name),
                                      label: const Text(
                                        '소속',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      offset: const Offset(20, 3.5),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Text(
                                        bs.name,
                                        style: const TextStyle(
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                leading: SizedBox(
                                  width: Sizes.size56,
                                  child: Text(
                                    '${bs.value}회',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: Sizes.size16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        : []),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QueryBuilder<Candidate>(
      query: getCandidateByIdQuery(id: widget.id),
      builder: (context, state) {
        final isLoading = state.data == null;
        final result = state.data ??
            Candidate(
              id: '',
              enName: "xxxx xxxx",
              electoralDistrict: "xxxx xxxxx xxxxx",
              affiliatedCommittee: "xxxxxxx",
              electionCount: "xxxx xxxxxxxx  xxxxxxxx",
              officePhone: "xx-xxx-xxxx",
              officeRoom: "xxxxx xxxxxx",
              individualHomepage: "xxxxxx xxxxxxxx xxxx",
              email: "kds21341@naver.com",
              aide: "xxxx xxxx",
              chiefOfStaff: "xxxx xxxx",
              secretary: "xxxx xxxx xxxx xxxx xxxx xxxx",
              officeGuide: "xxxxxx xxxx xxxxx xxxx xx xxxxx",
              history: "xxx xxxx xxxxx xxxxxx",
              koName: "xxx xxx",
              partyName: "xxxxx",
              memberHomepage: 'xxxxxx xxx xxxxxx xxxxxx',
              bills: [],
              billsCommitteeStatistics: [],
              collabills: [],
              collabillsCommitteeStatistics: [],
              billsStatusStatistics: [],
              collabillsStatusStatistics: [],
              billsNthStatistics: [],
              collabillsNthStatistics: [],
            );
        return Skeletonizer(
          enabled: isLoading,
          child: Scaffold(
            appBar: BillAppBar(
              title: Text(result.koName),
            ),
            body: DefaultTabController(
              length: tabs.length,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size24,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Hero(
                                  tag: result.id,
                                  child: CircleAvatar(
                                    foregroundImage: NetworkImage(
                                      getS3ImageUrl(
                                        BucketCategory.candidates,
                                        '${result.enName}.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              ListTable(
                                data: [
                                  {
                                    "key": '소속 위원회',
                                    "value": Text(
                                      renderEmptyString(
                                        result.affiliatedCommittee,
                                      ),
                                    ),
                                  },
                                  {
                                    "key": '선거구',
                                    "value": Text(
                                      renderEmptyString(
                                        result.electoralDistrict,
                                      ),
                                    ),
                                  },
                                  {
                                    "key": '당선횟수',
                                    "value": Text(
                                      renderEmptyString(
                                        result.electionCount,
                                      ),
                                    ),
                                  },
                                  {
                                    "key": '의원 홈페이지',
                                    "value": GestureDetector(
                                      onTap: () =>
                                          _onLinkTap(result.memberHomepage),
                                      child: Text(
                                        renderEmptyString(
                                          result.memberHomepage,
                                        ),
                                        style: TextStyle(
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                  },
                                  {
                                    "key": '개별 홈페이지',
                                    "value": GestureDetector(
                                      onTap: () => _onLinkTap(
                                        result.individualHomepage,
                                      ),
                                      child: Text(
                                        renderEmptyString(
                                          result.individualHomepage,
                                        ),
                                        style: TextStyle(
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                  },
                                  {
                                    "key": '사무실전화',
                                    "value": Text(
                                      renderEmptyString(result.officePhone),
                                    ),
                                  },
                                  {
                                    "key": 'Email',
                                    "value": Text(
                                      renderEmptyString(result.email),
                                    ),
                                  },
                                  {
                                    "key": '보좌관',
                                    "value": Text(
                                      renderEmptyString(result.aide),
                                    ),
                                  },
                                  {
                                    "key": '선임비서관',
                                    "value": Text(
                                      renderEmptyString(result.chiefOfStaff),
                                    ),
                                  },
                                  {
                                    "key": '비서관',
                                    "value": Text(
                                      renderEmptyString(result.secretary),
                                    ),
                                  },
                                  {
                                    "key": '의원실안내',
                                    "value": Text(
                                      renderEmptyString(result.officeGuide),
                                    ),
                                  },
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: PersistentTabBar(
                        billsCount: billsCount,
                        collabillsCount: collabillsCount,
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size12,
                      horizontal: Sizes.size24,
                    ),
                    child: TabBarView(
                      children: [
                        _billsPage(type: BillTypeEnum.bills), // 대표발의 법안 페이지
                        _billsPage(type: BillTypeEnum.collabils), // 공동발의 법안 페이지
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
