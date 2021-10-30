part of 'custom_markers.dart';

class MarkerDestinoPainter extends CustomPainter {
  final double metros;
  final String descripcion;

  MarkerDestinoPainter(this.metros, this.descripcion);
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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    //cajas
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //textos
    double kilometros = this.metros / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
      text: "$kilometros",
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70,
      );
    textPainter.paint(canvas, Offset(5, 35));

    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: "Km.",
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 70);

    textPainter.paint(canvas, Offset(10, 65));

    //ubicacion
    textSpan = new TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
      text: this.descripcion,
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: "...",
    )..layout(maxWidth: size.width - 100);

    textPainter.paint(canvas, Offset(90, 35));
  }
}
