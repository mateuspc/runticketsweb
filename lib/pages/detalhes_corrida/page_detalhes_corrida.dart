import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:runtickets_web/core/injects/inject.dart';
import 'package:runtickets_web/core/routes/app_routes.dart';
import 'package:runtickets_web/core/views/app_colors.dart';
import 'package:runtickets_web/core/views/app_fonts.dart';
import 'package:runtickets_web/gen/assets.gen.dart';
import 'package:runtickets_web/loading/page_loading.dart';
import 'package:runtickets_web/models/responses/success_get_events_response.dart';
import 'package:runtickets_web/pages/detalhes_corrida/page_detalhes_corrida_state.dart';
import 'package:runtickets_web/pages/inscription/evento_categorias/page_evento_categorias.dart';
import 'package:runtickets_web/text_fields/button/elevated_button_custom.dart';
import 'package:runtickets_web/widgets/progress_steps/models/step_progress.dart';
import '../../widgets/progress_steps/step_progress_widget.dart';
import '../../widgets/rt_appbar.dart';
import 'page_detalhes_corrida_cubit.dart';

class RaceDetailScreen extends StatefulWidget {
  const RaceDetailScreen({super.key});

  @override
  State<RaceDetailScreen> createState() => _RaceDetailScreenState();
}

class _RaceDetailScreenState extends State<RaceDetailScreen> {
  bool firstAccess = true;
  final _cubit = inject<PageCorridaDetalhesCubit>();
  Evento? _evento;
  int _currentStep = 1;
  int _currentIndexContent = 0;

  // Mapa de conteúdos por etapa
  final Map<int, List<Widget>> _stepContents = {
    1: [
      const PageEventoCategorias(),
    ],
    2: [
      Center(child: Text('Conteúdo da Etapa 2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    ],
    3: [
      Center(child: Text('Conteúdo da Etapa 3', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    ],
    4: [
      Center(child: Text('Conteúdo da Etapa 4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    ],
  };

  void _previousStep() {
    if (_currentStep == 1) {
      context.go(AppRoutes.pageDashboard);
    } else if (_currentIndexContent > 0) {
      setState(() {
        _currentIndexContent--;
      });
    } else if (_currentStep > 1) {
      setState(() {
        _currentStep--;
        _currentIndexContent = _stepContents[_currentStep]!.length - 1;
      });
    }
  }

  void _nextStep() {
    if (_currentIndexContent < _stepContents[_currentStep]!.length - 1) {
      setState(() {
        _currentIndexContent++;
      });
    } else if (_currentStep < _stepContents.keys.reduce((a, b) => a > b ? a : b)) {
      setState(() {
        _currentStep++;
        _currentIndexContent = 0;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (firstAccess) {
      firstAccess = false;
      var res = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _cubit.getEventById(int.parse(res['id']));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final width = size.width;
    final bool isLargeScreen = width > 800;

    return BlocConsumer<PageCorridaDetalhesCubit, PageDetalhesCorridaState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (value) {
            setState(() {
              _evento = value;
            });
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: isLargeScreen ? null : AtAppBar(
            title: 'Runtickets',
            backgroundColor: Colors.white,
            titleColor: AppColors.colorBlack,
            leading: IconButton(
              onPressed: () {
                context.go(AppRoutes.pageDashboard);
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp),
            ),
          ),
          body: state.maybeWhen(
            orElse: () {
              return const PageLoading();
            },
            success: (_) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: Center(
                              child: SizedBox(
                                height: 80,
                                child: Assets.logo.logoHorizontalAzul.image(height: 25),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: size.width,
                            color: (Colors.grey[50] as Color),
                            child: Center(
                              child: Text(
                                'Inscrição 1 corrida runtickets - 03/09/2025 $_currentIndexContent,$_currentStep ',
                                style: TextStyle(
                                    fontFamily: FontsApp.epilogueSemiBold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          SizedBox(
                            height: 100,
                            child: StepProgress(
                              currentStep: _currentStep,
                              steps: [
                                StepData(stepIndex: 1, stepText: '1', labelText: 'Percurso'),
                                StepData(stepIndex: 2, stepText: '2', labelText: 'Identificação'),
                                StepData(stepIndex: 3, stepText: '3', labelText: 'Questionário'),
                                StepData(stepIndex: 4, stepText: '4', labelText: 'Pagamento'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: IndexedStack(
                                index: _currentIndexContent,
                                children: _stepContents[_currentStep]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  if (isLargeScreen)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 100,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        _previousStep();
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.midleGray.withAlpha(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'VOLTAR',
                                            style: TextStyle(
                                                fontFamily: FontsApp.epilogueSemiBold,
                                                color: AppColors.colorWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        _nextStep();
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.colorPrimary,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'PRÓXIMO',
                                            style: TextStyle(
                                                fontFamily: FontsApp.epilogueSemiBold,
                                                color: AppColors.colorWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                      child: ElevatedButtonCustom(
                        onPressed: _nextStep,
                        text: 'AVANÇAR',
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
