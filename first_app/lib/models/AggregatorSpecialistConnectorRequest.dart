class AggregatorSpecialistConnectorRequest{
  final int aggregator_specialist_connector_request_id;
  final int aggregator_specialists_id;
  final int connection_request_id;


  AggregatorSpecialistConnectorRequest({required this.aggregator_specialist_connector_request_id,required this.aggregator_specialists_id,required this.connection_request_id});

  factory AggregatorSpecialistConnectorRequest.fromReqBody(Map<String, dynamic> json){
    return AggregatorSpecialistConnectorRequest(
      aggregator_specialist_connector_request_id:json['aggregator_specialist_connector_request_id'] as int,
      aggregator_specialists_id:json['aggregator_specialists_id'] as int,
      connection_request_id:json['connection_request_id'] as int,
    );
  }

  void printAttributes() {
    print ("aggregator_specialist_connector_request_id: ${this.aggregator_specialist_connector_request_id}");
    print ("aggregator_specialists_id: ${this.aggregator_specialists_id}");
    print ("connection_request_id: ${this.connection_request_id}");
  }
}