class categorymodel{
  bool ?status;
  categorydata? data;
  categorymodel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    data=categorydata.fromjson(json['data']);

  }

}
class categorydata{
int ?currentpage;
List<datamodel> ?data=[];
categorydata.fromjson(Map<String,dynamic> json){
  currentpage=json['current_page'];
json['data'].forEach((element){
  data?.add(datamodel.fromjson(element));
});
}

}
class datamodel{
  int? id;
  String?name;
  String?image;
  datamodel.fromjson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }

}