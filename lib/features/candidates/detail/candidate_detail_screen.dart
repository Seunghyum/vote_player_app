import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidateDetailScreen extends StatefulWidget {
  final String imagePath;
  final Candidate candidate;

  const CandidateDetailScreen({
    super.key,
    required this.imagePath,
    required this.candidate,
  });

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
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
    return widget.candidate.bills
        .where((element) => element.status == status)
        .length;
  }

  void _onBillsTap() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return BillsScreen(
            // imagePath: imagePath,
            candidate: widget.candidate,
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
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Hero(
                        tag: widget.candidate.id,
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(widget.imagePath),
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      widget.candidate.koName,
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList.list(
              children: [
                Gaps.v10,
                ListTable(
                  data: [
                    {
                      "key": '소속 위원회',
                      "value": Text(
                        renderEmptyString(widget.candidate.affiliatedCommittee),
                      ),
                    },
                    {
                      "key": '선거구',
                      "value": Text(
                        renderEmptyString(widget.candidate.electoralDistrict),
                      ),
                    },
                    {
                      "key": '당선횟수',
                      "value": Text(
                        renderEmptyString(widget.candidate.electionCount),
                      ),
                    },
                    {
                      "key": '의원 홈페이지',
                      "value": GestureDetector(
                        onTap: () =>
                            _onLinkTap(widget.candidate.memberHomepage),
                        child: Text(
                          renderEmptyString(widget.candidate.memberHomepage),
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    },
                    {
                      "key": '개별 홈페이지',
                      "value": GestureDetector(
                        onTap: () =>
                            _onLinkTap(widget.candidate.individualHomepage),
                        child: Text(
                          renderEmptyString(
                            widget.candidate.individualHomepage,
                          ),
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    },
                    {
                      "key": '사무실전화',
                      "value": Text(
                        renderEmptyString(widget.candidate.officePhone),
                      ),
                    },
                    {
                      "key": 'Email',
                      "value": Text(
                        renderEmptyString(widget.candidate.email),
                      ),
                    },
                    {
                      "key": '보좌관',
                      "value": Text(
                        renderEmptyString(widget.candidate.aide),
                      ),
                    },
                    {
                      "key": '선임비서관',
                      "value": Text(
                        renderEmptyString(widget.candidate.chiefOfStaff),
                      ),
                    },
                    {
                      "key": '비서관',
                      "value": Text(
                        renderEmptyString(widget.candidate.secretary),
                      ),
                    },
                    {
                      "key": '의원실안내',
                      "value": Text(
                        renderEmptyString(widget.candidate.officeGuide),
                      ),
                    },
                  ],
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onBillsTap,
                  child: AbsorbPointer(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              '대표 발의',
                              style: TextStyle(
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
                                '총 ${widget.candidate.bills.length}개 법안',
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
                        const Divider(),
                        Hero(
                          tag: '대표 발의',
                          child: BillStatusDonutChart(
                            passed:
                                filterStatus(BillStatusEnum.passed.koreanName),
                            pending:
                                filterStatus(BillStatusEnum.pending.koreanName),
                            amendmentPassed: filterStatus(
                              BillStatusEnum.amendmentPassed.koreanName,
                            ),
                            alternativePassed: filterStatus(
                              BillStatusEnum.alternativePassed.koreanName,
                            ),
                            termExpiration: filterStatus(
                              BillStatusEnum.termExpiration.koreanName,
                            ),
                            dispose:
                                filterStatus(BillStatusEnum.dispose.koreanName),
                            withdrawal: filterStatus(
                              BillStatusEnum.withdrawal.koreanName,
                            ),
                          ),
                        ),
                      ],
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
                ...widget.candidate.billsStatistics
                    .where((element) => element.name.isNotEmpty)
                    .map(
                      (bs) => ListTile(
                        title: Row(
                          children: [
                            Badge(
                              isLabelVisible: widget
                                  .candidate.affiliatedCommittee
                                  .contains(bs.name),
                              label: const Text(
                                '소속',
                                // style: TextStyle(fontSize: Sizes.size14),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              offset: const Offset(20, 3.5),
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                bs.name,
                                style: const TextStyle(fontSize: Sizes.size16),
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
          ],
        ),
      ),
    );
  }
}
