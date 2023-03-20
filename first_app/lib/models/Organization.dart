
class Organization
{
  final int organization_id;
  final String? organization_full_name;
  final String? organization_short_name;
  final String inn;
  final String kpp;
  final String ogrn;
  final String? responsible_person_surname;
  final String? responsible_person_name;
  final String?  responsible_person_patronymic;
  final String? responsible_person_email;
  final String responsible_person_phone_number;
  final String? add_info;

  Organization ({required this.organization_id,this.organization_full_name,this.organization_short_name, required this.inn,required this.kpp,required this.ogrn,this.responsible_person_surname,this.responsible_person_name,this.responsible_person_patronymic, this.responsible_person_email,required this.responsible_person_phone_number,this.add_info});

  //Обрабатываем ответ из БД, формируем объект
  factory Organization.fromReqBody(Map<String, dynamic> json){

    return Organization(
        organization_id:json['organization_id'] as int,
        organization_full_name:json['organization_full_name'] as String?,
        organization_short_name:json['organization_short_name'] as String?,
        inn:json['inn'] as String,
        kpp:json['kpp'] as String,
        ogrn:json['ogrn'] as String,
        responsible_person_surname:json['responsible_person_surname'] as String?,
        responsible_person_name:json['responsible_person_name'] as String?,
        responsible_person_patronymic:json['responsible_person_patronymic'] as String?,
        responsible_person_email:json['responsible_person_email'] as String?,
        responsible_person_phone_number:json['responsible_person_phone_number'] as String,
        add_info:json['add_info'] as String?
    );
  }

  void printAttributes() {
    print ("organization_id: ${this.organization_id}");
    print("organization_full_name: ${this.organization_full_name}");
    print("organization_short_name: ${this.organization_short_name}");
    print("inn: ${this.inn}");
    print("kpp: ${this.kpp}");
    print("ogrn: ${this.ogrn}");
    print("responsible_person_surname: ${this.responsible_person_surname}");
    print("responsible_person_name: ${this.responsible_person_name}");
    print("responsible_person_patronymic: ${this.responsible_person_patronymic}");
    print("responsible_person_email: ${this.responsible_person_email}");
    print("responsible_person_phone_number: ${this.responsible_person_phone_number}");
    print("add_info: ${this.add_info}");
  }
}