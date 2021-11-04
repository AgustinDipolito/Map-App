part of "helpers.dart";

void calculandoAlerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Please wait."),
            content: Text("Calculating route..."),
          ));
}
