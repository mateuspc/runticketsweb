import 'package:flutter/material.dart';

class PageLoading extends StatefulWidget {

  const PageLoading({super.key});

  @override
  State<PageLoading> createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 90,
            height: 90,
            child: Image.asset("assets/loading/blue_loading.gif")
        ),
      ),
    );
  }


}
