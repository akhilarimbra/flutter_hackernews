import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/Item.dart';
import '../resources/Repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  final _repository = Repository();

  // Streams getters
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sink getters
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() =>
      ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
          cache[id] = _repository.fetchItem(id);
          cache[id].then((ItemModel item) {
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
          });
          return cache;
        },
        <int, Future<ItemModel>>{},
      );

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
