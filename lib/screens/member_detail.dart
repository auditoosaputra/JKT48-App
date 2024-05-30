import 'package:flutter/material.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/screens/event.dart';
import 'package:jkt48_app/screens/event_detail.dart';
import 'package:jkt48_app/screens/home.dart';

class DetailMemberPage extends StatefulWidget {
  final Members detail;

  const DetailMemberPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailMemberPage> createState() => _DetailMemberPageState();
}

class _DetailMemberPageState extends State<DetailMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Detail'),
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
            if (widget.detail.photoUrl != null)
              Center(
                child: Image.network(
                  widget.detail.photoUrl!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
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
              'Panggilan: ${widget.detail.nickname ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tanggal Lahir: ${widget.detail.dateOfBirth ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Horoskop: ${widget.detail.horoscope ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tinggi Badan: ${widget.detail.bodyHeight ?? ''}',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Golongan Darah: ${widget.detail.bloodType ?? ''}',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print(widget.detail.name!);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventPage(name: widget.detail.name),
                    ),
                  );
                },
                child: Text(
                  "Buy Ticket Event",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
