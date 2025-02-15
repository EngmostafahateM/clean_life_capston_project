import 'package:dio/dio.dart';

class SignUpService {
  static Dio dio = Dio();

  static Future<void> addData(String name, String email, String password,
      String phone) async
  {
    Response response = await dio.post(
        "https://student.valuxapps.com/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone":phone
        }
    );
    print(response.data);
  }
}


