

class GetEventCategoriaResponse {
  Pagination? pagination;
  List<EventpCategoria>? results;

  GetEventCategoriaResponse({this.pagination, this.results});

  GetEventCategoriaResponse.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['results'] != null) {
      results = <EventpCategoria>[];
      json['results'].forEach((v) {
        results!.add(EventpCategoria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? lastpage;

  Pagination({this.page, this.limit, this.total, this.lastpage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    lastpage = json['lastpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['lastpage'] = lastpage;
    return data;
  }
}

class EventpCategoria {
  int? id;
  String? nome;
  String? descricao;
  int? vagas;
  int? evento;
  bool? selected;

  EventpCategoria({this.id, this.nome, this.descricao, this.vagas, this.evento, this.selected = false});

  EventpCategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    vagas = json['vagas'];
    evento = json['Evento'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['vagas'] = vagas;
    data['Evento'] = evento;
    return data;
  }

}