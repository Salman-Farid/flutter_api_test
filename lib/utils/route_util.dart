import 'package:get/get.dart';
import 'package:karmalab_assignment/screens/order/widgets/orders_list.dart';
import '../screens/Dashboard/dashboard.dart';
import '../screens/authentication/forgot/forgot_password.dart';
import '../screens/authentication/login/login_view.dart';
import '../screens/authentication/new_password/new_password.dart';
import '../screens/authentication/select_auth/select_auth_view.dart';
import '../screens/authentication/siginup/signup_view.dart';
import '../screens/authentication/verification/verification_view.dart';
import '../screens/category/category_creation_screen.dart';
import '../screens/category/category_management_screen.dart';
import '../screens/eventManager/event_mangement.dart';
import '../screens/home/home.dart';
import '../screens/mainScreen/mainscreen.dart';
import '../screens/onboarding/onboarding_view.dart';
import '../screens/product/all_products.dart';
import '../screens/product/product_upload_screen.dart';
import '../screens/profile/profile_view.dart';
import '../screens/report/all_reports.dart';
import '../screens/review/product_review.dart';
import '../screens/splash/splash_view.dart';
import 'Bindings/category_bindings.dart';
import 'Bindings/dashboard_binding.dart';
import 'Bindings/fetchProductBindings.dart';
import 'Bindings/orderlist_binding.dart';
import 'Bindings/product_creation_screen_binding.dart';

class RouteUtil {
  static final routes = [
    GetPage(name: SplashView.routeName, page: () => const SplashView()),
    GetPage(name: OnboardingView.routeName, page: () => const OnboardingView()),
    GetPage(name: SelectAuthView.routeName, page: () => const SelectAuthView()),
    GetPage(name: SignUpView.routeName, page: () => SignUpView()),
    GetPage(name: LoginView.routeName, page: () => LoginView()),
    GetPage(name: ForgotPassWord.routeName, page: () => const ForgotPassWord()),
    GetPage(name: VerificationView.routeName, page: () => const VerificationView()),
    GetPage(name: Profile.routeName, page: () => Profile()),
    GetPage(name: ProductCreationScreen.routeName, page: () => ProductCreationScreen(), binding: ProductCreationScreenBinding(),),
    GetPage(name: ProductGridView.routeName, page: () => const ProductGridView(), binding: Fetchproductbindings(),),
    GetPage(name: CategorySubcategoryView.routeName, page: () => const CategorySubcategoryView(), binding: Categorybindings(),),
    GetPage(name: CategoryCreationScreen.routeName, page: () => CategoryCreationScreen(), binding: Categorybindings(),),
    GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen()), //binding:DashboardBinding()),
    GetPage(name: EventManagementScreen.routeName, page: () => EventManagementScreen()),//binding: BindingsBuilder(() {Get.lazyPut<EventManagementController>(() => EventManagementController());}),),
    GetPage(name: OrdersListItems.routeName, page: () => OrdersListItems(), binding: OrderlistBinding()),
    GetPage(name: MainScreen.routeName, page: () =>  MainScreen()),
    GetPage(name: AllReports.routeName, page: () =>  AllReports()),
    GetPage(name: HomeScreen.routeName, page: () =>  HomeScreen()),
    GetPage(name: NewPassWordView.routeName, page: () => const NewPassWordView()),
    GetPage(name: ProductReviewScreen.routeName, page: () => ProductReviewScreen()),
  ];
}
