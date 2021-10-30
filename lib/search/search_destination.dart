import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/search_response.dart';
import 'package:mapas_app/models/search_results.dart';
import 'package:mapas_app/services/traffic_service.dart';
import 'package:mapas_app/widgets/widgets.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult>? historial;
  SearchDestination(this.proximidad, this.historial)
      : this.searchFieldLabel = "Buscar...",
        this._trafficService = new TrafficService();

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
    return this._construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResult = SearchResult(cancelo: false, manual: true);

    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Ingresar ubicacion manualmente"),
            onTap: () {
              this.close(context, searchResult);
            },
          ),
          ...this
              .historial!
              .map(
                (result) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(result.nombreDestino!),
                  onTap: () {
                    this.close(context, result);
                  },
                ),
              )
              .toList(),
        ],
      );
    }
    return this._construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    if (this.query == "") {
      return Container();
    }
    this._trafficService.getSugerenciasPorQuery(this.query.trim(), proximidad);

    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return ColEspera(texto: "Buscando...");
        }

        final lugares = snapshot.data!.features;

        if (lugares.isEmpty && this.query.isNotEmpty) {
          return ListTile(
            title: Text("No se encontraron lugares llamados ${this.query}"),
          );
        }
        return ListView.separated(
          separatorBuilder: (_, i) => Divider(),
          itemCount: lugares.length,
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs!),
              subtitle: Text(lugar.placeNameEs!),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                    cancelo: false,
                    manual: false,
                    position: LatLng(lugar.center![1], lugar.center![0]),
                    nombreDestino: lugar.textEs,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
