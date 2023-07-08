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
class shopshowmorestateshop extends shoplayoutstates{}
class shopaddstateshop extends shoplayoutstates{}
class shopremovetateshop extends shoplayoutstates{}

class shopcartsucessstateshop extends shoplayoutstates{}
class shopcarterroestateshop extends shoplayoutstates{}

class shopcartgetsucessstateshop extends shoplayoutstates{}
class shopcartgeterroestateshop extends shoplayoutstates{}
class cartsendemodelloading extends shoplayoutstates{}

class cartemodelloading extends shoplayoutstates{}


class change extends shoplayoutstates{}
class setquantitysucccess extends shoplayoutstates{}
class setquantityerror extends shoplayoutstates{}

class getquantitysucccess extends shoplayoutstates{}
class getquantityerror extends shoplayoutstates{}
class deletequantitysucccess extends shoplayoutstates{}
class deleteloading extends shoplayoutstates{}

class deleteindexsucccess extends shoplayoutstates{}

class deletequantityerror extends shoplayoutstates{}
class plusnumber extends shoplayoutstates{}
class orderindatabasesuccess extends shoplayoutstates{}
class orderindatabaseerror extends shoplayoutstates{}





