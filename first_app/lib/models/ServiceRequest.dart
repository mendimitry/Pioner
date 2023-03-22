class ServiceRequest{
  int service_request_id;
  int customer_id;
  int organization_id;
  DateTime date_service;
  String? add_info;

  ServiceRequest({required this.service_request_id, required this.customer_id, required this.organization_id, required this.date_service, this.add_info});

  factory ServiceRequest.fromReqBody(Map<String, dynamic> json){
    return ServiceRequest(
        service_request_id:json['service_request_id'] as int,
        customer_id:json['customer_id'] as int,
        organization_id:json['organization_id'] as int,
        date_service:json['date_service'] as DateTime,
        add_info:json['add_info'] as String?
    );
  }
  void printAttributes() {
    print ("service_request_id: ${this.service_request_id}");
    print ("customer_id: ${this.customer_id}");
    print ("organization_id: ${this.organization_id}");
    print ("date_service: ${this.date_service}");
    print ("add_info: ${this.add_info}");
  }
}
