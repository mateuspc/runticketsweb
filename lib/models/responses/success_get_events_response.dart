

import 'package:runtickets_web/core/enums/event_status_enum.dart';

import '../../utils/converters.dart';

class SucessoEventosResponse {
  Pagination? pagination;
  List<Evento>? eventos;

  SucessoEventosResponse({pagination, eventos});

  SucessoEventosResponse.fromJson(Map<String, dynamic> json) {

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;

    if (json['results'] != null) {
      eventos = <Evento>[];
      json['results'].forEach((v) {
        eventos!.add(Evento.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (eventos != null) {
      data['Evento'] = eventos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? lastpage;

  Pagination({page, limit, total, lastpage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    lastpage = json['lastpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['lastpage'] = lastpage;
    return data;
  }
}

class Evento {
  int? id;
  Organizador? organizador;
  CidadeLocalizacao? cidadeLocalizacao;
  String? banner;
  String? imagem;
  String? nome;
  String? dataevento;
  EventStatus? status;
  String? localizacaoendereco;
  String? localizacaolat;
  String? localizacaolng;
  String? datainscricaoinicial;
  String? datainscricaofinal;
  String? descricao;
  String? atencao;
  String? percurso;
  String? linktermoediretrizes;
  String? arquivotermoediretrizes;
  bool? temkit;

  Evento(
      {id,
        organizador,
        cidadeLocalizacao,
        banner,
        imagem,
        nome,
        dataevento,
        status,
        localizacaoendereco,
        localizacaolat,
        localizacaolng,
        datainscricaoinicial,
        datainscricaofinal,
        descricao,
        atencao,
        percurso,
        linktermoediretrizes,
        arquivotermoediretrizes,
        temkit});

  Evento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizador = json['Organizador'] != null
        ? Organizador.fromJson(json['Organizador'])
        : null;
    cidadeLocalizacao = json['CidadeLocalizacao'] != null
        ? CidadeLocalizacao.fromJson(json['CidadeLocalizacao'])
        : null;
    banner = json['banner'];
    imagem = json['imagem'];
    nome = json['nome'];
    dataevento = json['dataevento'];
    status = getEnumEventStatus(json['status']);
    localizacaoendereco = json['localizacaoendereco'];
    localizacaolat = json['localizacaolat'];
    localizacaolng = json['localizacaolng'];
    datainscricaoinicial = json['datainscricaoinicial'];
    datainscricaofinal = json['datainscricaofinal'];
    descricao = json['descricao'];
    atencao = json['atencao'];
    percurso = json['percurso'];
    linktermoediretrizes = json['linktermoediretrizes'];
    arquivotermoediretrizes = json['arquivotermoediretrizes'];
    temkit = json['temkit'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (organizador != null) {
      data['Organizador'] = organizador!.toJson();
    }
    if (cidadeLocalizacao != null) {
      data['CidadeLocalizacao'] = cidadeLocalizacao!.toJson();
    }
    data['banner'] = banner;
    data['imagem'] = imagem;
    data['nome'] = nome;
    data['dataevento'] = dataevento;
    data['status'] = status;
    data['localizacaoendereco'] = localizacaoendereco;
    data['localizacaolat'] = localizacaolat;
    data['localizacaolng'] = localizacaolng;
    data['datainscricaoinicial'] = datainscricaoinicial;
    data['datainscricaofinal'] = datainscricaofinal;
    data['descricao'] = descricao;
    data['atencao'] = atencao;
    data['percurso'] = percurso;
    data['linktermoediretrizes'] = linktermoediretrizes;
    data['arquivotermoediretrizes'] = arquivotermoediretrizes;
    data['temkit'] = temkit;
    return data;
  }
}

class Organizador {
  int? id;
  String? nomeorganizacao;
  String? nomeorganizador;
  String? cpfcnpj;
  String? logo;
  String? email;
  String? telefone;

  Organizador(
      {id,
        nomeorganizacao,
        nomeorganizador,
        cpfcnpj,
        logo,
        email,
        telefone});

  Organizador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeorganizacao = json['nomeorganizacao'];
    nomeorganizador = json['nomeorganizador'];
    cpfcnpj = json['cpfcnpj'];
    logo = json['logo'];
    email = json['email'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nomeorganizacao'] = nomeorganizacao;
    data['nomeorganizador'] = nomeorganizador;
    data['cpfcnpj'] = cpfcnpj;
    data['logo'] = logo;
    data['email'] = email;
    data['telefone'] = telefone;
    return data;
  }
}

class CidadeLocalizacao {
  int? cidCodigo;
  Estado? estado;
  String? cidNome;
  int? cidIbge;

  CidadeLocalizacao({cidCodigo, estado, cidNome, cidIbge});

  CidadeLocalizacao.fromJson(Map<String, dynamic> json) {
    cidCodigo = json['cid_codigo'];
    estado =
    json['Estado'] != null ? new Estado.fromJson(json['Estado']) : null;
    cidNome = json['cid_nome'];
    cidIbge = json['cid_ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid_codigo'] = cidCodigo;
    if (estado != null) {
      data['Estado'] = estado!.toJson();
    }
    data['cid_nome'] = cidNome;
    data['cid_ibge'] = cidIbge;
    return data;
  }
}

class Estado {
  int? estCodigo;
  Pais? pais;
  String? estNome;
  String? estSigla;

  Estado({estCodigo, pais, estNome, estSigla});

  Estado.fromJson(Map<String, dynamic> json) {
    estCodigo = json['est_codigo'];
    pais = json['Pais'] != null ? new Pais.fromJson(json['Pais']) : null;
    estNome = json['est_nome'];
    estSigla = json['est_sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['est_codigo'] = estCodigo;
    if (pais != null) {
      data['Pais'] = pais!.toJson();
    }
    data['est_nome'] = estNome;
    data['est_sigla'] = estSigla;
    return data;
  }
}

class Pais {
  int? paisCodigo;
  String? paisNome;
  String? paisSigla;

  Pais({paisCodigo, paisNome, paisSigla});

  Pais.fromJson(Map<String, dynamic> json) {
    paisCodigo = json['pais_codigo'];
    paisNome = json['pais_nome'];
    paisSigla = json['pais_sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pais_codigo'] = paisCodigo;
    data['pais_nome'] = paisNome;
    data['pais_sigla'] = paisSigla;
    return data;
  }
}
