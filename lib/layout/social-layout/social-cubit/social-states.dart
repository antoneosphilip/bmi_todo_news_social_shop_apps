import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

abstract class shoplayoutstates{}
class shoplayoutintialstates extends shoplayoutstates{}
class shoploadingstates extends shoplayoutstates{}
class shoplayoutsucessstates extends shoplayoutstates{}
class shoplayoutgetdatesucessstates extends shoplayoutstates{}
class shoplayoutgetdateerrorstates extends shoplayoutstates{}

class shoplayoutugetuserloadingtates extends shoplayoutstates{}
class shoplayoutuindexloadingtates extends shoplayoutstates{}

class shoplayoutugetuserpostsuccesstates extends shoplayoutstates{}

class shoplayoutugetusersucceesstates extends shoplayoutstates{}
class shoplayoutugetusererrortates extends shoplayoutstates{}


class shoplayouterrorstates extends shoplayoutstates{}
class shoplayoutbottomsheetstates extends shoplayoutstates{}
class shoplayoutaddpoststates extends shoplayoutstates{}
class shoplayoutprofilesuccessstates extends shoplayoutstates{}
class shoplayoutprofileerroetates extends shoplayoutstates{}
class shoplayoutcovererroetates extends shoplayoutstates{}
class shoplayoutuploadprofileerroetates extends shoplayoutstates{}
class shoplayoutuoloadcovererroetates extends shoplayoutstates{}
class shoplayoutuploadprofilesuccesstates extends shoplayoutstates{}
class shoplayoutuoloadcoversuccesstates extends shoplayoutstates{}
class shoplayoutuupateusersuccesstates extends shoplayoutstates{}
class shoplayoutuupateuserloadingstates extends shoplayoutstates{}

class shoplayoutuupateusererrorstates extends shoplayoutstates{}
class shoplayoutuloadingprofiletates extends shoplayoutstates{}

class shoplayoutuloadingcovertates extends shoplayoutstates{}

class shoplayoutuploadpostloadingtates extends shoplayoutstates{}

class shoplayoutucreatepostloadingstates extends shoplayoutstates{}
class shoplayoutuppostsuccesstates extends shoplayoutstates{}
class shoplayoutuploadposterroestates extends shoplayoutstates{
  final String error;
  shoplayoutuploadposterroestates(this.error);
}
class shoplayoutugetusersoadingstates extends shoplayoutstates{}
class shoplayoutugetuserssuccesstates extends shoplayoutstates{}
class shoplayoutgetuserserroestates extends shoplayoutstates{
  final String error;
  shoplayoutgetuserserroestates(this.error);
}
class shoplayoutuclosephotostates extends shoplayoutstates{}
class shoplayoutlikeostsuccesstates extends shoplayoutstates{}
class shoplayoutlikeverseostsuccesstates extends shoplayoutstates{}

class shoplayoutuplikepostterroestates extends shoplayoutstates {
  final String error;

  shoplayoutuplikepostterroestates(this.error);

}
class shoplayoutlikeotruesuccesstates extends shoplayoutstates{}
class shoplayoutlikefalsetates extends shoplayoutstates{}
class shoplayoutlikelovetates extends shoplayoutstates{}
class shoplayoutconnebtlovetates extends shoplayoutstates{}
class shoplayoutcommentlovetates extends shoplayoutstates{}
class shoplayoutcommenttlovetates extends shoplayoutstates{}
class shoplayoutcommenterrortlovetates extends shoplayoutstates{}



class shoplayoutlikeo1successtates extends shoplayoutstates{}
class shoplayoutlike2successtates extends shoplayoutstates{}
class shoplayoutlike3successtates extends shoplayoutstates{}
class shoplayoutlike4successtates extends shoplayoutstates{}
//message
class shoplayoutsendmessagesuccesstates extends shoplayoutstates{}
class shoplayoutsendmessageerrorsstates extends shoplayoutstates{}
class shoplayoutrecievemessageuccesstates extends shoplayoutstates{}
class shoplayoutrecievemessageerrortates extends shoplayoutstates{}
class shoplayoutgetemessageerrortates extends shoplayoutstates{}

class shoplayoutulikeuccesstates extends shoplayoutstates{}
class shoplayoutlikeloadingstates extends shoplayoutstates{}
class shoplayoutlike2states extends shoplayoutstates{}
class shoplayoutlike3states extends shoplayoutstates{}
class shoplayoutlike4states extends shoplayoutstates{}
class shoplayoutsendmessagemodeksuccessstates extends shoplayoutstates{}
class shoplayoutsendmessageerrorstates extends shoplayoutstates{}
class shoplayoutsendtokenrrorstates extends shoplayoutstates{}
class shoplayoutsendlikestates extends shoplayoutstates{}
class shoplayoutuuuutates extends shoplayoutstates{}
class shoplayoutcccctates extends shoplayoutstates{}
class shoplayouposttates extends shoplayoutstates{}







