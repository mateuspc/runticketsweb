import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:runtickets_web/models/responses/success_get_event_categorias_response.dart';
part 'page_evento_categorias_state.freezed.dart';

@freezed
class PageEventoCategoriasState with _$PageEventoCategoriasState {
  const factory PageEventoCategoriasState.initial() = InitialPageEventoCategoriasState;

  const factory PageEventoCategoriasState.loading() = LoadingPageEventoCategoriasState;

  const factory PageEventoCategoriasState.success(GetEventCategoriaResponse result, bool newInscription) = SuccessPageEventoCategoriasState;

  const factory PageEventoCategoriasState.successWithListEmpty() = SuccessWithListEmptyPageEventoCategoriasState;

  const factory PageEventoCategoriasState.successfullySaveCategorySelected() = SuccessfullySaveCategorySelectedState;

  const factory PageEventoCategoriasState.failedSaveCategorySelected() = FailedSaveCategorySelectedState;

  const factory PageEventoCategoriasState.error(String error) = ErrorPageEventoCategoriasState;

  const factory PageEventoCategoriasState.offline({
    required Function() onTryAgain,
  }) = OfflinePageEventoCategoriasState;
}

