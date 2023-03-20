
class ConnectionRequest
{
  final int connection_request_id;
  final int organization_id;
  final String reg_number;
  final DateTime date_begin;
  final DateTime? date_end;
  final String status;
  final String? add_info;

  ConnectionRequest ({required this.connection_request_id,required this.organization_id,required this.reg_number,required this.date_begin, this.date_end,required this.status,this.add_info});

  //Обрабатываем ответ из БД, формируем объект
  factory ConnectionRequest.fromReqBody(Map<String, dynamic> json){

    return ConnectionRequest(
        connection_request_id:json['connection_request_id'] as int,
        organization_id:json['organization_id'] as int,
        reg_number:json['reg_number'] as String,
        date_begin:json['date_begin'] as DateTime,
        date_end:json['date_end'] as DateTime?,
        status:json['status'] as String,
        add_info:json['add_info'] as String?
    );
  }

  void printAttributes() {
    print ("organization_id: ${this.connection_request_id}");
    print ("organization_id: ${this.organization_id}");
    print ("reg_number: ${this.reg_number}");
    print ("date_begin: ${this.date_begin}");
    print ("date_end: ${this.date_end}");
    print ("add_info: ${this.add_info}");
    print("add_info: ${this.add_info}");
  }
}