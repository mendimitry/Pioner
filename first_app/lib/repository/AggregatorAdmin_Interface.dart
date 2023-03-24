import '../models/ConnectionRequest.dart';

abstract class IAggregatorAdminRepository{


  Future<List<ConnectionRequest>> getAllAdminka();

}