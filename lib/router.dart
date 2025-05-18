import 'package:go_router/go_router.dart';
import 'package:vote_player_app/features/bills/bill_list_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/bill_detail_screen.dart';
import 'package:vote_player_app/features/candidates/detail/candidate_detail_screen.dart';
import 'package:vote_player_app/features/candidates/list/candidates_screen.dart';
import 'package:vote_player_app/features/main_navigation/main_navigation_screen.dart';
import 'package:vote_player_app/features/region/region_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: MainNavigationScreen.routeName,
      builder: (context, state) => const MainNavigationScreen(),
      routes: [
        GoRoute(
          path: 'candidates',
          builder: (context, state) => const CandidatesScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => CandidateDetailScreen(
                id: state.pathParameters['id']!,
              ),
              routes: [
                GoRoute(
                  path: 'bills',
                  builder: (context, state) => BillsScreen(
                    id: state.pathParameters['id']!,
                    age: state.uri.queryParameters['age'] ?? '22',
                    type: state.uri.queryParameters['type'] == 'collabills'
                        ? BillTypeEnum.collabils
                        : BillTypeEnum.bills,
                  ),
                  routes: [
                    GoRoute(
                      path: ':billNo',
                      builder: (context, state) => BillDetailScreen(
                        billNo: state.pathParameters['billNo'] ?? '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: 'region',
          builder: (context, state) => const RegionScreen(),
        ),
        GoRoute(
          path: 'bills',
          builder: (context, state) => const BillListScreen(),
          routes: [
            GoRoute(
              path: ':billNo',
              builder: (context, state) => BillDetailScreen(
                billNo: state.pathParameters['billNo'] ?? '',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
