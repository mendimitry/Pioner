class Address{
  final int address_id;
  final int organization_id;
  final int address_type_id;
  final String subject_name;
  final String city_name;
  final String street_name;
  final String house_number;
  final String? add_info;

  Address({required this.address_id,required this.organization_id,required this.address_type_id,
    required this.subject_name,required this.city_name,required this.street_name,required this.house_number, this.add_info});

  factory Address.fromReqBody(Map<String, dynamic> json){
    return Address(
      address_id:json['address_id'] as int,
      organization_id:json['organization_id'] as int,
      address_type_id:json['address_type_id'] as int,
      subject_name:json['subject_name'] as String,
      city_name:json['city_name'] as String,
      street_name:json['street_name'] as String,
      house_number:json['house_number'] as String,
      add_info:json['add_info'] as String?,
    );
  }

  void printAttributes() {
    print ("address_id: ${this.address_id}");
    print ("organization_id: ${this.organization_id}");
    print ("address_type_id: ${this.address_type_id}");
    print ("subject_name: ${this.subject_name}");
    print ("city_name: ${this.city_name}");
    print ("street_name: ${this.street_name}");
    print ("house_number: ${this.house_number}");
    print ("add_info: ${this.add_info}");
  }
}