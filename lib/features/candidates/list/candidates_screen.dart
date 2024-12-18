import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vote_player_app/constants/sizes.dart';

import 'package:vote_player_app/features/candidates/list/widgets/search_input.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/keyboard.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidatesScreen extends StatefulWidget {
  static String routeName = '/candidates';
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  String _searchQuery = '';
  late int totalCount;
  CandidatesSummary? summary;

  final _scrollController = ScrollController();

  void _onListTileTap({
    required String id,
  }) {
    hideKeyboard(context);
    context.push('/candidates/$id');
  }

  dynamic _onInputChanged(String? text) async {
    EasyDebounce.debounce('candidatesSearch', const Duration(milliseconds: 400),
        () async {
      setState(() {
        _searchQuery = text ?? '';
      });
    });
  }

  void _onScroll() {
    final query = getCandidatesInfiniteQuery(koName: _searchQuery);
    if (_isBottom && query.state.status != QueryStatus.loading) {
      query.getNextPage();
    }
  }

// 최하단 판별
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
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
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: InfiniteQueryBuilder<CandidatesResponse, int>(
          query: getCandidatesInfiniteQuery(koName: _searchQuery),
          builder: (context, state, query) {
            final allPosts = state.data;
            return RefreshIndicator(
              edgeOffset: 110,
              onRefresh: () => Future.sync(
                () =>
                    getCandidatesInfiniteQuery(koName: _searchQuery).refetch(),
              ),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  if (state.status == QueryStatus.error)
                    SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor,
                        ),
                        child: Text(
                          state.error is SocketException
                              ? "No internet connection"
                              : state.error.toString(),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  if (allPosts != null) ...[
                    SliverAppBar(
                      elevation: 1,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                        ),
                        child: CandidateSearchInput(
                          placeholder: "이름",
                          onChanged: _onInputChanged,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          '${allPosts[0].summary.total}개의 결과',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          var list = allPosts[i];
                          return Column(
                            children: [
                              ...list.result.map((item) {
                                final imagePath = getS3ImageUrl(
                                  BucketCategory.candidates,
                                  '${item.enName}.png',
                                );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size10,
                                  ),
                                  child: ListTile(
                                    onTap: () => _onListTileTap(
                                      id: item.id,
                                    ),
                                    leading: Hero(
                                      tag: item.id,
                                      child: CircleAvatar(
                                        foregroundImage:
                                            NetworkImage(imagePath),
                                      ),
                                    ),
                                    title: Text(
                                      item.koName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item.electoralDistrict,
                                    ),
                                    trailing: const Icon(
                                      Icons.chevron_right_sharp,
                                      size: Sizes.size32,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                        childCount: allPosts.length,
                      ),
                    ),
                  ],
                  if (state.status == QueryStatus.loading)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
