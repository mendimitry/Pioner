class ServiceRequestDetail{
  int service_request_detail_id;
  int service_request_id;
  int service_detail_id;

  ServiceRequestDetail({required this.service_request_detail_id, required this.service_request_id, required this.service_detail_id});

  factory ServiceRequestDetail.fromReqBody(Map<String, dynamic> json){
    return ServiceRequestDetail(
        service_request_detail_id:json['service_request_detail_id'] as int,
        service_request_id:json['service_request_id'] as int,
        service_detail_id:json['service_detail_id'] as int,
    );
  }
  void printAttributes() {
    print ("service_request_detail_id: ${this.service_request_detail_id}");
    print ("service_request_id: ${this.service_request_id}");
    print ("service_detail_id: ${this.service_detail_id}");
  }
}
