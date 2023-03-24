import 'package:first_app/models/TypeOfService.dart';

abstract class ITypeOfServiceRepository{

  Future<List<TypeOfService>> getAllTypeOfService();
  Future<TypeOfService> getTypeOfServiceByID(int type_id);
  Future<int> postTypeOfService(String type_code,String type_name);
}