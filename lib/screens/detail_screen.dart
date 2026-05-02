import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_api_service.dart';

class DetailScreen extends StatefulWidget {
  final String code;
  const DetailScreen({super.key, required this.code});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final api = CountryApiService();
  late Future<Country> country;

  @override
  void initState() {
    super.initState();
    country = api.fetchByCode(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country Details')),
      body: FutureBuilder<Country>(
        future: country,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        country = api.fetchByCode(widget.code);
                      });
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          final c = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(c.flag, style: const TextStyle(fontSize: 80)),
                        const SizedBox(height: 10),
                        Text(
                          c.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          Icons.location_city,
                          "Capital",
                          c.capital,
                        ),
                        _buildDetailRow(Icons.public, "Region", c.region),
                        _buildDetailRow(
                          Icons.people,
                          "Population",
                          c.population.toString(),
                        ),
                        _buildDetailRow(
                          Icons.aspect_ratio,
                          "Area",
                          "${c.area} km²",
                        ),
                        _buildDetailRow(
                          Icons.payments,
                          "Currencies",
                          c.currencies,
                        ),
                        _buildDetailRow(
                          Icons.translate,
                          "Languages",
                          c.languages,
                        ),
                        _buildDetailRow(
                          Icons.schedule,
                          "Time Zones",
                          c.timezones.join(", "),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //if satatements for the app
  Widget _buildDetailRow(IconData icon, String label, String value) {
    // Logic to avoid displaying "N/A" or empty values
    if (value == "N/A" || value.isEmpty || value == "0" || value == "0.0 km²") {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
