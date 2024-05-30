import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:jkt48_app/model/user.dart';
import 'package:jkt48_app/screens/home.dart';
import 'package:jkt48_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromUtf8("1234567890123456");

  late SharedPreferences pref;

  String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  void printDatabaseContents() async {
    var userBox = await Hive.openBox<User>("userBox");
    print("Database Contents:");
    for (var user in userBox.values) {
      print("Username: ${user.username}, Password: ${user.password}");
    }
    await userBox.close();
  }

  void registerUser() async {
    var userBox = await Hive.openBox<User>("userBox");
    pref = await SharedPreferences.getInstance();

    // Check if the username already exists
    bool userFound =
        userBox.values.any((user) => user.username == usernameController.text);

    if (userFound) {
      print("Username already exists");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username is already taken"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } else {
      var encryptedPassword = encryptData(passwordController.text);

      var user = User(
        username: usernameController.text,
        password: encryptedPassword,
        eventHistory: [],
      );

      await userBox.add(user);

      // Set the accIndex based on the count of users in the Hive box
      int userCount = userBox.length;
      await pref.setInt("accIndex", userCount - 1);
      await pref.setBool("logedIn", true);

      printDatabaseContents(); // Call the function here

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
      print("User registered successfully");
    }

    await userBox.close();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Please register to create an account ",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              labelText: "Username",
                              prefixIcon: Icon(Icons.person)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please insert an username";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock)),
                          validator: (value) {
                            if (value!.length < 8) {
                              return "Password must contain more than 8 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                              },
                              child: const Text(
                                "Already have an account? Login here",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  String username = usernameController.text;
                                  String password = passwordController.text;
                                  if (username != "" && password != "") {
                                    registerUser();
                                  }
                                }
                              },
                              icon: const Icon(Icons.app_registration,
                                  color: Colors.white),
                              label: const Text('Register',
                                  style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width - 100,
          child: Image.asset(
            'JKT48_logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ]),
    );
  }
}
