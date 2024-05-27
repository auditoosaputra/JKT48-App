import 'package:flutter/material.dart';
import 'package:jkt48_app/screens/event_detail.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Event> events = [
      Event(
          name: "2Shot",
          photoUrl: "2shot_logo.jpg",
          venue: "Sleman City Hall",
          time: "10:00",
          price: "200000"),
      Event(
          name: "Meet and Greet",
          photoUrl: "mng_logo.jpg",
          venue: "Sleman City Hall",
          time: "16:00",
          price: "75000"),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final eventData = events[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailPage(detail: eventData),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Image.asset(
                                      eventData.photoUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      eventData.name ?? 'No Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String? name;
  final String? photoUrl;
  final String? price;
  final String? venue;
  final String? time;

  Event({this.name, this.photoUrl, this.price, this.time, this.venue});
}
