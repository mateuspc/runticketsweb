import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:runtickets_web/core/routes/app_routes.dart';
import 'package:runtickets_web/core/views/app_colors.dart';
import 'package:runtickets_web/core/views/app_fonts.dart';
import 'package:runtickets_web/loading/page_loading.dart';
import 'package:runtickets_web/models/responses/success_get_events_response.dart';
import 'package:runtickets_web/pages/page_dashboard_state.dart';
import 'package:runtickets_web/widgets/painel_search_widget/rt_painel_search_widget.dart';

import '../core/injects/inject.dart';
import '../gen/assets.gen.dart';
import 'page_dashboard_cubit.dart';

import 'widgets/itens_per_page_dropdown.dart';
import 'widgets/sort_direction_dropdown.dart';
import 'widgets/sort_order_dropdown.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {

  final cubit = inject<PageDashboardCubit>();
  List<Evento>? results;
  String searchQuery = '';
  String selectedLocation = '';
  DateTime? selectedDate;
  int itemsPerPage = 15;
  String sortOrder = 'Data';
  bool isGrid = true;
  bool showFab = false;
  bool firstAccess = true;
  String page = '1';
  String limit = '10';
  String order = 'asc';
  String raio = '7000';
  String orderBy = 'distancia'; // dataevento, distancia , nome
  String query = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    if (firstAccess) {
      firstAccess = false;
      var res =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      limit = res['limit'] ?? '10';
      order = res['sort'] ?? 'asc';
      isGrid = bool.tryParse(res['isGrid'] ?? 'true') ?? true;


      cubit.getEvents(res);
    }

    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!showFab) {
        setState(() {
          showFab = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (showFab) {
        setState(() {
          showFab = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    setState(() {
      showFab = false;
    });
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _updateParamsAndFetchEvents(
      {required String page,
      required String limit,
      required String order,
      required String raio,
      required String orderBy,
      required String query,
      required bool isGrid}) {
    // Cria o mapa de parâmetros, removendo valores vazios
    final searchQueryParams = {
      'page': page,
      'limit': limit,
      'order': order,
      'isGrid': isGrid,
      'raio': raio,
      'orderby': orderBy,
      'q': query,
    }..removeWhere((key, value) => value is String && value.isEmpty);

    // Atualiza os eventos
    cubit.getEvents(searchQueryParams,
        showLoadingFullScreen: false, showLoadingListOnly: true);

    // Atualiza o contexto
    context.go(
        '/?page=$page&limit=$limit&order=$order&orderby=$orderBy&raio=$raio&q=$query&isGrid=$isGrid');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final width = size.width;
    final bool isLargeScreen = width > 800;

    return BlocConsumer<PageDashboardCubit, PageDashboardState>(
        bloc: cubit,
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              success: (results) {
                this.results = results;
              });
        },
        builder: (context, state) {
          return Container(
            child: state.maybeWhen(orElse: () {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleSpacing: 0,
                  leading: isLargeScreen
                      ? null
                      : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.logo.logoHorizontalAzul.image(height: 25),
                        if (isLargeScreen) Expanded(child: _navBarItems())
                      ],
                    ),
                  ),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(child: _ProfileIcon()),
                    )
                  ],
                ),
                drawer: isLargeScreen ? null : _drawer(),
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 350,
                        width: size.width,
                        child: Image.asset(
                          'assets/images/banner_corrida.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 60,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: size.height,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            RtPainelSearchWidget(
                              onChanged: (String value) {
                                if (value.isEmpty) {
                                  query = value;
                                  _updateParamsAndFetchEvents(
                                    page: page,
                                    limit: limit,
                                    order: order,
                                    raio: raio,
                                    orderBy: orderBy,
                                    query: query,
                                    isGrid: isGrid,
                                  );
                                }
                              },
                              applyFilter: (String queryFilter) {
                                query = queryFilter;
                                _updateParamsAndFetchEvents(
                                  page: page,
                                  limit: limit,
                                  order: order,
                                  raio: raio,
                                  orderBy: orderBy,
                                  query: query,
                                  isGrid: isGrid,
                                );
                              },
                              textSearchFieldController:
                                  cubit.textSearchFieldController,
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: size.height,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                width: 1)),
                                        width: constraints.maxWidth,
                                        padding: EdgeInsets.all(10),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (!isGrid) {
                                                  setState(() {
                                                    isGrid = !isGrid;
                                                  });
                                                }
                                                _updateParamsAndFetchEvents(
                                                  page: page,
                                                  limit: limit,
                                                  order: order,
                                                  raio: raio,
                                                  orderBy: orderBy,
                                                  query: query,
                                                  isGrid: isGrid,
                                                );
                                              },
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Icon(
                                                  Icons.grid_on_outlined,
                                                  color: isGrid
                                                      ? AppColors.colorRed
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (isGrid) {
                                                  setState(() {
                                                    isGrid = !isGrid;
                                                  });
                                                }

                                                _updateParamsAndFetchEvents(
                                                  page: page,
                                                  limit: limit,
                                                  order: order,
                                                  raio: raio,
                                                  orderBy: orderBy,
                                                  query: query,
                                                  isGrid: isGrid,
                                                );
                                              },
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Icon(Icons.list_outlined,
                                                    color: !isGrid
                                                        ? AppColors.colorRed
                                                        : Colors.black),
                                              ),
                                            ),
                                            // const SizedBox(width: 19,),
                                            //  Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 10),
                                            //   child: AutoSizeText(
                                            //     'Exibindo 1 - $limit de 54 resultados',
                                            //     style: const TextStyle(
                                            //         fontWeight: FontWeight.w500,
                                            //         fontSize: 14
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(width: 100,),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: AutoSizeText(
                                                'Itens por pagina:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            // Chat GPT componentize esse Widget começando daqui
                                            ItensPerPageDropdownInput(
                                              initialValue: int.parse(limit),
                                              onChanged: (value) {
                                                limit = value.toString();
                                                page = '1';
                                                _updateParamsAndFetchEvents(
                                                  page: page,
                                                  limit: limit,
                                                  order: order,
                                                  raio: raio,
                                                  orderBy: orderBy,
                                                  query: query,
                                                  isGrid: isGrid,
                                                );
                                              },
                                            ),

                                            const SizedBox(width: 19),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: AutoSizeText(
                                                'Ordenar por:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SortOrderDropdownInput(
                                              initialValue: 'Distância',
                                              onChanged: (String value) {
                                                orderBy = value.toString();

                                                Map<String, dynamic>
                                                    searchQueryParams = {
                                                  'page': page,
                                                  'limit': limit,
                                                  'order': order,
                                                  'raio': raio,
                                                  'orderby': orderBy,
                                                  'q': query,
                                                };

                                                cubit.getEvents(
                                                    searchQueryParams,
                                                    showLoadingFullScreen:
                                                        false,
                                                    showLoadingListOnly: true);
                                                context.go(
                                                    '/?page=$page&limit=$limit&order=$order&orderby=$orderBy&raio=$raio&q=$query');
                                              },
                                            ),
                                            const SizedBox(width: 19),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: AutoSizeText(
                                                'Ordem:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SortDirectionDropdownInput(
                                              initialValue:
                                                  getInverseSortDirectionLabel(
                                                      order),
                                              onChanged: (String value) {
                                                order = value;
                                                _updateParamsAndFetchEvents(
                                                  page: page,
                                                  limit: limit,
                                                  order: order,
                                                  raio: raio,
                                                  orderBy: orderBy,
                                                  query: query,
                                                  isGrid: isGrid,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      state is LoadingListOnlySpacePageDashboardState
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  const CircularProgressIndicator(),
                                            )
                                          : state is SuccessWithListEmptyPageDashboardState
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    'Nenhum resultado para a pesquisa',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .colorBlack),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 0.0),
                                                  child: GridView.builder(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      Evento event =
                                                          results![index];
                                                      if (!isGrid) {
                                                        return Card(
                                                          child: Container(
                                                            child: InkWell(
                                                              onTap: () {
                                                                context.goNamed(
                                                                    'details',
                                                                    pathParameters: {
                                                                      'id': event.id.toString()
                                                                    },
                                                                    queryParameters: {
                                                                      'event': event.nome?.replaceAll(' ', '+').toString(),
                                                                    }
                                                                );
                                                              },
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AspectRatio(
                                                                      aspectRatio:
                                                                          1,
                                                                      child: Image
                                                                          .network(
                                                                              event.imagem!)),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              16,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 16.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            event.nome!,
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color: AppColors.colorBlack,
                                                                                fontFamily: FontsApp.epilogueSemiBold),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              right: 16.0,
                                                                              left: 10),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(Icons.location_on),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Expanded(
                                                                                child: AutoSizeText(event.cidadeLocalizacao?.cidNome ?? ''),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      return Card(
                                                        borderOnForeground:
                                                            false,
                                                        elevation: 0,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                          child: Material(
                                                            color: AppColors
                                                                .background,
                                                            child: InkWell(
                                                              onTap: () {
                                                                context.goNamed(
                                                                  'details',
                                                                  pathParameters: {
                                                                    'id': event.id.toString()
                                                                  },
                                                                  queryParameters: {
                                                                    'event': event.nome?.replaceAll(' ', '+').toString(),
                                                                  }
                                                                );
                                                              },
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    AspectRatio(
                                                                        aspectRatio:
                                                                            1,
                                                                        child: Image.network(
                                                                            event.imagem!)),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              16.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        event
                                                                            .nome!,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                AppColors.colorBlack,
                                                                            fontFamily: FontsApp.epilogueSemiBold),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              16.0,
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.location_on),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                AutoSizeText(event.cidadeLocalizacao?.cidNome ?? ''),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          isGrid ? 3 : 1,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      childAspectRatio:
                                                          isGrid ? 0.7 : 2.5,
                                                    ),
                                                    itemCount: results?.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                  ),
                                                )
                                    ],
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: showFab
                    ? FloatingActionButton(
                        backgroundColor: AppColors.colorBlueText,
                        foregroundColor: AppColors.colorWhite,
                        shape: StadiumBorder(),
                        onPressed: _scrollToTop,
                        child: Icon(Icons.arrow_upward),
                      )
                    : null,
              );
            }, loading: () {
              return PageLoading();
            }),
          );
        });
  }
  Widget _drawer() => Drawer(
    child: ListView(
      children: _menuItems
          .map((item) => ListTile(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        title: Text(item),
      ))
          .toList(),
    ),
  );

  Widget _navBarItems() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _menuItems
        .map(
          (item) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 24.0, horizontal: 16),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
        .toList(),
  );
}

final List<String> _menuItems = <String>[
  'Sobre',
  'Contato',
  'Configurações',
];

enum Menu { itemOne, settings, logout }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.person),
        offset: const Offset(0, 40),
        onSelected: (Menu item) {
          if(item == Menu.settings){
            context.go(AppRoutes.pageSettings);
            return;
          }
          if(item == Menu.logout){
            context.go(AppRoutes.pageLogin);
            return;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
          const PopupMenuItem<Menu>(
            value: Menu.itemOne,
            child: Text('Meu perfil'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.settings,
            child: Text('Minhas inscrições'),
          ),
          const PopupMenuItem<Menu>(
            value: Menu.logout,
            child: Text('Sair'),
          ),
        ]);
  }
}

void removeEmptyParams(Map<String, dynamic> params) {
  params.removeWhere((key, value) => value is String && value.isEmpty);
}

String getInverseSortDirectionLabel(String direction) {
  switch (direction) {
    case 'asc':
      return 'Descendente';
    case 'desc':
      return 'Ascendente';
    default:
      return 'Ascendente';
  }
}
