import 'package:flutter/material.dart';
import 'package:my_tmdb/models/item_model.dart';
import 'package:my_tmdb/blocs/movies_bloc.dart';
import 'package:my_tmdb/ui/movie_detail.dart';
import 'package:my_tmdb/blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
              fit: BoxFit.cover,
            ),
            onTap: () => openDetailPage(snapshot.data, index),
          ),
        );
      },
    );
  }

  void openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovieDetailBlocProvider(
            child: MovieDetail(
              title: data.results[index].title,
              posterUrl: data.results[index].backdrop_path,
              description: data.results[index].overview,
              releaseDate: data.results[index].release_date,
              voteAverage: data.results[index].vote_average.toString(),
              movieId: data.results[index].id,
            ),
          );
        },
      ),
    );
  }
}

// class MovieList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // not good
//     bloc.fetchAllMovies();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Popular Movies'),
//       ),
//       body: StreamBuilder(
//         stream: bloc.allMovies,
//         builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
//           if (snapshot.hasData) {
//             return buildList(snapshot);
//           } else if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
//     return GridView.builder(
//       itemCount: snapshot.data.results.length,
//       gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//       itemBuilder: (BuildContext context, int index) {
//         return Image.network(
//           'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
//           fit: BoxFit.cover,
//         );
//       },
//     );
//   }
// }
