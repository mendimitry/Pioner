class AddressType{
  final int address_type_id;
  final String address_type_name;
  final String? add_info;

  AddressType({required this.address_type_id, required this.address_type_name, this.add_info});

  factory AddressType.fromReqBody(Map<String, dynamic> json){
    return AddressType(
      address_type_id:json['address_type_id'] as int,
      address_type_name:json['address_type_name'] as String,
      add_info:json['add_info'] as String?,
    );
  }

  void printAttributes() {
    print ("address_type_id: ${this.address_type_id}");
    print ("address_type_name: ${this.address_type_name}");
    print ("add_info: ${this.add_info}");
  }
}
