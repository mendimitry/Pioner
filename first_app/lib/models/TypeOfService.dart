class TypeOfService{
  final int type_id;
  final String type_code;
  final String type_name;

  TypeOfService({required this.type_id, required this.type_code,required this.type_name});

  factory TypeOfService.fromReqBody(Map<String, dynamic> json){
    return TypeOfService(
      type_id:json['type_id'] as int,
      type_code:json['type_code'] as String,
      type_name:json['type_name'] as String,
    );
  }

  void printAttributes() {
    print ("type_id: ${this.type_id}");
    print ("type_code: ${this.type_code}");
    print ("type_name: ${this.type_name}");
  }
}
