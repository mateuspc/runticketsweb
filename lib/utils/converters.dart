
import 'package:flutter/material.dart';

import '../core/enums/event_status_enum.dart';

EventStatus getEnumEventStatus(String statusString) {
  switch (statusString.toLowerCase()) {
    case 'aberto':
      return EventStatus.aberto;
    case 'esgotado':
      return EventStatus.esgotado;
    case 'pausado':
      return EventStatus.pausado;
    case 'cancelado':
      return EventStatus.cancelado;
    case 'finalizado':
      return EventStatus.finalizado;
    case 'finalizado_prazo_inscricao':
      return EventStatus.finalizado_prazo_inscricao;
    default:
      throw ArgumentError('String de status inválida: $statusString');
  }
}


String enumEventParaString(EventStatus status) {
  switch (status) {
    case EventStatus.aberto:
      return 'Inscrições abertas';
    case EventStatus.esgotado:
      return 'Inscrições esgotadas';
    case EventStatus.pausado:
      return 'Evento pausado';
    case EventStatus.cancelado:
      return 'Evento cancelado';
    case EventStatus.finalizado:
      return 'Evento finalizado';
    case EventStatus.finalizado_prazo_inscricao:
      return 'Prazo esgotado';
    default:
      throw ArgumentError('Enum de status inválido: $status');
  }
}

Color getCorEventoStatus(EventStatus status) {
  switch (status) {
    case EventStatus.aberto:
      return Colors.green;
    case EventStatus.esgotado:
      return Colors.grey[300] as Color;
    case EventStatus.pausado:
      return Colors.yellow;
    case EventStatus.cancelado:
      return Colors.grey[300] as Color;
    case EventStatus.finalizado_prazo_inscricao:
      return Colors.grey[300] as Color;
    case EventStatus.finalizado:
      return Colors.grey[300] as Color;
    default:
      return Colors.grey[300] as Color;
  }



}

String removerCaracteresEspeciais(String texto) {
  RegExp regExp = RegExp(r'\D');
  String resultado = texto.replaceAll(regExp, '');
  return resultado;
}
