import 'package:first_app/models/ServiceRequestDetail.dart';

abstract class IServiceRequestDetailRepository{
  Future<List<ServiceRequestDetail>> getAllServiceRequestDetail();

  Future<ServiceRequestDetail> getServiceRequestDetailByID(int ID);

  Future<ServiceRequestDetail> getServiceRequestDetailByRequestID(int ID);

  Future<int> postServiceRequestDetail(int service_request_detail_id, int service_request_id, int service_detail_id);
}