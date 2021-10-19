part of "widgets.dart";

class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({Key? key}) : super(key: key);

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
              color: Colors.white,
              icon: Icon(
                mapaBloc.state.dibujarRecorrido
                    ? Icons.more_horiz_sharp
                    : Icons.unfold_more_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                mapaBloc.add(OnMarcarRecorrido());
                Fluttertoast.showToast(
                  msg: "Recorrido: ${mapaBloc.state.dibujarRecorrido}",
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
