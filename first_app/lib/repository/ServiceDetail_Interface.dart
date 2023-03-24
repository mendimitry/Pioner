import 'package:first_app/models/ServiceDetail.dart';

abstract class IServiceDetailRepository{

  Future<List<ServiceDetail>> getAllServiceDetail();
  Future<ServiceDetail> getServiceDetailByID(int service_detail_id);
  Future<int> postServiceDetail(int type_id, String service_detail_code, String servoce_detail_name, int service_detail_cost,
      int service_detail_duration,String? add_info);
}