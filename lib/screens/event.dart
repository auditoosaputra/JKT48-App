import 'package:flutter/material.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/screens/event_detail.dart';
import 'package:jkt48_app/screens/home.dart';
import 'package:jkt48_app/screens/member_detail.dart';
import 'package:jkt48_app/utils/api_data_source.dart';

class EventPage extends StatefulWidget {
  // final List<Events>? events;
  final String? name;

  EventPage({this.name});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    List<Members> DataEvent;

    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              DataJKT48 event = DataJKT48.fromJson(snapshot.data);

              // if (DataEvent.isEmpty) {
              //   return _noDataFound();
              // }

              return Scaffold(
                body: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: event.events?.length ?? 0,
                  itemBuilder: (context, index) =>
                      _itemIW(event.events![index]),
                  // (BuildContext context, int index) {
                  //   final eventData = event.events?[index];
                  //   return InkWell(
                  //     onTap: () {
                  //       print('tes');
                  //       if (eventData != null) {
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => EventDetailPage(
                  //                 detail: eventData), // Remove [index]
                  //           ),
                  //         );
                  //       }
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.all(8.0),
                  //       child: Card(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         elevation: 5,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: [
                  //             Expanded(
                  //               flex: 3,
                  //               child: Container(
                  //                 child: eventData?.photoUrl != null
                  //                     ? Image.network(
                  //                         eventData!.photoUrl!,
                  //                         fit: BoxFit.cover,
                  //                       )
                  //                     : Container(
                  //                         color: Colors.grey,
                  //                       ),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               flex: 1,
                  //               child: Container(
                  //                 padding: EdgeInsets.all(8.0),
                  //                 alignment: Alignment.center,
                  //                 child: Text(
                  //                   eventData?.name ?? 'No Name',
                  //                   style: TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  //     },
                  //   );
                ),
              );
            }
            ;
            return Center(
              child: Text("No Data Available"),
            );
          }),
    );
  }

  Widget _itemIW(Events eventData) {
    return InkWell(
      onTap: () {
        print('tes');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              detail: eventData,
              name: widget.name,
            ), // Remove [index]
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
                  child: eventData?.photoUrl != null
                      ? Image.network(
                          eventData!.photoUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    eventData?.name ?? 'No Name',
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
  }
}
