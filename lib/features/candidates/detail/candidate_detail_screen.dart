import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
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

  Future<void> _onLinkTap(String link) async {
    final Uri url = Uri.parse(getNormalizedUrl(link));
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String renderEmptyString(String text) {
    return text.isNotEmpty ? text : '-';
  }

  int filterStatus(String status) {
    final query = getCandidateByIdQuery(id: widget.id);
    return query.state.data!.bills
        .where((element) => element.status == status)
        .length;
  }

  int filterCollaStatus(String status) {
    final query = getCandidateByIdQuery(id: widget.id);
    return query.state.data!.collabills
        .where((element) => element.status == status)
        .length;
  }

  void _onBillsTap(BillTypeEnum type) {
    context.push('/candidates/${widget.id}/bills');
  }

  Widget _billsPage(BillTypeEnum type) {
    final typeText = type == BillTypeEnum.bills ? '대표' : '공동';
    final query = getCandidateByIdQuery(id: widget.id);
    var candidate = query.state.data!;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () => _onBillsTap(BillTypeEnum.collabils),
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
                            '총 ${candidate.collabills.length}개 법안',
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
                      tag: '$typeText발의-${candidate.id}',
                      child: BillStatusDonutChart(
                        passed:
                            filterCollaStatus(BillStatusEnum.passed.koreanName),
                        pending: filterCollaStatus(
                          BillStatusEnum.pending.koreanName,
                        ),
                        amendmentPassed: filterCollaStatus(
                          BillStatusEnum.amendmentPassed.koreanName,
                        ),
                        alternativePassed: filterCollaStatus(
                          BillStatusEnum.alternativePassed.koreanName,
                        ),
                        termExpiration: filterCollaStatus(
                          BillStatusEnum.termExpiration.koreanName,
                        ),
                        dispose: filterCollaStatus(
                          BillStatusEnum.dispose.koreanName,
                        ),
                        withdrawal: filterCollaStatus(
                          BillStatusEnum.withdrawal.koreanName,
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
                    ...candidate.collabillsStatistics
                        .where((element) => element.name.isNotEmpty)
                        .map(
                          (bs) => ListTile(
                            title: Row(
                              children: [
                                Badge(
                                  isLabelVisible: candidate.affiliatedCommittee
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
                                    style:
                                        const TextStyle(fontSize: Sizes.size16),
                                  ),
                                ),
                              ],
                            ),
                            leading: SizedBox(
                              width: Sizes.size56,
                              child: Text(
                                '${bs.value}회',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: Sizes.size16),
                              ),
                            ),
                          ),
                        ),
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
        if (state.status == QueryStatus.loading) {
          return Scaffold(
            appBar: BillAppBar(
              title: const Text(''),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Hero(
                        tag: widget.id,
                        child: const CircleAvatar(),
                      ),
                    ),
                    Gaps.v10,
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        }
        if (state.data == null) return const Text('잘못된 요청입니다');
        return Scaffold(
          appBar: BillAppBar(
            title: Text(state.data!.koName),
          ),
          body: DefaultTabController(
            length: tabs.length,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size24),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Hero(
                                tag: state.data!.id,
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                    getS3ImageUrl(
                                      BucketCategory.candidates,
                                      '${state.data!.enName}.png',
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
                                      state.data!.affiliatedCommittee,
                                    ),
                                  ),
                                },
                                {
                                  "key": '선거구',
                                  "value": Text(
                                    renderEmptyString(
                                      state.data!.electoralDistrict,
                                    ),
                                  ),
                                },
                                {
                                  "key": '당선횟수',
                                  "value": Text(
                                    renderEmptyString(
                                      state.data!.electionCount,
                                    ),
                                  ),
                                },
                                {
                                  "key": '의원 홈페이지',
                                  "value": GestureDetector(
                                    onTap: () =>
                                        _onLinkTap(state.data!.memberHomepage),
                                    child: Text(
                                      renderEmptyString(
                                        state.data!.memberHomepage,
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
                                      state.data!.individualHomepage,
                                    ),
                                    child: Text(
                                      renderEmptyString(
                                        state.data!.individualHomepage,
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
                                    renderEmptyString(state.data!.officePhone),
                                  ),
                                },
                                {
                                  "key": 'Email',
                                  "value": Text(
                                    renderEmptyString(state.data!.email),
                                  ),
                                },
                                {
                                  "key": '보좌관',
                                  "value": Text(
                                    renderEmptyString(state.data!.aide),
                                  ),
                                },
                                {
                                  "key": '선임비서관',
                                  "value": Text(
                                    renderEmptyString(state.data!.chiefOfStaff),
                                  ),
                                },
                                {
                                  "key": '비서관',
                                  "value": Text(
                                    renderEmptyString(state.data!.secretary),
                                  ),
                                },
                                {
                                  "key": '의원실안내',
                                  "value": Text(
                                    renderEmptyString(state.data!.officeGuide),
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
                    delegate: PersistentTabBar(candidate: state.data!),
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
                      _billsPage(BillTypeEnum.bills), // 대표발의 법안 페이지
                      _billsPage(BillTypeEnum.collabils), // 공동발의 법안 페이지
                    ],
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
