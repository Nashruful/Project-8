import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperExample extends StatefulWidget {
  @override
  _SwiperExampleState createState() => _SwiperExampleState();
}

class _SwiperExampleState extends State<SwiperExample> {
  final List<String> titles = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Jackfruit',
    'Kiwi',
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter the list based on the search query
    final filteredTitles = titles.where((title) => title.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Swiper with Search')),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Swiper
          Expanded(
            child: Swiper(
              itemCount: filteredTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Center(
                    child: Text(
                      filteredTitles[index],
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SwiperExample()));
}
