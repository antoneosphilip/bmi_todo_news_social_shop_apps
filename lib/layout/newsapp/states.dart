abstract class newsstates{}
class intialstate extends newsstates{}
class changestates extends newsstates{}
class newloadingscreen extends newsstates{}
class changebottomnav extends newsstates{}
class getdatasucess extends newsstates{}
class getdataerror extends newsstates{
  final String error;

  getdataerror(this.error);
}
class getdatasciencesucess extends newsstates{}
class getdatascienceerror extends newsstates{
  final String error;

  getdatascienceerror(this.error);
}
class getdatasportssucess extends newsstates{}
class getdatasportserror extends newsstates{
  final String error;

  getdatasportserror(this.error);
}
class getdatasearchssucess extends newsstates{}
class getdatasearcherror extends newsstates{
  final String error;

  getdatasearcherror(this.error);
}


