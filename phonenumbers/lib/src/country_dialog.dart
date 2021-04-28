import 'package:flutter/material.dart';
import 'package:phonenumbers_core/core.dart';
import 'package:phonenumbers_core/data.dart';

/// Country selection dialog UI implementation.
class CountryDialog extends StatelessWidget {
  const CountryDialog({Key? key, required this.title}) : super(key: key);

  static Route<Country> route({required String title}) {
    return MaterialPageRoute(
      builder: (context) => CountryDialog(title: title),
      settings: RouteSettings(name: '/area-code-dialog'),
    );
  }

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => onSearch(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          final previousCountryInitial =
              index > 0 ? countries[index - 1].name[0] : null;

          return _buildListTile(
            context,
            theme,
            country,
            leading: previousCountryInitial == country.name[0]
                ? null
                : Text(country.name[0]),
            showLeading: true,
          );
        },
      ),
    );
  }

  void onSearch(BuildContext context) {
    showSearch(context: context, delegate: _CountrySearchDelegate());
  }
}

Widget _buildListTile(
  BuildContext context,
  ThemeData theme,
  Country country, {
  Widget? leading,
  bool showLeading = false,
  VoidCallback? onTap,
}) {
  return ListTile(
    onTap: onTap ?? () => Navigator.pop(context, country),
    title: Text(country.name),
    trailing: Text(
      '+${country.prefix}',
      style: theme.textTheme.bodyText1!.copyWith(color: theme.accentColor),
    ),
    leading: leading != null || showLeading
        ? DefaultTextStyle(
            style: theme.textTheme.headline6!,
            child: Opacity(
              opacity: 0.5,
              child: leading,
            ),
          )
        : null,
  );
}

class _CountrySearchDelegate extends SearchDelegate<Country> {
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) => [];

  @override
  Widget buildLeading(BuildContext context) => SizedBox();

  @override
  Widget buildResults(BuildContext context) {
    final theme = Theme.of(context);
    final filteredCountries =
        countries.where((c) => _matches(query, c)).toList();

    return ListView.builder(
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) => _buildListTile(
        context,
        theme,
        filteredCountries[index],
        onTap: () {
          final country = filteredCountries[index];
          Navigator.of(context)..pop()..pop(country);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) =>
      query.isNotEmpty ? buildResults(context) : SizedBox();
}

bool _matches(String query, Country country) {
  query = query.toUpperCase();

  if (country.prefix.toString().contains(query)) {
    return true;
  }

  if (query == country.code.toUpperCase()) {
    return true;
  }

  if (country.name.toUpperCase().contains(query)) {
    return true;
  }

  return false;
}
