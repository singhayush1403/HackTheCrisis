import 'package:hackthecause/Verified.dart';
import 'package:hackthecause/auth/authController.dart';
import 'package:hackthecause/auth/views/login_page.dart';
import 'package:hackthecause/auth/views/phoneVerification.dart';
import 'package:hackthecause/auth/views/signUpStep1.dart';
import 'package:hackthecause/auth/views/signUpStep2.dart';
import 'package:hackthecause/auth/views/signUpStep3.dart';
import 'package:hackthecause/dashboard/dashboard.dart';
import 'package:hackthecause/dashboard/fund_details.dart';
import 'package:hackthecause/general/eligibilityInvestment.dart';
import 'package:hackthecause/general/eligibilitySector.dart';
import 'package:hackthecause/general/guidelines.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      isLoggingEnabled: true,
    ),
  );

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: "/login",
        builder: (context, args, params) {
          return LoginPage();
        },
      ),
      SailorRoute(
        name: "/signUp1",
        builder: (context, args, params) {
          return SignUpStep1();
        },
      ),
      SailorRoute(
        name: "/signUp2",
        builder: (context, args, params) {
          return SignUpStep2();
        },
      ),
      SailorRoute(
        name: "/phoneVerify",
        builder: (context, args, params) {
          return ChangeNotifierProvider(
              create: (context) => AuthController(),
              child: PhoneVerification());
        },
      ),
      SailorRoute(
        name: "/signUp3",
        builder: (context, args, params) {
          return SignUpStep3();
        },
      ),
      SailorRoute(
        name: "/dashBoard",
        builder: (context, args, params) {
          return DashBoard();
        },
      ),
      SailorRoute(
        name: "/verified",
        builder: (context, args, params) {
          return VerifiedPage(
            isApplicable: false,
          );
        },
      ),
      SailorRoute(
          name: "/funds",
          builder: (context, args, params) {
            return FundDetails();
          }),
      SailorRoute(
        name: "/guidelines",
        builder: (context, args, params) {
          return GuideLines();
        },
      ),
      SailorRoute(
        name: "/eliSector",
        builder: (context, args, params) {
          return EligibilitySector();
        },
      ),
      SailorRoute(
          name: "/eliInvestment",
          builder: (context, args, params) {
            return EligibilityInvestment(
              sector: params.param<String>('sector'),
            );
          },
          params: [SailorParam<String>(name: 'sector', defaultValue: 'other')]),
    ]);
  }
}
