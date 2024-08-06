import '../enums/input_text_state_enum.dart';

class InputUtils {

  static String getTextMessageError(TypeTextFieldState textFieldStatus) {
    switch (textFieldStatus) {
      case TypeTextFieldState.stateDef:
        return '';
      case TypeTextFieldState.valided:
        return '';
      case TypeTextFieldState.desabilitado:
        return '';
      case TypeTextFieldState.errorFieldRequired:
        return 'Obrigatório!';
      case TypeTextFieldState.error:
        return 'Entrada inválida';
      case TypeTextFieldState.nameAndSobrename:
        return 'Digite o nome completo';
      case TypeTextFieldState.cpfIsInvalid:
        return 'CPF inválido';
      case TypeTextFieldState.nameIsEmpty:
        return 'Nome está vazio';
      case TypeTextFieldState.cpfIsEmpty:
        return 'CPF está vazio';
      case TypeTextFieldState.dataNascimentoIsInvalid:
        return 'Data inválida';
      case TypeTextFieldState.emailIsInvalid:
        return 'Email inválido';
      case TypeTextFieldState.celularIsInvalid:
        return 'Celular inválido';
      case TypeTextFieldState.cnpjIsInvalid:
        return 'CNPJ inválido';
      case TypeTextFieldState.peloMenosTresDigitos:
        return 'Digite pelo menos 3 dígitos';
      case TypeTextFieldState.senhaIsInvalid:
        return 'Senha inválida';
      case TypeTextFieldState.senhaNaoSaoIguais:
        return 'Confirme não coincidem';
      case TypeTextFieldState.phoneIsInvalid:
        return 'Telefone não é valido';
      case TypeTextFieldState.dataCartaoInvalid:
        return 'Data inválida';
      case TypeTextFieldState.cvvInvalid:
        return 'Cód. inválido';
      case TypeTextFieldState.errorInvalidFormat:
        return 'Formato inválido';
      case TypeTextFieldState.nomeEquipeIsInvalid:
        return 'Campo inválido';
      case TypeTextFieldState.noMaximo5Palavras:
        return 'No máximo 5 palavras';
      case TypeTextFieldState.nomeEquipeMuitoGrande:
        return 'Nome da equipe muito grande';
      case TypeTextFieldState.nomeRuaMuitoGrande:
        return 'Nome da rua é muito grande';
      case TypeTextFieldState.noMaximo10Palavras:
        return 'No máximo 10 palavras';
      case TypeTextFieldState.complementoMuitoGrande:
        return 'Complemento muito grande';
      case TypeTextFieldState.nomeBairroMuitoGrande:
        return 'Nome do bairro muito grande';
      case TypeTextFieldState.nomeCidadeMuitoGrande:
        return 'Nome da cidade muito grande';
      case TypeTextFieldState.nomeEstadoMuitoGrande:
        return 'Nome do estado muito grande';
      case TypeTextFieldState.limitCaracteresAtingido:
        return 'Limite de caracteres atingido';
      case TypeTextFieldState.cepNaoEncontrado:
        return 'CEP não encontrado';
      case TypeTextFieldState.phoneAlreadyRegisted:
        return 'Telefone já existe cadastrado';
      case TypeTextFieldState.emailAlreadyRegisted:
        return 'Email já existe cadastrado';
      case TypeTextFieldState.verifiqueValorETenteNovamente:
        return 'Verifique o valor e tente novamente';
      case TypeTextFieldState.limiteInsuficiente:
        return 'Limite insuficiente';
      case TypeTextFieldState.messageErrorCustomizada:
        return '';
      case TypeTextFieldState.naoEPermitidoTrasferirParaPessoaJuridicaError:
        return 'No momento não é permitido transferência para pessoa Jurídica';
    }
  }

}