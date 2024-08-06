import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runtickets_web/core/injects/inject.dart';
import 'package:runtickets_web/core/views/app_fonts.dart';
import 'package:runtickets_web/models/responses/success_get_event_categorias_response.dart';
import 'package:runtickets_web/widgets/rt_internet_not_available.dart';
import 'package:runtickets_web/widgets/rt_list_empty.dart';
import 'page_evento_categorias_cubit.dart';
import 'page_evento_categorias_state.dart';
import 'widgets/category_options_card.dart';

class PageEventoCategorias extends StatefulWidget {
  const PageEventoCategorias({super.key});

  @override
  State<PageEventoCategorias> createState() => _PageEventoCategoriasState();
}

class _PageEventoCategoriasState extends State<PageEventoCategorias> {
  final cubit = inject<PageEventoCategoriasCubit>();
  GetEventCategoriaResponse? _getEventCategoriaResponse;
  bool hasNewInscription = true;
  String? categoryIdSelected;

  @override
  void initState() {
    cubit.getEventCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageEventoCategoriasCubit, PageEventoCategoriasState>(
      bloc: cubit,
      builder: (BuildContext context, PageEventoCategoriasState state) {
        return Center(
          child: Container(
            child: state.maybeWhen(
              orElse: () {
                List<EventpCategoria> results =
                    _getEventCategoriaResponse?.results ?? [];

                if (results.isEmpty) {
                  return const Center(child: RtListEmpty());
                }

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Qual categoria deseja participar?',
                            style: TextStyle(
                                fontFamily: FontsApp.epilogueSemiBold,
                                fontSize: 20
                            ),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16.0, // Espaço horizontal entre os itens
                          runSpacing: 16.0, // Espaço vertical entre as linhas de itens
                          children: results.map((eventCategoria) {
                            return Container(
                              width: (MediaQuery.of(context).size.width / 2.3) - 24, // Calcula a largura do item (considerando o padding)
                              child: CategoryOptionsCard(
                                label: eventCategoria.nome.toString(),
                                isSelected: eventCategoria.selected ?? false,
                                onTap: () {
                                  setState(() {
                                    for (var ec in results) {
                                      ec.selected = false;
                                    }
                                    eventCategoria.selected = true;
                                    categoryIdSelected = eventCategoria.id.toString();
                                  });
                                },
                                description: eventCategoria.descricao!,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              offline: (va) {
                return RtInternetNotAvailableWidget(
                  onTryAgain: () {
                    cubit.getEventCategoria();
                  },
                );
              },
            ),
          ),
        );
      },
      listener: (BuildContext context, PageEventoCategoriasState state) {
        state.maybeWhen(
          orElse: () {},
          success: (result, newInscription) {
            hasNewInscription = newInscription;
            _getEventCategoriaResponse = result;
          },
          successfullySaveCategorySelected: () {
            // context.push(AppRoutes.PAGE_MODALIDADES);
          },
          failedSaveCategorySelected: () {},
        );
      },
    );
  }
}
