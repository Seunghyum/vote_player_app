import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';
import 'package:vote_player_app/utils/url.dart';

class BillDetailScreen extends StatelessWidget {
  final Bill bill;
  // final String title;
  // final String summary;
  // final String url;
  const BillDetailScreen({
    super.key,
    // required this.title,
    // required this.summary,
    // required this.url,
    required this.bill,
  });

  Future<void> _onLinkTap(String link) async {
    final Uri url = Uri.parse(getNormalizedUrl(link));
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BillAppBar(
        title: Text('법안 상세'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
        child: Column(children: [
          ListTable(
            data: [
              {
                "key": '법안명',
                "value": Text(bill.name),
              },
              {
                "key": '법안상태',
                "value": Row(
                  children: [
                    BillStatusLabel(
                      status: getBillStatus(bill.status),
                    ),
                  ],
                )
              },
              {
                "key": '위원회',
                "value": Text(bill.committee),
              },
              {
                "key": '제안자',
                "value": Text(bill.proposers),
              },
              {
                "key": '제안일자',
                "value": Text(DateFormat('yyyy.MM.dd').format(bill.date)),
              },
              {
                "key": '국회 홈페이지',
                "value": GestureDetector(
                  onTap: () => _onLinkTap(bill.billDetailUrl),
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
                      )
                    ],
                  ),
                ),
              },
            ],
          ),
          Gaps.h16,
          Html(data: bill.summary)
        ]),
      ),
    );
  }
}
