import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  bool isPopup = false;

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
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && !isPopup) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, "loading");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Require GPS for this app."),
          MaterialButton(
            child: Text(
              "Give access.",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
            shape: StadiumBorder(),
            splashColor: Colors.white,
            elevation: 0,
            onPressed: () async {
              isPopup = true;
              final status = await Permission.location.request();
              await this.accesoGps(status);
              isPopup = false;
            },
          )
        ],
      )),
    );
  }

  Future accesoGps(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, "loading");
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
