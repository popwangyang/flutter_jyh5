import '../view/indexpage/IndexPage.dart';
import '../view/forgetPasswordPage/index.dart';
import '../view/404/index.dart';
import '../view/shanghu/components/detail/detail.dart';

// 商户模型
import '../model/merchant.dart';

final routes = {
  'indexPage': (context) => new IndexPage(),
  'forgetPasswordPage': (context) => new ForgetPassWord(),
  'error_404': (context) => new ErrorPage(),
  'merchantDetail': (context) => new MerchantDetail(),
};