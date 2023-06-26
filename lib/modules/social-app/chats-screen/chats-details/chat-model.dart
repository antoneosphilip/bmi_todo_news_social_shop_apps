import 'dart:convert';

class chatmodel{
  String? senderid;
  String? date;
  String? recieverid;
  String? Text;



  chatmodel({

    this.senderid,
    this.date,
    this.recieverid,
    this.Text,

  });
  chatmodel.fromjson(Map<String,dynamic> json){
    senderid=json['senderid'];
    date=json['date'];
    recieverid=json['recieverid'];
    Text=json['Text'];


  }
  Map<String,dynamic>  tomap(){

return {
'senderid':senderid,
  'date':date,
  'recieverid':recieverid,
  'Text':Text,

};

  }



}