import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  // ✅ Ancho y alto de pantalla
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // ✅ Escalar textos automáticamente
  double scaleText(double size) {
    if (width >= 1200) {
      return size * 1.5; // Escritorio
    } else if (width >= 600) {
      return size * 1.2; // Tablet
    } else {
      return size; // Celular
    }
  }

  // ✅ Escalar elementos automáticamente
  double scale(double value) {
    if (width >= 1200) {
      return value * 1.5;
    } else if (width >= 600) {
      return value * 1.2;
    } else {
      return value;
    }
  }

  // ✅ Determinar el tipo de dispositivo
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;
}
