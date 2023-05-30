import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home_page.dart';
import '../authentication/auth.dart';
import '../authentication/encrypt_md5.dart';
import 'regis_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool loggedIn;

  @override
  void initState() {
    super.initState();
    alreadyLoggedIn();
  }

  void alreadyLoggedIn() async {
    logindata = await SharedPreferences.getInstance();
    loggedIn = (logindata.getBool('loggedin') ?? false);
    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String encryptedPass = encryptText(password);

    bool success =
        await Auth.loginUser(username: username, password: encryptedPass);

    if (success) {
      logindata.setBool('loggedin', true);
      logindata.setString('username', usernameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text('Login Page'),
          )),
      body: Container(
        color: Color(0xff27374D),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      height: 60,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: usernameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff27374D),
                          ),
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      height: 60,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff27374D),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                            textStyle: const TextStyle(fontSize: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: _login,
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "doesn't have an Account ?",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RegisPage()),
                        );
                      },
                      child: Text(
                        "Regis here",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
