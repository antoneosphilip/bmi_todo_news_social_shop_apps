import 'package:shopapp/model/model.dart';

abstract class shopregisterstates{}
class shopregisterintialstates extends shopregisterstates{}
class shopregisterloadingstates extends shopregisterstates{}
class shopregistersucessstates extends shopregisterstates{
  final shoploginmodel model;

  shopregistersucessstates(this.model);
}
class shopregistererrorstates extends shopregisterstates{}
class shopregistericontates extends shopregisterstates{}


