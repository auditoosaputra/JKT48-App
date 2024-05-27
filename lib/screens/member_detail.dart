import 'package:flutter/material.dart';
import 'package:jkt48_app/model/jkt48_model.dart';

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
        backgroundColor: Colors.red,
        title: Text(
          widget.detail.name ?? 'Member Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 16.0),
              Text('Name: ${widget.detail.name ?? ''}'),
              Text('Panggilan: ${widget.detail.nickname ?? 'N/A'}'),
              Text('Tanggal Lahir: ${widget.detail.dateOfBirth ?? 'N/A'}'),
              Text('Horoskop: ${widget.detail.horoscope ?? 'N/A'}'),
              Text('Tinggi Badan: ${widget.detail.bodyHeight ?? ''}'),
              Text('Golongan Darah: ${widget.detail.bloodType ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
