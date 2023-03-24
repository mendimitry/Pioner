import 'package:first_app/models/ServiceRequest.dart';

abstract class IServiceRequestRepository{
  Future<List<ServiceRequest>> getAllServiceRequest();

  Future<ServiceRequest> getServiceRequestByID(int ID);

  Future<ServiceRequest> getServiceRequestByCustomerID(int ID);

  Future<int> postServiceRequest(int customer_id, int organization_id, DateTime date_service, add_info);
}