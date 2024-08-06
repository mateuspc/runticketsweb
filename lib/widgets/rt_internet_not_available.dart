import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RtInternetNotAvailableWidget extends StatelessWidget {

  final VoidCallback onTryAgain;

  const RtInternetNotAvailableWidget({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text("Sem conexão com a internet", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    const Center(
                      child: Text('Verifique sua conexão com a internet e tente novamente.',
                        style: TextStyle(
                            fontSize: 14
                        ),
                        textAlign: TextAlign.center,),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        onTryAgain();
                      },
                      child: const Text('Tentar novamente',
                        style: TextStyle(
                            fontSize: 14
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
