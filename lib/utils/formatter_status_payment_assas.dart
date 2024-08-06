
import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/enums/inscricao_status.dart';

enum StatusPaymentAssas {
  RECEIVED,
  PENDING,
  COMFIRMED
}

StatusPaymentAssas stringPaymentAssasToStatus(String status) {
  switch (status.toUpperCase()) {
    case 'RECEIVED':
      return StatusPaymentAssas.RECEIVED;
    case 'PENDING':
      return StatusPaymentAssas.PENDING;
    case 'CONFIRMED':
      return StatusPaymentAssas.COMFIRMED;

    default:
      throw ArgumentError('Invalid status: $status');
  }
}

Color stringPaymentAssasToStatusColor(String status) {
  switch (status.toUpperCase()) {
    case 'CONFIRMED':
    case 'RECEIVED':
      return Colors.green[900] as Color;
    case 'PENDING':
      return Colors.orange;

    default:
      throw ArgumentError('Invalid status: $status');
  }
}

enum TypePayments {
  pix,
  creditcard
}

TypePayments typePayment(String type) {
  switch (type) {
    case 'pix':
      return TypePayments.pix;
    case 'cartao-credito':
      return TypePayments.creditcard;
    default:
      throw ArgumentError('Invalid creditcard: $type');
  }
}

String typePaymentEnumToStringShow(TypePayments type) {
  switch (type) {
    case TypePayments.pix:
      return 'PIX';
    case TypePayments.creditcard:
      return 'Cartão de crédito';
    default:
      return 'N/A';
  }
}

String statusAssasToPortuguese(StatusPaymentAssas status) {
  switch (status) {
    case StatusPaymentAssas.RECEIVED || StatusPaymentAssas.COMFIRMED:
      return 'Recebido';
    case StatusPaymentAssas.PENDING:
      return 'Pendente';
    default:
      throw ArgumentError('Invalid status: $status');
  }
}

InscricaoStatus getStatusInscricao(int index){
  switch(index){
    case 0:
      return InscricaoStatus.finalizado;
    case 1:
      return InscricaoStatus.pendente_pagamento;
    case 2:
      return InscricaoStatus.criado;
    case 3:
      return InscricaoStatus.reservado;
    case 4:
      return InscricaoStatus.falhou;
    default:
      return InscricaoStatus.expirado;
  }
}

InscricaoStatus formatterStatusToEnum(String statusName){
  switch(statusName){
    case 'criado':
      return InscricaoStatus.criado;
    case 'reservado':
      return InscricaoStatus.reservado;
    case 'pendente_pagamento':
      return InscricaoStatus.pendente_pagamento;
    case 'finalizado':
      return InscricaoStatus.finalizado;
    case 'falhou':
      return InscricaoStatus.falhou;
    case 'expirado':
      return InscricaoStatus.expirado;
    default:
      return InscricaoStatus.expirado;
  }
}

String formatterStatusName(String statusName){
  switch(statusName){
    case 'criado':
      return 'Criada';
    case 'reservado':
      return 'Reservado';
    case 'pendente_pagamento':
      return 'Pendente de pagamento';
    case 'finalizado':
      return 'Inscrito';
    case 'falhou':
      return 'Falhou';
    case 'expirado':
      return 'Expirada';
    default:
      return 'N/A';
  }
}