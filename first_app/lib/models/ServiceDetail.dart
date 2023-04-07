class ServiceDetail{
  int service_detail_id;
  int type_id;
  String service_detail_code;
  String service_detail_name;
  int service_detail_cost;
  int service_detail_duration;
  String? add_info;

  ServiceDetail({required this.service_detail_id, required this.type_id, required this.service_detail_code, required this.service_detail_name, required this.service_detail_cost,
   required this.service_detail_duration,this.add_info});

  factory ServiceDetail.fromReqBody(Map<String, dynamic> json){
    return ServiceDetail(
      service_detail_id:json['service_detail_id'] as int,
      type_id:json['type_id'] as int,
      service_detail_code:json['service_detail_code'] as String,
      service_detail_name:json['service_detail_name'] as String,
      service_detail_cost:json['service_detail_cost'] as int,
      service_detail_duration:json['service_detail_duration'] as int,
      add_info:json['add_info'] as String?,
    );
  }

  void printAttributes() {
    print ("service_detail_id: ${this.service_detail_id}");
    print ("type_id: ${this.type_id}");
    print ("service_detail_code: ${this.service_detail_code}");
    print ("service_detail_name: ${this.service_detail_name}");
    print ("service_detail_cost: ${this.service_detail_cost}");
    print ("service_detail_duration: ${this.service_detail_duration}");
    print ("add_info: ${this.add_info}");
  }
}
