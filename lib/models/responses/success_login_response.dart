

// import 'package:runtickets/text_fields/components/text_input_document.dart';

class CurrentUser {
  String? sessionid;
  Usuario? usuario;

  CurrentUser({sessionid, usuario});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    sessionid = json['token'];
    usuario =
    json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = sessionid;
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    return data;
  }


}

class Usuario {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? dateJoined;
  String? lastLogin;
  bool? isActive;
  bool? isStaff;
  Perfil? perfil;

  Usuario(
      {firstName,
        lastName,
        email,
        username,
        dateJoined,
        lastLogin,
        isActive,
        isStaff,
        perfil});

  Usuario.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    dateJoined = json['date_joined'];
    lastLogin = json['last_login'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    perfil =
    json['perfil'] != null ? Perfil.fromJson(json['perfil']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['username'] = username;
    data['date_joined'] = dateJoined;
    data['last_login'] = lastLogin;
    data['is_active'] = isActive;
    data['is_staff'] = isStaff;
    if (perfil != null) {
      data['perfil'] = perfil!.toJson();
    }
    return data;
  }

  String? getNomeCompleto(){
    return '$firstName $lastName';
  }

  String? getCidadePreferencia(){
    return '${perfil?.cidadePreferencia?.cidNome}';
  }
  String getNascimento() {
    DateTime date = DateTime.parse(perfil!.nascimento!);
    // Format the DateTime object to the desired format
    String formattedDate = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return formattedDate;
  }

  String? getPhone(){
    return '${perfil?.celular}';
  }

  // String? getDocument(TypeDocument typeDocument){
  //   String document = perfil?.documento ?? '';
  //   switch (typeDocument) {
  //     case TypeDocument.cpf:
  //       return _applyCpfMask(document);
  //     case TypeDocument.cnpj:
  //       return _applyCnpjMask(document);
  //     default:
  //       return document;
  //   }
  // }

  String _applyCpfMask(String cpf) {
    if (cpf.length != 11) return cpf; // CPF deve ter 11 dígitos
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

  String _applyCnpjMask(String cnpj) {
    if (cnpj.length != 14) return cnpj; // CNPJ deve ter 14 dígitos
    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12, 14)}';
  }
}

class Perfil {
  int? usuario;
  CidadePreferencia? cidadePreferencia;
  String? nascimento;
  dynamic avatar;
  String? celular;
  String? tipodocumento;
  String? documento;
  String? genero;
  String? codigoativacao;

  Perfil(
      {usuario,
        cidadePreferencia,
        nascimento,
        avatar,
        celular,
        tipodocumento,
        documento,
        genero,
        codigoativacao});

  Perfil.fromJson(Map<String, dynamic> json) {
    usuario = json['Usuario'];
    cidadePreferencia = json['CidadePreferencia'] != null
        ? CidadePreferencia.fromJson(json['CidadePreferencia'])
        : null;
    nascimento = json['nascimento'];
    avatar = json['avatar'];
    celular = json['celular'];
    tipodocumento = json['tipodocumento'];
    documento = json['documento'];
    genero = json['genero'];
    codigoativacao = json['codigoativacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Usuario'] = usuario;
    if (cidadePreferencia != null) {
      data['CidadePreferencia'] = cidadePreferencia!.toJson();
    }
    data['nascimento'] = nascimento;
    data['avatar'] = avatar;
    data['celular'] = celular;
    data['tipodocumento'] = tipodocumento;
    data['documento'] = documento;
    data['genero'] = genero;
    data['codigoativacao'] = codigoativacao;
    return data;
  }
}

class CidadePreferencia {
  int? cidCodigo;
  Estado? estado;
  String? cidNome;
  int? cidIbge;

  CidadePreferencia({cidCodigo, estado, cidNome, cidIbge});

  CidadePreferencia.fromJson(Map<String, dynamic> json) {
    cidCodigo = json['cid_codigo'];
    estado =
    json['Estado'] != null ? Estado.fromJson(json['Estado']) : null;
    cidNome = json['cid_nome'];
    cidIbge = json['cid_ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    pais = json['Pais'] != null ? Pais.fromJson(json['Pais']) : null;
    estNome = json['est_nome'];
    estSigla = json['est_sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pais_codigo'] = paisCodigo;
    data['pais_nome'] = paisNome;
    data['pais_sigla'] = paisSigla;
    return data;
  }
}
