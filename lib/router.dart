import 'package:go_router/go_router.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/bill_detail_screen.dart';
import 'package:vote_player_app/features/candidates/detail/candidate_detail_screen.dart';
import 'package:vote_player_app/features/candidates/list/candidates_screen.dart';
import 'package:vote_player_app/features/main_navigation/main_navigation_screen.dart';

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
                    type: state.uri.queryParameters['type'] == 'collabills'
                        ? BillTypeEnum.collabils
                        : BillTypeEnum.bills,
                  ),
                  routes: [
                    GoRoute(
                      path: ':billNo',
                      builder: (context, state) => BillDetailScreen(
                        candidateId: state.pathParameters['id']!,
                        billNo: state.pathParameters['billNo']!,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
