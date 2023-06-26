
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

abstract class socialappstates{}
class socialappintialstates extends socialappstates{}
class socialapploadingstates extends socialappstates{}
class socialappsucessstates extends socialappstates{
final String uId;

socialappsucessstates(this.uId);
}
class socialapperrorstates extends socialappstates{
  final String error;
  socialapperrorstates(this.error);
  
}
class socialappicontates extends socialappstates{}
class socialintialtates extends socialappstates{}

class socialcreateusersuccesstates extends socialappstates{}
class socialcreateusererrortates extends socialappstates{}
class socialsendtokenlogintates extends socialappstates{}




