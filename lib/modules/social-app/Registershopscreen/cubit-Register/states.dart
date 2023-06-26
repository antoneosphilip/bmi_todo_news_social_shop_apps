
abstract class socialappregisterstates{}
class socialappregisterintialstates extends socialappregisterstates{}
class socialappregisterloadingstates extends socialappregisterstates{}
class socialappregistersucessstates extends socialappregisterstates{

}
class socialappregistererrorstates extends socialappregisterstates{
  final String error;
  socialappregistererrorstates(this.error);


}
class socialappcreateusersucessstates extends socialappregisterstates{
  final String uId;

  socialappcreateusersucessstates(this.uId);
}
class socialappcreateusererrorstates extends socialappregisterstates{
  final String error;
  socialappcreateusererrorstates(this.error);
}
class socialappregistericontates extends socialappregisterstates{}
class socialappgetusersuccesstates extends socialappregisterstates{}
class socialappgetusererrortates extends socialappregisterstates{}
class socialapplike11tates extends socialappregisterstates{}
class socialapplike2ates extends socialappregisterstates{}
class socialtokensates extends socialappregisterstates{}





