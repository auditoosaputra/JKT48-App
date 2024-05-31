import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/model/user.dart';
import 'package:jkt48_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

late SharedPreferences pref;

class _ProfilePageState extends State<ProfilePage> {
  String? username = "";
  String? password = "";
  String _selectedCurrency = 'IDR';
  String _selectedTime = 'WIB';
  List<Events> eventHistory = [];
  File? _image;

  final ImagePicker _picker = ImagePicker();

  void loadAccInfo() async {
    pref = await SharedPreferences.getInstance();
    var userBox = await Hive.openBox<User>("userBox");

    int accIndex = pref.getInt("accIndex")!;

    setState(() {
      username = userBox.getAt(accIndex)!.username;
      eventHistory = userBox.getAt(accIndex)!.eventHistory;
    });

    await userBox.close();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadAccInfo();
  }

  String _convertTime(String selectedTime, String eventTime) {
    DateTime eventDateTime = DateTime.parse('1970-01-01 $eventTime:00');
    DateTime convertedTime;

    switch (selectedTime) {
      case 'UTC':
        convertedTime =
            eventDateTime.subtract(Duration(hours: 7)); // WIB to UTC
        return '${convertedTime.hour.toString().padLeft(2, '0')}:${convertedTime.minute.toString().padLeft(2, '0')} UTC';
      case 'WITA':
        convertedTime = eventDateTime.add(Duration(hours: 1)); // WIB to WITA
        return '${convertedTime.hour.toString().padLeft(2, '0')}:${convertedTime.minute.toString().padLeft(2, '0')} WITA';
      case 'WIT':
        convertedTime = eventDateTime.add(Duration(hours: 2)); // WIB to WIT
        return '${convertedTime.hour.toString().padLeft(2, '0')}:${convertedTime.minute.toString().padLeft(2, '0')} WIT';
      case 'WIB':
      default:
        return '$eventTime WIB';
    }
  }

  double _convertCurrency(double price, String selectedCurrency) {
    switch (selectedCurrency) {
      // Rate per 31 mei
      case 'USD':
        return price / 16250;
      case 'YEN':
        return price / 104;
      case 'IDR':
      default:
        return price;
    }
  }

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
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.add_a_photo, color: Colors.grey)
                          : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$username',
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
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Username',
                              style: TextStyle(color: Colors.black)),
                          Text('$username',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.mail, color: Colors.black),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password',
                              style: TextStyle(color: Colors.black)),
                          Text('********',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('Settings',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Currency', style: TextStyle(color: Colors.black)),
                      Spacer(),
                      Container(
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
                            items: <String>['IDR', 'USD', 'YEN']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              );
                            }).toList(),
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Time', style: TextStyle(color: Colors.black)),
                      Spacer(),
                      Container(
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
                            items: <String>['WIB', 'WITA', 'WIT', 'UTC']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              );
                            }).toList(),
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('History',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Event',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: eventHistory.map((event) {
                  double price = double.parse(event.price!);
                  double convertedPrice =
                      _convertCurrency(price, _selectedCurrency);
                  String currencySymbol;
                  switch (_selectedCurrency) {
                    case 'USD':
                      currencySymbol = '\$';
                      break;
                    case 'YEN':
                      currencySymbol = '¥';
                      break;
                    case 'IDR':
                    default:
                      currencySymbol = 'Rp';
                      break;
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Text(event.nama!),
                      ),
                      Expanded(
                        child: Text('${event.name}'),
                      ),
                      Expanded(
                        child:
                            Text(_convertTime(_selectedTime, '${event.time}')),
                      ),
                      Expanded(
                        child: Text(
                            '$currencySymbol ${convertedPrice.toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {
                    pref.remove("logedIn");
                    pref.remove("accIndex");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  label: Text('Log Out', style: TextStyle(color: Colors.white)),
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
