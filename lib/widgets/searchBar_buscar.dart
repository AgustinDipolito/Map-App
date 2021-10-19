part of "widgets.dart";

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual)
          return Container();
        else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context),
          );
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: GestureDetector(
          onTap: () async {
            final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(),
            );
            this.retornoBusqueda(resultado!, context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              "Buscar...",
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(SearchResult result, BuildContext context) {
    if (result.cancelo) return;

    if (!result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarManual());
      return;
    }
  }
}
