import 'package:flutter/material.dart';
import '../data-source/api_data_source.dart';
import '../data-source/movie_model.dart';
import 'detail_movie_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String search = '';

  int _currentIndex = 0;

  void _logout() async {
    // Navigate to LoginScreen
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.remove('loggedin');
    logindata.remove('username');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            textAlign: TextAlign.center,
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search movies',
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                color: Colors.white,
                icon: Icon(Icons.search),
                onPressed: () => setState(() {
                  search = searchController.text;
                }),
              ),
            ),
            onSubmitted: (value) => setState(() {
              search = value;
            }),
          ),
        ),
        backgroundColor: Color(0xff000000),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xff27374D),
            child: Text(
              "Movie List",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                color: Color(0xff27374D),
                child: FutureBuilder<List<MovieModel>>(
                  future: search.isEmpty
                      ? ApiDatasource.instance.fetchMovies()
                      : ApiDatasource.instance.searchMovies(search),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MovieModel>> snapshot) {
                    if (snapshot.hasError) return _noMovies();
                    if (snapshot.hasData) {
                      final movies = snapshot.data!;
                      return _buildMovies(movies);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
          )
        ],
      ),
      backgroundColor: Color(0xff27374D),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xff27374D),
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (index == 1) {
              Navigator.pushReplacementNamed(context, '/profile');
            }
            if (index == 2) {
              _logout();
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _buildMovies(movies) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailMoviePage(id: movie.imdbID, judul: movie.title),
                ));
          },
          child: Stack(
            children: [
              movie.poster != 'N/A'
                  ? Image.network(
                      movie.poster,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
              Container(
                height: 300,
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
                        width: 200,
                        child: Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          movie.year,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
      },
    );
  }

  Widget _noMovies() {
    return Text('No Movies Found for $search');
  }
}
