import 'package:flutter/material.dart';
import 'package:jkt48_app/screens/member.dart';
import 'package:jkt48_app/screens/event.dart';
import 'package:jkt48_app/screens/notification.dart';
import 'package:jkt48_app/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<String> _appBarTitles = <String>[
    'Member',
    'Event',
    'Notification',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Expanded(
              child: Text(
                _appBarTitles[_selectedIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_selectedIndex == 0) // Only show search bar on the 'Member' tab
              SizedBox(
                width: 200, // Set the width of the search bar
                height: 36, // Set the height of the search bar
                child: TextField(
                  controller: _searchController,
                  onChanged: _updateSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
          ],
        ),
        actions: [],
      ),
      body: _widgetOptions[_selectedIndex](searchQuery: _searchQuery),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Member'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }

  List<Widget Function({required String searchQuery})> get _widgetOptions {
    return <Widget Function({required String searchQuery})>[
      ({required String searchQuery}) => MemberPage(searchQuery: searchQuery),
      ({required String searchQuery}) => EventPage(),
      ({required String searchQuery}) => NotificationPage(),
      ({required String searchQuery}) => ProfilePage(),
    ];
  }
}
