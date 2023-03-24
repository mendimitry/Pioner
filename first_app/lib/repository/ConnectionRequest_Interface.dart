import 'package:first_app/models/ConnectionRequest.dart';

abstract class IConnectionRequestRepository{
  Future<List<ConnectionRequest>> getAllConnectionRequest();

  Future<ConnectionRequest> getConnectionRequestByID(int organization_id);

  Future<int> postConnectionRequest(int organization_id,String reg_number,DateTime date_begin,String status);
}