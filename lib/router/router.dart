import '../view/indexpage/IndexPage.dart';
import '../view/forgetPasswordPage/index.dart';
import '../view/404/index.dart';
import '../view/login.dart';


final routes = {
  'indexPage': (context) => new IndexPage(),
  'forgetPasswordPage': (context) => new ForgetPassWord(),
  'error_404': (context) => new ErrorPage(),
  'login': (context) => new LoginPage(),
};