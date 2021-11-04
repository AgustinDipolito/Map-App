part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {
  final int minutos;

  MarkerInicioPainter(this.minutos);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = Colors.black;

    //circulos
    final double radioCirculo = 20;
    canvas.drawCircle(
      Offset(radioCirculo, size.height - radioCirculo),
      radioCirculo,
      paint,
    );

    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(radioCirculo, size.height - radioCirculo),
      radioCirculo / 2,
      paint,
    );

    //sombra
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    //cajas
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 60, 80);
    canvas.drawRect(cajaBlanca, paint);

    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //textos
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 36, fontWeight: FontWeight.w400),
      text: "$minutos",
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70,
      );
    textPainter.paint(canvas, Offset(40, 30));

    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: "Mins.",
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70,
      );

    textPainter.paint(canvas, Offset(40, 65));

    //ubicacion
    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
      text: "My location.",
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        maxWidth: size.width - 110,
      );

    textPainter.paint(canvas, Offset(115, 40));
  }
}
