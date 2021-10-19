part of "helpers.dart";

void calculandoAlerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Espere"),
            content: Text("Calculando ruta..."),
          ));
}
