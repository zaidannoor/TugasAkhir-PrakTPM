import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

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
        backgroundColor: Colors.black,
        title: Center(child: Text("Profile"),)
        
      ),
      body: Container(
        color: Color(0xff27374D),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'images/foto.jpeg',
                    width: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(width: 200,
                    child: Text(
                      "Zaidan Noor Irfan",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "123200066",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'images/fotor.jpeg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(width: 200,
                    child: Text(
                      "Muhammad Mi'raj Rizky",textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "123200080",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
}
