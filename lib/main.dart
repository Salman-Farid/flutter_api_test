import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/controllers/category_controller.dart';
import 'package:karmalab_assignment/screens/authentication/select_auth/select_auth_view.dart';
import 'package:karmalab_assignment/services/hive_service.dart';
import 'package:karmalab_assignment/theme/theme.dart';
import 'package:karmalab_assignment/utils/route_util.dart';
import 'controllers/mainscreen_controller.dart';
import 'controllers/oerder_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/review_controller.dart';
import 'controllers/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  Get.put(hiveService);
  Get.lazyPut(()=>ProductReviewController());
  Get.lazyPut(()=>MainController());
  Get.put(UserController());
  Get.lazyPut(()=>CategoryController());
  Get.lazyPut(()=>OrderController());
  //Get.put(DashboardController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(
      //   canvasColor: Colors.white, // Sets the background color of the app
      //   fontFamily: 'Roboto',
      //   primaryColor: primaryColor,

      // ),
      //themeMode: ThemeMode.system,
      title: 'BabutHut vendor',
      initialRoute: SelectAuthView.routeName,
      getPages: RouteUtil.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
    );
  }
}
