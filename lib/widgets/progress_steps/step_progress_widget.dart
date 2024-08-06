import 'package:flutter/material.dart';
import 'package:runtickets_web/core/views/app_colors.dart';
import 'package:runtickets_web/core/views/app_fonts.dart';
import 'models/step_progress.dart';

class StepProgress extends StatelessWidget {
  final List<StepData> steps;
  final int currentStep;

  const StepProgress({super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: steps.map((step) {
        return StepContainer(
          stepText: step.stepText,
          showLineLeft: step.showLineLeft(),
          showLineRight: step.showLineRight(steps.length),
          labelText: step.labelText,
          currentStep: currentStep,
          borderColor: step.getBorderColor(currentStep),
        );
      }).toList(),
    );
  }
}

class StepContainer extends StatelessWidget {
  final String stepText;
  final String labelText;
  final bool showLineLeft;
  final bool showLineRight;
  final int currentStep;
  final Color borderColor;
  final bool isCompleted;

  const StepContainer({
    super.key,
    required this.stepText,
    this.showLineLeft = false,
    this.showLineRight = false,
    this.currentStep = 1,
    required this.borderColor,
    required this.labelText,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {

    final isCurrentStep = int.parse(stepText) == currentStep;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerWidth = constraints.maxWidth;
          final centerX = containerWidth / 2;
          const radiusCircle = 20.0;

          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(isCurrentStep)
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: borderColor.withAlpha(50),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Text(stepText, style: TextStyle(fontFamily: FontsApp.epilogueSemiBold,
                            color: borderColor)),
                      ),
                    ),
                    if(!isCurrentStep || isCompleted)
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: borderColor,
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Icon(Icons.check, color: AppColors.colorWhite,),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(labelText, style: TextStyle(fontFamily: isCurrentStep ?
                    FontsApp.epilogueSemiBold : FontsApp.epilogueRegular,
                      color: borderColor,
                      fontWeight: isCurrentStep ? FontWeight.bold
                          : FontWeight.normal
                    )),
                  ],
                ),
              ),
              if (showLineLeft)
                Positioned(
                  left: 0,
                  top: 20,
                  child: Container(
                    width: centerX - radiusCircle,
                    height: 2,
                    color: (Colors.grey[200] as Color),
                  ),
                ),
              if (showLineRight)
                Positioned(
                  right: 0,
                  top: 20,
                  child: Container(
                    width: centerX - radiusCircle,
                    height: 2,
                    color:  (Colors.grey[200] as Color),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
