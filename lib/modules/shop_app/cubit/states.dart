import 'package:shopapp/model/model.dart';

abstract class shopstates{}
class shopintialstates extends shopstates{}
class shoploadingstates extends shopstates{}
class shopsucessstates extends shopstates{
  final shoploginmodel model;

  shopsucessstates(this.model);
}
class shoperrorstates extends shopstates{}
class shopicontates extends shopstates{}


