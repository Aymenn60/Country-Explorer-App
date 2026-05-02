class Country {
  final String name;
  final String flag;
  final String region;
  final String capital;
  final int population;
  final String alpha3Code;
  final double area;
  final List<String> timezones;
  final String currencies;
  final String languages;
//country
  Country({
    required this.name,
    required this.flag,
    required this.region,
    required this.capital,
    required this.population,
    required this.alpha3Code,
    required this.area,
    required this.timezones,
    required this.currencies,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // Parse Currencies
    String currencyString = 'N/A';
    if (json['currencies'] != null) {
      var currencyMap = json['currencies'] as Map<String, dynamic>;
      currencyString = currencyMap.values
          .map((c) => "${c['name']} (${c['symbol']})")
          .join(", ");
    }

    // Parse Languages
    String languageString = 'N/A';
    if (json['languages'] != null) {
      var langMap = json['languages'] as Map<String, dynamic>;
      languageString = langMap.values.join(", ");
    }

    return Country(
      name: json['name']['common'] ?? 'Unknown',
      flag: json['flag'] ?? '',
      region: json['region'] ?? 'N/A',
      capital: (json['capital'] != null && (json['capital'] as List).isNotEmpty)
          ? (json['capital'] as List).first
          : 'N/A',
      population: json['population'] ?? 0,
      alpha3Code: json['cca3'] ?? '',
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      timezones: List<String>.from(json['timezones'] ?? []),
      currencies: currencyString,
      languages: languageString,
    );
  }
}
