import 'package:flutter/material.dart';
import '../data-source/detail_movie_model.dart';
import '../data-source/api_data_source.dart';

class DetailMoviePage extends StatefulWidget {
  final String id;
  final String judul;
  const DetailMoviePage({Key? key, required this.id, required this.judul})
      : super(key: key);

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.judul)),
          backgroundColor: Color(0xff27374D),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: FutureBuilder<DetailMovieModel>(
                future: ApiDatasource.instance.detailMovie(widget.id),
                builder: (BuildContext context,
                    AsyncSnapshot<DetailMovieModel> snapshot) {
                  if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                  if (snapshot.hasData) {
                    final movie = snapshot.data!;
                    return _buildMovie(movie);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }

  Widget _buildMovie(movieData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          movieData.poster,
          width: double.infinity,
          // height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16.0),
        Text(
          'Year: ${movieData.year}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Rated: ${movieData.rated}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Released: ${movieData.released}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Runtime: ${movieData.runtime}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Genre: ${movieData.genre}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Director: ${movieData.director}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Writer: ${movieData.writer}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Actors: ${movieData.actors}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Plot: ${movieData.plot}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Language: ${movieData.language}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Country: ${movieData.country}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Awards: ${movieData.awards}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Ratings:',
          style: TextStyle(fontSize: 18),
        ),
        Column(
          children: List.generate(
            movieData.ratings.length,
            (index) => ListTile(
              title: Text(
                movieData.ratings[index]["Source"],
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                movieData.ratings[index]["Value"],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Metascore: ${movieData.metascore}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'imdbRating: ${movieData.imdbRating}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'imdbVotes: ${movieData.imdbVotes}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Type: ${movieData.type}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'DVD: ${movieData.dvd}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'BoxOffice: ${movieData.boxOffice}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Production: ${movieData.production}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8.0),
        Text(
          'Website: ${movieData.website}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
