
String mascaraDocumento(String documento) {
  // Remover caracteres não numéricos
  String documentoNumerico = documento.replaceAll(RegExp(r'\D'), '');

  // Verificar se o documento tem tamanho válido
  if (documentoNumerico.length != 11 && documentoNumerico.length != 14) {
    return "Documento inválido!";
  }

  // Extrair os caracteres centrais
  String meio;
  if (documentoNumerico.length == 11) {
    meio = documentoNumerico.substring(3, 9);
  } else {
    meio = documentoNumerico.substring(5, 12);
  }

  // Substituir os caracteres centrais por asteriscos
  String documentoMascarado = documento.replaceRange(
      documento.length == 11 ? 3 : 5,
      documento.length == 11 ? 9 : 12,
      '*' * meio.length);

  return documentoMascarado;
}
