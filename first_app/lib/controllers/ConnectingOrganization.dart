import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/repository/ConnectionRequest.dart';
import 'package:first_app/repository/Organization.dart';

class ConnectingOrganizationController{
  final ConnectionRequestRepository _connectionRequestRepository = ConnectionRequestRepository(PionerDB());
  final OrganizationRepository _organizationRepository = OrganizationRepository(PionerDB());

  Future<int> postOrganization (String organization_full_name, String organization_short_name, String inn, String kpp, String ogrn, String responsible_person_surname, String responsible_person_name, String responsible_person_patronymic, String responsible_person_email, String responsible_person_phone_number, String? add_info){
    return _organizationRepository.postOrganization(organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info);
  }

  Future<int> postConnectionRequest(int organization_id, String reg_number, DateTime date_begin, String status){
    return _connectionRequestRepository.postConnectionRequest(organization_id, reg_number, date_begin, status);
  }

  Future<int> UpdateOrganization (String organization_full_name, String organization_short_name, String inn, String kpp, String ogrn, String responsible_person_surname, String responsible_person_name, String responsible_person_patronymic, String responsible_person_email, String responsible_person_phone_number, String? add_info){
    return _organizationRepository.UpdateOrganization(organization_full_name, organization_short_name, inn, kpp, ogrn, responsible_person_surname, responsible_person_name, responsible_person_patronymic, responsible_person_email, responsible_person_phone_number, add_info);
  }

  Future<int> UpdateConnectionRequest(int connection_request_id, String status, DateTime date_end){
    return _connectionRequestRepository.UpdateConnectionRequest(connection_request_id, status, date_end);
  }

  Future<int> UpdateConnectionRequestNotDate(int connection_request_id, String status){
    return _connectionRequestRepository.UpdateConnectionRequesNotTime(connection_request_id, status);
  }


  Future<Organization> getOrganizationByID(int id) async{
    return _organizationRepository.getOrganizationByID(id);
  }

  Future<ConnectionRequest> getConnectionRequestByID(int organization_id) async{
    return _connectionRequestRepository.getConnectionRequestByID(organization_id);
  }

  Future<List<ConnectionRequest>> getAllConnectionRequest() async{
    return _connectionRequestRepository.getAllConnectionRequest();
  }


}