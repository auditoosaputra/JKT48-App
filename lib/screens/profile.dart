import 'package:flutter/material.dart';
import 'package:jkt48_app/screens/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedCurrency = 'IDR';
  String _selectedTime = 'WIB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://example.com/user.jpg'),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('username',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 10),
                          SizedBox(width: 5),
                          Text('Online', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('About Me',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text('username', style: TextStyle(color: Colors.black)),
                subtitle:
                    Text('Username', style: TextStyle(color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(Icons.mail, color: Colors.black),
                title: Text('password', style: TextStyle(color: Colors.black)),
                subtitle:
                    Text('password', style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              Text('Settings',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.language, color: Colors.black),
                title: Text('Currency', style: TextStyle(color: Colors.black)),
                trailing: Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCurrency = newValue!;
                        });
                      },
                      items: <String>['IDR', 'USD', 'EUR']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        );
                      }).toList(),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.access_time, color: Colors.black),
                title: Text('Time', style: TextStyle(color: Colors.black)),
                trailing: Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedTime,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTime = newValue!;
                        });
                      },
                      items: <String>['WIB', 'WITA', 'WIT']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        );
                      }).toList(),
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text('History',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  label:
                      Text('Sign Out', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
