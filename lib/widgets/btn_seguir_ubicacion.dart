part of "widgets.dart";

class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (_, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                mapaBloc.state.seguirUbicacion
                    ? Icons.gps_fixed
                    : Icons.gps_not_fixed,
                color: Colors.black,
              ),
              onPressed: () {
                mapaBloc.add(OnSeguirUbicacion());
                Fluttertoast.showToast(
                  msg: "Seguir: ${!mapaBloc.state.seguirUbicacion}",
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
