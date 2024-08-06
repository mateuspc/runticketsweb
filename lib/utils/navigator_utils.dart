
  import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/routes/app_routes.dart';

Future<Map<String, dynamic>?> navigator(BuildContext context, res) async {
    if(res?["route"] != null){
      Future.delayed(Duration.zero, (){
        context.go(res?["route"]);
      });

    }else{
      Future.delayed(Duration.zero, (){
        context.go(AppRoutes.pageDashboard);
      });
    }
    return res;
  }