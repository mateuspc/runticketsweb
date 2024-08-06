import 'dart:async';
import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validators/validators.dart';
import '../components/text_input_document.dart';
import '../enums/input_text_state_enum.dart';
import '../enums/password_strength_enum.dart';
import '../models/item_step.dart';
import '../utils/credit_card_type_detector_utils.dart';
import '../utils/validators.dart';
import 'text_input_state.dart';

class TextInputValidatorCubit extends Cubit<TextInputState> {

  TextInputValidatorCubit() : super(const TextInputState.initial());

  Future<bool> validateEmail(String email, {bool hasRequired = false}) async {
    if (hasRequired && email.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if(!hasRequired && email.isNotEmpty && email.contains('@')){
      emit(const TextInputState.loading());
    }

    if (isEmail(email) || email.isEmpty) {
      emit(const TextInputState.valided());
      return true;
    }

    if(!isEmail(email)){
      emit(const TextInputState.error(TypeTextFieldState.emailIsInvalid));
      return false;
    }

    emit(const TextInputState.valided());
    return true;
  }

  bool validateNomeEquipe(String nomeEquipe, {bool hasRequired = false}) {
    if (hasRequired && nomeEquipe.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (nomeEquipe.split(" ").length > 5) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo5Palavras));
      return false;
    }
    if (nomeEquipe.length > 30) {
      emit(const TextInputState.error(TypeTextFieldState.nomeEquipeMuitoGrande));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateComplemento(String complemento, {bool hasRequired = false}) {
    if (hasRequired && complemento.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (complemento.split(" ").length > 5) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo5Palavras));
      return false;
    }
    if (complemento.length > 12) {
      emit(const TextInputState.error(TypeTextFieldState.complementoMuitoGrande));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateCidade(String cidade, {bool hasRequired = false}) {
    if (hasRequired && cidade.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (cidade.split(" ").length > 5) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo5Palavras));
      return false;
    }
    if (cidade.length > 12) {
      emit(const TextInputState.error(TypeTextFieldState.limitCaracteresAtingido));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateEstado(String estado, {bool hasRequired = false}) {
    if (hasRequired && estado.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (estado.split(" ").length > 5) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo5Palavras));
      return false;
    }
    if (estado.length > 12) {
      emit(const TextInputState.error(TypeTextFieldState.limitCaracteresAtingido));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateNomeRua(String nomeRua, {bool hasRequired = false}) {
    if (hasRequired && nomeRua.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (nomeRua.split(" ").length > 10) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo10Palavras));
      return false;
    }
    if (nomeRua.length > 30) {
      emit(const TextInputState.error(TypeTextFieldState.nomeRuaMuitoGrande));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateNomeBairro(String nomeBairro, {bool hasRequired = false}) {
    if (hasRequired && nomeBairro.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (nomeBairro.split(" ").length > 5) {
      emit(const TextInputState.error(TypeTextFieldState.noMaximo5Palavras));
      return false;
    }
    if (nomeBairro.length > 30) {
      emit(const TextInputState.error(TypeTextFieldState.nomeBairroMuitoGrande));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateCityPreference(String cityPreference, {bool hasRequired = false}) {
    if (hasRequired && cityPreference.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (cityPreference.isEmpty) {
      emit(const TextInputState.valided());
      return true;
    }
    emit(const TextInputState.valided());
    return true;
  }

  Future<bool> validatePhone(String phone, {bool hasRequired = false}) async {

    if (hasRequired && phone.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (phone.isEmpty) {
      emit(const TextInputState.valided());
      return true;
    }
    if(phone.length < 10){
      emit(const TextInputState.error(TypeTextFieldState.phoneIsInvalid));
      return false;
    }

    emit(const TextInputState.valided());
    return true;
  }

  bool validateConfirmPassword(String password1, String password2Confirm){
    if (password2Confirm.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    // Verifica se as senhas são iguais
    if(password1 == password2Confirm){
      emit(const TextInputState.valided());
      return true;
    } else {
      // Se não forem iguais, emite um estado de erro indicando que as senhas não são iguais
      emit(const TextInputState.error(TypeTextFieldState.senhaNaoSaoIguais)); // Supondo que este é o método correto para emitir o estado de erro
      return false;
    }
  }


  bool validateIsGoodPassword(String password){
    bool isGoodPass = isGoodPassword(password, passwordTips: []);
    if(!isGoodPass){
      emit(const TextInputState.changedCreatePasswordTextFieldStrength(
        [],
        TypePasswordStrength.none,
      ));
      emit(const TextInputState.error(TypeTextFieldState.senhaIsInvalid));
      return false;
    }
    emit(const TextInputState.valided());
    return isGoodPass;
  }

  bool validateIsGoodPassword4Digits(String password){
    bool isGoodPass = isGoodPassword4Digits(password, passwordTips: []);
    if(!isGoodPass){
      emit(const TextInputState.changedCreatePasswordTextFieldStrength(
        [],
        TypePasswordStrength.none,
      ));
      emit(const TextInputState.error(TypeTextFieldState.senhaIsInvalid));
      return false;
    }
    emit(const TextInputState.valided());
    return isGoodPass;
  }

  bool validatePasswordRequired(String password, {bool hasRequired = false}) {
    if (hasRequired && password.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validatePassword(String password, {bool hasRequired = false}) {
    if (hasRequired && password.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (!hasRequired && password.isEmpty) {
      emit(const TextInputState.changedCreatePasswordTextFieldStrength(
        [],
        TypePasswordStrength.none,
      ));
      return false;
    }

    List<PasswordTip> passwordTips = [];

    bool isGoodPass = isGoodPassword4Digits(password, passwordTips: passwordTips);

    if (isGoodPass) {
      emit(const TextInputState.changedCreatePasswordTextFieldStrength(
        [],
        TypePasswordStrength.none,
      ));
      return true;
    }

    int lenghtCorrect = passwordTips.where((element) => element.validate == true).toList().length;

    TypePasswordStrength passwordStrength;
    if (lenghtCorrect < 2) {
      passwordStrength = TypePasswordStrength.weak;
    } else if (lenghtCorrect <= 6 && lenghtCorrect >= 2) {
      passwordStrength = TypePasswordStrength.medium;
    } else {
      passwordStrength = TypePasswordStrength.strong;
    }

    // Emitir o estado ChangedCreatePasswordTextFieldStrength
    emit(TextInputState.changedCreatePasswordTextFieldStrength(
      passwordTips,
      passwordStrength,
    ));

    // Emitir o estado SuccessTextInputState
    emit(const TextInputState.valided());

    return true;
  }

  bool isGoodPassword(String password, {List<PasswordTip> passwordTips = const []}) {
    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "Ter pelo menos 1 letra"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "Ter pelo menos 1 letra"));
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "Ter pelo menos 1 número"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "Ter pelo menos 1 número"));
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "Pelo menos 1 caractere especial"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "Pelo menos 1 caractere especial"));
    }

    // Adicionar dicas com base na validação
    if (password.length < 7) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "Deve conter no mínimo 7 caracteres"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "Deve conter no mínimo 7 caracteres"));
    }
    int lenghtCorrect = passwordTips.where((element) => element.validate == true).toList().length;
    bool isGoodPassword = lenghtCorrect >= 4;
    return isGoodPassword;
  }

