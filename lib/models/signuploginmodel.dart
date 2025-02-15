class signuploginmodel
{
   bool status  ;
   signuploginmodel({required this.status});
   factory signuploginmodel.fromjson(Map<String,dynamic> json)
   {
      return signuploginmodel(status: json['status']);
   }
}
