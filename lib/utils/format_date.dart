import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

void main() {
  final now = DateTime.now();
  print('Fecha formateada: ${formatDate(now)}');
}
