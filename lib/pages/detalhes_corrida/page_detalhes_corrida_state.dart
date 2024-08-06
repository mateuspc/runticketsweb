
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:runtickets_web/models/responses/success_get_events_response.dart';

part 'page_detalhes_corrida_state.freezed.dart';

@freezed
class PageDetalhesCorridaState with _$PageDetalhesCorridaState {
  const factory PageDetalhesCorridaState.initial() = InitialPageDetalhesCorridaState;

  const factory PageDetalhesCorridaState.loading() = LoadingPageDetalhesCorridaState;

  const factory PageDetalhesCorridaState.success(Evento event) = SuccessPageDetalhesCorridaState;

  const factory PageDetalhesCorridaState.successWithListEmpty() = SuccessWithListEmptyPageDetalhesCorridaState;

  const factory PageDetalhesCorridaState.error(String error) = ErrorPageDetalhesCorridaState;

  const factory PageDetalhesCorridaState.offline() = OfflinePageDetalhesCorridaState;
}

