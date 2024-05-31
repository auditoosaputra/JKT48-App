import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jkt48_app/screens/home.dart';

class EventDetailPage extends StatefulWidget {
  final Events detail;
  final String? name;

  const EventDetailPage({Key? key, required this.detail, this.name})
      : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  void _saveEventAndNavigate() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userBox = await Hive.openBox<User>("userBox");
      int? accIndex = pref.getInt("accIndex");

      if (accIndex == null) {
        throw Exception("User index not found in SharedPreferences");
      }

      User? currentUser = userBox.getAt(accIndex);

      if (currentUser == null) {
        throw Exception("User not found in Hive box");
      }

      var eventHistory = Events(
          name: widget.detail.name,
          time: widget.detail.time,
          price: widget.detail.price,
          nama: widget.name);

      currentUser.eventHistory.add(eventHistory);
      await currentUser.save();

      await userBox.close();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      print("Error saving event and navigating: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.network(
              widget.detail.photoUrl!,
            )),
            SizedBox(height: 16),
            Center(
              child: Text(
                '${widget.detail.name ?? ''}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Venue : ${widget.detail.venue ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Time : ${widget.detail.time ?? 'N/A'} WIB',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Price : Rp ${widget.detail.price ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            if (widget.name != null)
              SizedBox(height: 8),
            if (widget.name != null)
              Text(
                'Member : ${widget.name}',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            if (widget.name != null)
              Center(
                child: ElevatedButton(
                  onPressed: _saveEventAndNavigate,
                  child: Text(
                    "Buy",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
