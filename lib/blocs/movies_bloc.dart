import 'package:rxdart/rxdart.dart';
import 'package:my_tmdb/resources/repository.dart';
import 'package:my_tmdb/models/item_model.dart';

class MoviesBloc {
  final Repository _repository = Repository();
  final PublishSubject<ItemModel> _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  void fetchAllMovies() async {
    ItemModel _itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(_itemModel);
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

final MoviesBloc bloc = MoviesBloc();
