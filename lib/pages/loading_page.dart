import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/widgets/widgets.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${snapshot.data}"),
                  MaterialButton(
                    child: Text(
                      "Refrescar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    shape: StadiumBorder(),
                    splashColor: Colors.white,
                    elevation: 0,
                    onPressed: () => this.checkGpsYLocation(context),
                  )
                ],
              ),
            );
          } else {
            return ColEspera(texto: "Un momento");
          }
        },
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    //permiso Gps
    final permisoGps = await Permission.location.isGranted;
    //gps activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (gpsActivo && permisoGps) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
      return "";
    }
    //sin permiso
    else if (!permisoGps) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return "Es necesario el permiso de GPS";
    }
    //gps desactivado
    else
      return "Active el GPS";
  }
}
