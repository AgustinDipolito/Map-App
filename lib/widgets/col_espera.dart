part of 'widgets.dart';

class ColEspera extends StatelessWidget {
  final texto;

  const ColEspera({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: double.infinity, height: 3),
        Text("$texto"),
      ],
    );
  }
}
