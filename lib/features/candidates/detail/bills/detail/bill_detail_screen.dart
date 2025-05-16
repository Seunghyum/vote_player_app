import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/repo/bill_vote_result_repo.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/bill_vote_result_page.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
import 'package:vote_player_app/services/candidates_bills_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';
import 'package:vote_player_app/utils/url.dart';

class BillDetailScreen extends StatefulWidget {
  static String routeName = '/candidates/:id/bills/:billNo';
  final BillTypeEnum type;
  final String candidateId;
  final String billNo;
  const BillDetailScreen({
    super.key,
    required this.type,
    required this.candidateId,
    required this.billNo,
  });

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  late String? title;
  Future<void> _onLinkTap(String link) async {
    final Uri url = Uri.parse(getNormalizedUrl(link));
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getBillByIdWithCandidateIdQuery(
        type: widget.type,
        candidateId: widget.candidateId,
        billNo: widget.billNo,
      ),
      builder: (context, state) {
        return Scaffold(
          appBar: BillAppBar(
            title: Text(state.data?.name ?? ''),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
              child: Column(
                children: [
                  ListTable(
                    data: [
                      {
                        "key": '법안명',
                        "value": Text(state.data?.name ?? ''),
                      },
                      {
                        "key": '법안상태',
                        "value": Row(
                          children: [
                            if (state.data != null && state.data?.status != '')
                              BillStatusLabel(
                                status: getBillStatus(state.data!.status!),
                              ),
                          ],
                        ),
                      },
                      {
                        "key": '위원회',
                        "value": Text(state.data?.committee ?? ''),
                      },
                      {
                        "key": '제안자',
                        "value": Text(state.data?.proposers ?? ''),
                      },
                      {
                        "key": '제안일자',
                        "value": Text(
                          DateFormat('yyyy.MM.dd')
                              .format(state.data?.date ?? DateTime.now()),
                        ),
                      },
                      {
                        "key": '국회 홈페이지',
                        "value": GestureDetector(
                          onTap: () =>
                              _onLinkTap(state.data?.billDetailUrl ?? ''),
                          child: const Row(
                            children: [
                              Text(
                                '국회 홈페이지 바로가기 ',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.open_in_new,
                                size: Sizes.size16,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      },
                    ],
                  ),
                  Html(data: state.data?.summary ?? ''),
                  Gaps.h16,
                  QueryBuilder(
                    query: BillVoteResultRepository()
                        .getBillVoteResultsByBillIdQuery(
                      age: state.data?.age ?? '',
                      billId: state.data?.billId ?? '',
                    ),
                    builder: (context, state) {
                      if (state.status == QueryStatus.error) {
                        return const Text('에러발생가 발생했습니다. 잠시 후 다시 시도해주세요');
                      } else if (state.status == QueryStatus.loading ||
                          state.status == QueryStatus.initial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == QueryStatus.success) {
                        return BlocProvider(
                          create: (_) => VoteBloc(
                            allMembers: state.data?.items ?? [],
                            statics: state.data?.statics ?? [],
                          ),
                          child: state.data!.items.isNotEmpty
                              ? const BillVoteResultPage()
                              : Container(),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
