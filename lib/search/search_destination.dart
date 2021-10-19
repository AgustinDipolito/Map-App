import 'package:flutter/material.dart';
import 'package:mapas_app/models/search_results.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  SearchDestination() : this.searchFieldLabel = "Buscar...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clean_hands),
        onPressed: () => this.query = " ",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = SearchResult(cancelo: true);
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.close(
              context,
              searchResult,
            ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("resultados");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResult = SearchResult(cancelo: false);

    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Ubicacion manual"),
          onTap: () {
            this.close(context, searchResult);
          },
        )
      ],
    );
  }
}
