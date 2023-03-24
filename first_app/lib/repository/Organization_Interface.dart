import 'package:first_app/models/Organization.dart';

abstract class IOrganizationRepository{

  Future<List<Organization>> getAllOrganization();

  Future<Organization> getOrganizationByID(int id);

  Future<Organization> getOrganizationByINNandOGRN(int inn, int ogrn);

  Future<int> postOrganization(String organization_full_name,String organization_short_name,String inn,String kpp,String ogrn,String responsible_person_surname,String responsible_person_name,String responsible_person_patronymic, String responsible_person_email,String responsible_person_phone_number,String add_info);

}