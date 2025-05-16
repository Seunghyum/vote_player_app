import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:vote_player_app/features/candidates/models/candidate_model.dart';
import 'package:vote_player_app/features/candidates/services/candidates_service.dart';

class CandidatesRepo {
  final _service = CandidatesService();

  Query<Candidate> getCandidateByIdQuery({
    required String id,
  }) {
    return Query<Candidate>(
      key: 'candidate-$id',
      queryFn: () => _service.getCandidateById(id),
    );
  }

  InfiniteQuery<CandidatesResponse, int> getCandidatesInfiniteQuery({
    String? koName,
    int? page,
  }) {
    return InfiniteQuery<CandidatesResponse, int>(
      key: 'candidates-$koName',
      getNextArg: (state) {
        if (state.lastPage?.summary.isLastPage ?? false) return null;
        return state.length + 1;
      },
      initialData: [],
      queryFn: (arg) =>
          _service.getCandidates(page: page ?? arg, koName: koName),
    );
  }
}
