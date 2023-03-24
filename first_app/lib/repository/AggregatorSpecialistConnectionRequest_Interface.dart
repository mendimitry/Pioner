import 'package:first_app/models/AggregatorSpecialistConnectorRequest.dart';

abstract class IAggregatorSpecialistConnectionRequestRepository{
  Future<List<AggregatorSpecialistConnectorRequest>> getAllAggregatorSpecialistConnectorRequest();

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByID(int ID);

  Future<AggregatorSpecialistConnectorRequest> getAggregatorSpecialistConnectorRequestByRequestID(int ID);

  Future<int> postAggregatorSpecialistConnectorRequest(int aggregator_specialists_id, int connection_request_id);
}