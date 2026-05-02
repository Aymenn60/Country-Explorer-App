import 'dart:async';
import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_api_service.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final api = CountryApiService();

  List<Country> results = [];
  bool loading = false;
  String error = '';

  Timer? debounce;

  void search(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        setState(() {
          results = [];
        });
        return;
      }

      setState(() {
        loading = true;
        error = '';
      });

      try {
        final data = await api.searchByName(query);

        if (mounted) {
          setState(() {
            results = data;
            loading = false;
          });
        }
      } catch (e) {
        setState(() {
          error = e.toString();
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Country")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search country...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: search,
            ),
          ),

          if (loading) CircularProgressIndicator(),

          if (error.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(error, style: TextStyle(color: Colors.red)),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final country = results[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Text(country.flag, style: TextStyle(fontSize: 25)),
                    title: Text(country.name),
                    subtitle: Text(country.region),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailScreen(code: country.alpha3Code),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
