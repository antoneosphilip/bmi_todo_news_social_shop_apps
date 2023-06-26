import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/shop_app/model/favmodel.dart';

abstract class shoplayoutstates{}
class shopintialstate extends shoplayoutstates{}
class changebottonnavstate extends shoplayoutstates{}
class shopsuccess extends shoplayoutstates{}
class shoperroe extends shoplayoutstates{}
class shoploading extends shoplayoutstates{}
class changeiconfavorie extends shoplayoutstates{}
class categorymodelsucess extends shoplayoutstates{}
class categorymodelerror extends shoplayoutstates{}
class shopfavsuccess extends shoplayoutstates{
  final favmodel model;
  shopfavsuccess(this.model);

}

class shopfavsuccess1 extends shoplayoutstates{}
class faveoritemodelsucess extends shoplayoutstates{}
class faveoritemodelloading extends shoplayoutstates{}

class faveoritemodelerror extends shoplayoutstates{}
class profilemodelsucess extends shoplayoutstates{}
class profilemodelloading extends shoplayoutstates{}

class profilemodelerror extends shoplayoutstates{}
class updateprofilemodelsucess extends shoplayoutstates{
  final shoploginmodel upmodel;

  updateprofilemodelsucess(this.upmodel);

}
class updateprofilemodelloading extends shoplayoutstates{}

class updateprofilemodelerror extends shoplayoutstates{}

class shopsearchloadingstateshop extends shoplayoutstates{}
class shopsearchsucessstateshop extends shoplayoutstates{}
class shopsearcherroestateshop extends shoplayoutstates{}







