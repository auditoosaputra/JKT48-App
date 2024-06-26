import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:jkt48_app/model/user.dart';
import 'package:jkt48_app/screens/home.dart';
import 'package:jkt48_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences pref;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromUtf8("1234567890123456");

  // Function to check user input for login
  void checkInputForLogin() async {
    var userBox = await Hive.openBox<User>("userBox");
    bool userFound = false; // Flag to track if credentials match

    // Iterate over the userBox to find matching username and decrypted password
    for (int i = 0; i < userBox.length; i++) {
      if (userBox.getAt(i)!.username == usernameController.text &&
          decryptData(userBox.getAt(i)!.password) == passwordController.text) {
        userFound = true; // Set flag to true if credentials match
        pref = await SharedPreferences.getInstance();
        pref.setBool("logedIn", true); // Set session logged in status
        pref.setInt("accIndex", i); // Store account index in SharedPreferences
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break; // Exit the loop since credentials are found and valid
      }
    }

    if (!userFound) {
      // Show the Snackbar if no credentials matched
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username or Password is Wrong"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    }

    await userBox.close(); // Close the Hive box
  }

  // Function to clear the userBox (for testing or reset purposes)
  void clearUserBox() async {
    var userBox = await Hive.openBox<User>("userBox");
    await userBox.clear();
    await userBox.close();
    print("All data in the userBox has been cleared.");
  }

  // Function to decrypt the password
  String decryptData(String encryptText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decrypted = encrypter.decrypt64(encryptText, iv: iv); // Decrypt data using the same IV and key

    return decrypted; // Return the decrypted text
  }

  // Function to check if user is already logged in
  void checkIfLogedIn() async {
    pref = await SharedPreferences.getInstance();

    bool logedIn = pref.getBool("logedIn") ?? false; // Check the login status from SharedPreferences

    if (logedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfLogedIn(); // Check if user is already logged in when initializing
    // clearUserBox(); // Uncomment to clear userBox (useful for testing)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
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
                      "Login",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Please sign in to continue",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Form(
                  key: _formKey,
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
                          if (value == null || value.isEmpty) {
                            return "Please insert the password";
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
                                return const RegisterPage();
                              }));
                            },
                            child: const Text(
                              "You don't have an account?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                checkInputForLogin(); // Call login check function
                              }
                            },
                            icon: Icon(Icons.login, color: Colors.white),
                            label: Text('Login',
                                style: TextStyle(color: Colors.white)),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
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
        Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width - 100,
          child: Image.asset(
            'assets/JKT48_logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ]),
    );
  }
}
