class AggregatorSpecialist{
  final int aggregator_specialists_id;
  final String aggregator_specialist_surname;
  final String aggregator_specialist_name;
  final String aggregator_specialists_department;
  final String aggregator_specialists_position;
  final String aggregator_specialists_phone_number;
  final String? add_info;

  AggregatorSpecialist({required this.aggregator_specialists_id,required this.aggregator_specialist_surname,required this.aggregator_specialist_name,
    required this.aggregator_specialists_department,required this.aggregator_specialists_position,required this.aggregator_specialists_phone_number, this.add_info});

  factory AggregatorSpecialist.fromReqBody(Map<String, dynamic> json){
    return AggregatorSpecialist(
      aggregator_specialists_id:json['aggregator_specialists_id'] as int,
      aggregator_specialist_surname:json['aggregator_specialist_surname'] as String,
      aggregator_specialist_name:json['aggregator_specialist_name'] as String,
      aggregator_specialists_department:json['aggregator_specialists_department'] as String,
      aggregator_specialists_position:json['aggregator_specialists_position'] as String,
      aggregator_specialists_phone_number:json['aggregator_specialists_phone_number'] as String,
      add_info:json['add_info'] as String?,
    );
  }

  void printAttributes() {
    print ("aggregator_specialist_id: ${this.aggregator_specialists_id}");
    print ("aggregator_specialist_surname: ${this.aggregator_specialist_surname}");
    print ("aggregator_specialist_name: ${this.aggregator_specialist_name}");
    print ("aggregator_specialists_department: ${this.aggregator_specialists_department}");
    print ("aggregator_specialists_position: ${this.aggregator_specialists_position}");
    print ("aggregator_specialists_phone_number: ${this.aggregator_specialists_phone_number}");
    print ("add_info: ${this.add_info}");
  }
}