  bool isGoodPassword4Digits(String password, {List<PasswordTip> passwordTips = const []}) {

    // Adicionar dicas com base na validação
    if (password.length != 4) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "A senha deve 4 digítos númericos"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "A senha deve 4 digítos númericos"));
    }

    bool hasConsecutiveEqualNumbers = false;
    for (int i = 0; i < password.length - 1; i++) {
      if (password[i] == password[i + 1]) {
        hasConsecutiveEqualNumbers = true;
        break;
      }
    }

    if (hasConsecutiveEqualNumbers) {
      passwordTips.add(PasswordTip(
          validate: false,
          text: "A senha não pode conter 2 números iguais seguidos"));
    } else {
      passwordTips.add(PasswordTip(
          validate: true,
          text: "A senha não pode conter 2 números iguais seguidos"));
    }

    int lenghtCorrect = passwordTips.where((element) => element.validate == true).toList().length;
    bool isGoodPassword = lenghtCorrect > 1;
    return isGoodPassword;
  }

  bool validateCodigoLocalmente(String codigo, {bool hasRequired = false}) {
    if (hasRequired && codigo.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (codigo.length < 4) {
      emit(const TextInputState.error(TypeTextFieldState.peloMenosTresDigitos));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateFullName(String name, {bool hasRequired = false}) {
    if (hasRequired && name.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (name.trim().split(" ").length < 2 && name.isNotEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.nameAndSobrename));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateNameTitularCartao(String name, {bool hasRequired = false}) {
    if (hasRequired && name.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    if (name.trim().split(" ").length < 2 && name.isNotEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.nameAndSobrename));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateNumeroCartao(String numero, {bool hasRequired = false}) {
    if (hasRequired && numero.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateCvcCartao(String cvc, {bool hasRequired = false}) {
    if (hasRequired && cvc.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    emit(const TextInputState.valided());
    return true;
  }

  bool validateCvc(String cvc, {bool hasRequired = false}) {
    if (hasRequired && cvc.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    RegExp regex = RegExp(r'^\d{2}\.\d{3}-\d{3}$');
    if (!regex.hasMatch(cvc) && cvc.isNotEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorInvalidFormat));
      return false;
    }

    emit(const TextInputState.valided());
    return true;
  }

  Future<bool> validateCep(String cep, {bool hasRequired = false}) async {

    if (hasRequired && cep.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    RegExp regex = RegExp(r'^\d{2}\.\d{3}-\d{3}$');
    if (!regex.hasMatch(cep) && cep.isNotEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorInvalidFormat));
      return false;
    }

    if(cep.length == 10) {
      if(!hasRequired){
        emit(const TextInputState.loading());
      }

      // ApiResponse apiResponse = await _authRepository.getInfoCep(
      //     removeSpecialCharacters(cep));
      // if (!apiResponse.ok) {
      //   emit(const TextInputState.error(TypeTextFieldState.cepNaoEncontrado));
      //   return false;
      // }else{
        emit(const TextInputState.valided());
      //
      // }
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateDataCartao(String validadeCartao, {bool hasRequired = false}) {
    try {

      if (hasRequired && validadeCartao.isEmpty) {
        emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
        return false;
      }
      if (validadeCartao.isEmpty) {
        emit(const TextInputState.valided());
        return false;
      }
      // Separar o mês e o ano
      List<String> partes = validadeCartao.split('/');
      int mes = int.parse(partes[0]);
      int ano = int.parse(partes[1]);

      // Verificar o formato
      if (partes.length != 2) {
        emit(const TextInputState.error(TypeTextFieldState.dataCartaoInvalid));
        return false;
      }

      // Verificar se o mês está entre 1 e 12
      if (mes < 1 || mes > 12) {
        emit(const TextInputState.error(TypeTextFieldState.dataCartaoInvalid));
        return false;
      }

      // Verificar se o ano não é anterior ao ano atual
      int anoAtual = DateTime.now().year % 100; // Pegar os dois últimos dígitos do ano atual
      if (ano < anoAtual) {
        emit(const TextInputState.error(TypeTextFieldState.dataCartaoInvalid));
        return false;
      }
      emit(const TextInputState.valided());
      return true;
    } catch (e) {
      return false;
    }
  }



  void checkBandeiraCartao(String numeroCartao){
    String res = detectarBandeira(numeroCartao);
    emit(TextInputState.changedCreditCardFlag(res));
  }

  bool validateGender(String? gender, {bool hasRequired = false}) {
    if (hasRequired && (gender?.isEmpty ?? true) || gender == null) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateShirtSize(String? shirtSize, {bool hasRequired = false}) {
    if (hasRequired && (shirtSize?.isEmpty ?? true) || shirtSize == null) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }

  bool validateDateOfBirth(String dateOfBirthString, {bool hasRequired = false}) {
    if (hasRequired && dateOfBirthString.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    if(dateOfBirthString.isEmpty){
      emit(const TextInputState.valided());
      return true;
    }
    // Converter a string para um objeto DateTime
    DateTime dateOfBirth;
    try {
      if(dateOfBirthString.length < 10 || dateOfBirthString.length > 10){
        emit(const TextInputState.error(TypeTextFieldState.dataNascimentoIsInvalid));
        return false;
      }
      List<String> parts = dateOfBirthString.split('/');
      dateOfBirth = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      emit(const TextInputState.valided());
    } catch (e) {
      emit(const TextInputState.error(TypeTextFieldState.dataNascimentoIsInvalid));
      return false;
    }

    // Assuming currentDate is the current date
    // DateTime currentDate = DateTime.now();
    //
    // if (dateOfBirth.isAfter(currentDate)) {
    //   emit(const TextInputState.error(TypeTextFieldState.dataNascimentoIsInvalid));
    //   return false;
    // }

    emit(const TextInputState.valided());
    return true;
  }


  bool validateKeyPIX(String document, {bool hasRequired = false}) {
    if (hasRequired && document.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    if (!hasRequired && document.isEmpty) {
      emit(const TextInputState.valided());
      return false;
    }

    if(CPFValidator.isValid(document)){
      emit(const TextInputState.validedCpfPix());
      return true;
    }

    if(CNPJValidator.isValid(document)){
      emit(const TextInputState.validedCnpjPix());
      emit(const TextInputState.error(TypeTextFieldState.naoEPermitidoTrasferirParaPessoaJuridicaError));
      return false;
    }

    if(isValidEmail(document)){
      emit(const TextInputState.validedEmailPix());
      return true;
    }

    emit(const TextInputState.validedUndefinedPix());
    return true;
  }

  bool validateDocument(String document, TypeDocument typeDocument, {bool hasRequired = false}) {
    if (hasRequired && document.isEmpty) {
      emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
      return false;
    }

    if (!hasRequired && document.isEmpty) {
      emit(const TextInputState.valided());
      return false;
    }

    if(typeDocument == TypeDocument.cpf && !hasRequired && document.length <= 13){
      emit(const TextInputState.valided());
      return false;
    }
    if(typeDocument == TypeDocument.cnpj && !CNPJValidator.isValid(document)){
      emit(const TextInputState.error(TypeTextFieldState.cnpjIsInvalid));
      return false;
    }
    if(typeDocument == TypeDocument.cpf && !CPFValidator.isValid(document)){
      emit(const TextInputState.error(TypeTextFieldState.cpfIsInvalid));
      return false;
    }
    emit(const TextInputState.valided());
    return true;
  }


  void changeTypeDocument(TypeDocument newType){
    emit(const TextInputState.valided());
    emit(TextInputState.changedDocumentType(
        _getHintFromTypeDocument(newType),
        _getMaskFormatter(newType),
        _getTextInputTypeKeyboard(newType)));
  }

  MaskTextInputFormatter _getMaskFormatter(TypeDocument type) {
    switch (type) {
      case TypeDocument.cpf:
        return MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
      case TypeDocument.cnpj:
        return MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
      default:
        return MaskTextInputFormatter();
    }
  }
  TextInputType _getTextInputTypeKeyboard(TypeDocument type) {
    switch (type) {
      case TypeDocument.cpf:
      case TypeDocument.cnpj:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  String _getHintFromTypeDocument(TypeDocument type) {
    switch (type) {
      case TypeDocument.cpf:
        return 'Digite o CPF';
      case TypeDocument.cnpj:
        return 'Digite o CNPJ';
      case TypeDocument.rne:
        return 'Digite o número do RNE';
      case TypeDocument.passaporte:
        return 'Digite o número do Passaporte';
      default:
        throw ArgumentError('Tipo de documento desconhecido: $type');
    }
  }

  bool validateNumeroCasa(String numeroCasa, {bool hasRequired = false}) {
      if (hasRequired && numeroCasa.isEmpty) {
        emit(const TextInputState.error(TypeTextFieldState.errorFieldRequired));
        return false;
      }

      emit(const TextInputState.valided());
      return true;
  }

  void changeStatusObscureText(bool value) {
     emit(TextInputState.changeObscureText(!value));
  }





}
