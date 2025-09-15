class CatDataModel{
  List<CatModel>? data;
  String? message;
  bool? status;

  CatDataModel({
    required this.data,
    required this.message,
    required this.status
});

  factory CatDataModel.fromJson(Map<String, dynamic> json)
  {
    List<CatModel>? mCats ;
    for(Map<String, dynamic> eachCat in  json['data'])
    {
      var eachModel = CatModel.fromJson(eachCat);
      mCats!.add(eachModel);
    }
    return CatDataModel(
        data: mCats ,
        message: json['message'],
        status: json['status']
    );
  }
}
class CatModel {
  String? id;
  String? name;
  String? status;
  String? created_at;
  String? updated_at;

  CatModel({
  required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at
});
 //fromJson

factory CatModel.fromJson(Map<String, dynamic> json)
{
  return CatModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at']
  );
}

}