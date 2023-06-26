import 'package:shopapp/modules/shop_app/search-scrren/search-model/search-model.dart';

abstract class shopsearchstates{}
class shopsearchintialstate extends shopsearchstates{}

class shopsearchloadingstate extends shopsearchstates{}
class shopsearchsuccessstate extends shopsearchstates{}
class shopsearcherrorstate extends shopsearchstates{}
class shopsearchfavsucessstate extends shopsearchstates{
}
class shopsearchfaverroetate extends shopsearchstates{}
class faveoritemodelloadingsearch extends shopsearchstates{}
class faveoritemodelsucesssearch extends shopsearchstates{}
class faveoritemodelerroesearch extends shopsearchstates{}




