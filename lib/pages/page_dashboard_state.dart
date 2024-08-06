import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/responses/success_get_events_response.dart';
part 'page_dashboard_state.freezed.dart';

@freezed
class PageDashboardState with _$PageDashboardState {
  const factory PageDashboardState.initial() = InitialPageDashboardState;

  const factory PageDashboardState.loading() = LoadingPageDashboardState;

  const factory PageDashboardState.loadingListOnlySpace() = LoadingListOnlySpacePageDashboardState;

  const factory PageDashboardState.success(List<Evento>? results) = SuccessPageDashboardState;

  const factory PageDashboardState.successWithListEmpty() = SuccessWithListEmptyPageDashboardState;

  const factory PageDashboardState.error(String error) = ErrorPageDashboardState;

  const factory PageDashboardState.offline() = OfflinePageDashboardState;
}

