part of "widgets.dart";

class BtnDialMenu extends StatelessWidget {
  const BtnDialMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.add),
      closedForegroundColor: Colors.black,
      openForegroundColor: Colors.white,
      closedBackgroundColor: Colors.white,
      openBackgroundColor: Colors.black,
      speedDialChildren: [
        SpeedDialChild(
          backgroundColor: Colors.white,
          label: "Location",
          child: BtnUbicacion(),
        ),
        SpeedDialChild(
          backgroundColor: Colors.white,
          label: "Follow",
          child: BtnSeguirUbicacion(),
        ),
        SpeedDialChild(
          backgroundColor: Colors.white,
          label: "Route",
          child: BtnMiRuta(),
        )
      ],
    );
  }
}
