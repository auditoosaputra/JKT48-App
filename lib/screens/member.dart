import 'package:flutter/material.dart';
import 'package:jkt48_app/model/member_model.dart';
import 'package:jkt48_app/screens/member_detail.dart';
import 'package:jkt48_app/utils/api_data_source.dart';

class MemberPage extends StatelessWidget {
  final String searchQuery;

  MemberPage({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    List<Members> filteredMembers;

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
            DataJKT48 member = DataJKT48.fromJson(snapshot.data);
            filteredMembers = member.members!.where((m) {
              return m.name!.toLowerCase().contains(searchQuery.toLowerCase());
            }).toList();

            if (filteredMembers.isEmpty) {
              return _noDataFound();
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredMembers?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final memberData = filteredMembers![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailMemberPage(detail: filteredMembers![index]),
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
                              child: memberData?.photoUrl != null
                                  ? Image.network(
                                      memberData!.photoUrl!,
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
                                memberData?.name ?? 'No Name',
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
            );
          }
          return Center(
            child: Text("No Data Available"),
          );
        },
      ),
    );
  }

  Widget _noDataFound() {
    return Center(
      child: Text("No Data Available"),
    );
  }
}
