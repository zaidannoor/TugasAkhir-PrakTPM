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
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
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
        Stack(
          children: [
            movieData.poster != 'N/A' ?
            Image.network(
              movieData.poster,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ) : Container(width: double.infinity,
            height: 400,color: Colors.grey,),
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ])),
            ),
            Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        '${movieData.title}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                        ),
                        Container(
                          width: 30,
                          child: Text(
                            '${movieData.imdbRating}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Text(
                              '${movieData.rated}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
        SizedBox(height: 10), //release date
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Release date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(
              Icons.calendar_month_rounded,
              size: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '${movieData.released}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            )
          ],
        ),
        SizedBox(height: 12), //genre
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Genre',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              '${movieData.genre}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            )
          ],
        ),
        SizedBox(height: 12), //plot
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Plot',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 400,
              child: Text(
                '${movieData.plot}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //runtime
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Running Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(Icons.timer_rounded),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 60,
              child: Text(
                '${movieData.runtime}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //director
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Director',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(Icons.person),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 200,
              child: Text(
                '${movieData.director}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //Writer
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Writter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(Icons.person),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 200,
              child: Text(
                '${movieData.writer}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //actor
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Actors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(Icons.group),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 350,
              child: Text(
                '${movieData.actors}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //awards
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Awards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 350,
              child: Text(
                '${movieData.awards}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12), //country
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Country',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Icon(Icons.flag),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 350,
              child: Text(
                '${movieData.country}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'Metascore\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.metascore}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'Imdb Votes\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.imdbVotes}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'DVD\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.dvd}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'Box Office\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.boxOffice}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'Production\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.production}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              width: 13,
            ),
            Container(
              width: 100,
              child: Text(
                'Website\t\t:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${movieData.website}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ],
    );
  }
}
