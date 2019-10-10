import 'package:jy_h5/api/login.api.dart';
import 'package:provider/provider.dart';
import 'model/loginModel.dart';



final List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider(builder: (context) => Login()),
];