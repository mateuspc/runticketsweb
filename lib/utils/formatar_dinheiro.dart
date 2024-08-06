
import 'package:intl/intl.dart';

String formatCurrency(num ammount) {
  String sign = ammount < 0 ? '-' : '';
  return '${sign}R\$ ${NumberFormat(',##0.00', 'pt_BR').format(ammount.abs())}';
}

String formatCurrencyWithoutRS(num ammount) {
  String sign = ammount < 0 ? '-' : '';
  return '${sign}${NumberFormat(',##0.00', 'pt_BR').format(ammount.abs())}';
}

String formatRate(num? ammount) {
  return '${NumberFormat("###0.0#", 'pt_BR').format(ammount ?? 0)}%';
}

double removeFormatCurrency(String ammount) {
  return double.tryParse(
      ammount.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.')) ??
      0.0;
}

String formatCurrency2(num numero){
  var formatador = NumberFormat('#,##0.00', 'pt_BR');
  return formatador.format(numero);
}
