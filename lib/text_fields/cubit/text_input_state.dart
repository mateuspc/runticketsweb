import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../enums/input_text_state_enum.dart';
import '../enums/password_strength_enum.dart';
import '../models/item_step.dart';

part 'text_input_state.freezed.dart';

@freezed
class TextInputState with _$TextInputState {
  const factory TextInputState.initial() = InitialTextInputState;

  const factory TextInputState.valided() = SuccessTextInputState;

  const factory TextInputState.validedCpfPix() = SuccessValidCpfPixTextInputState;

  const factory TextInputState.validedEmailPix() = SuccessValidEmailPixTextInputState;

  const factory TextInputState.validedCnpjPix() = SuccessValidCnpjPixTextInputState;

  const factory TextInputState.validedUndefinedPix() = SuccessValidUndefinedPixTextInputState;

  const factory TextInputState.loading() = LoadingTextInputState;

  const factory TextInputState.changedCreditCardFlag(String newPathAsset) = ChangedCreditCardFlag;

  const factory TextInputState.changeObscureText(bool value) = ChangedObscureText;

  const factory TextInputState.changedDocumentType(String hintNewTypeDocument,
      MaskTextInputFormatter maskTextInputFormatter,
      TextInputType textInputType) = SuccessChangedDocumentInputState;

  const factory TextInputState.changedCreatePasswordTextFieldStrength(List<PasswordTip> currentTipsPassword,
      TypePasswordStrength typePasswordStrength
      ) = ChangedCreatePassordTextFieldState;

  const factory TextInputState.error(TypeTextFieldState typeError, {String? messageCustom}) = ErrorTextInputState;

  const factory TextInputState.offline() = OfflineTextInputState;

  const factory TextInputState.timeout() = TimeOutTextInputState;

  const factory TextInputState.tokenIsExpired() = TokenIsExpiredTextInputState;
}