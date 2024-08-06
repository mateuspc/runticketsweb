import 'package:intl/intl.dart';

class DateFormatterUtils {


  static String formatDateLocal(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toUtc();
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime.toLocal());
    return formattedDateTime;
  }

  static String formatarData(String dataString) {
    try {
      // Converter a string para um objeto DateTime
      DateTime data = DateTime.parse(dataString);

      // Formatar a data como desejado usando o pacote intl
      String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

      return dataFormatada;
    } catch (e) {
      // Tratar erros de formatação ou conversão
      print("Erro ao formatar a data: $e");
      return "Data Inválida";
    }
  }

  static String formatarData2(String dataString) {
    // Converte a string em um objeto DateTime
    DateTime data = DateTime.parse(dataString);
    List<String> diasSemana = [
      'Domingo',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado'
    ];

    List<String> meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];

    // Formata a data desejada
    String dataFormatada =
        "${diasSemana[data.weekday - 1]}, ${data.day} de ${meses[data.month - 1]} de ${data.year}";

    return dataFormatada;
  }

  static String formatarDataComHoras(String dataString) {
    try {
      // Converter a string para um objeto DateTime
      DateTime data = DateTime.parse(dataString);

      // Formatar a data como desejado usando o pacote intl
      String dataFormatada = DateFormat('dd/MM/yyyy  HH:mm:ss').format(data);

      return dataFormatada;
    } catch (e) {
      // Tratar erros de formatação ou conversão
      print("Erro ao formatar a data: $e");
      return "Data Inválida";
    }
  }
  static String formataDataSendServer(String dataEntrada) {
    // Primeiro, substitui todas as barras ("/") por hífens ("-")
    String dataComHifens = dataEntrada.replaceAll('/', '-');

    // Em seguida, divide a string da data em partes (dia, mês, ano)
    List<String> partes = dataComHifens.split('-');

    // Reorganiza as partes para o formato 'yyyy-MM-dd'
    if (partes.length == 3) {
      String dataFormatada = '${partes[2]}-${partes[1]}-${partes[0]}';
      return dataFormatada;
    } else {
      // Retorna uma mensagem de erro se o formato de entrada não for o esperado
      return 'Formato de data inválido';
    }
  }
  // Entrada : 1999-10-04  e retorna : 04/10/1999
  static String formataDataRecebidaFromServer(String dataEntrada) {
    // Divide a string da data em partes (ano, mês, dia)
    List<String> partes = dataEntrada.split('-');

    // Reorganiza as partes para o formato 'dd/MM/yyyy'
    if (partes.length == 3) {
      String dataFormatada = '${partes[2]}/${partes[1]}/${partes[0]}';
      return dataFormatada;
    } else {
      // Retorna uma mensagem de erro se o formato de entrada não for o esperado
      return 'Formato de data inválido';
    }
  }

  // // Função para obter o nome do dia da semana
  // String _obterDiaSemana(DateTime data) {
  //   return diasSemana[data.weekday - 1];
  // }
  //
  // // Função para obter o nome do mês
  // String _obterNomeMes(DateTime data) {
  //   List<String> meses = [
  //     'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  //   ];
  //   return meses[data.month - 1];
  // }
}
