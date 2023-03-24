import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/repository/ConnectionRequest.dart';
import 'package:first_app/repository/Organization.dart';
import 'package:flutter/cupertino.dart';

class OrganizationRegisterController{
  final ConnectionRequestRepository _connectionRequestRepository = ConnectionRequestRepository(PionerDB());
  final OrganizationRepository _organizationRepository = OrganizationRepository(PionerDB());

  Future<Organization> getOrganizationByINNandOGRN(int inn, int ogrn){
    return _organizationRepository.getOrganizationByINNandOGRN(inn, ogrn);
  }

  Future<ConnectionRequest> getConnectionRequestByID(int organization_id){
    return _connectionRequestRepository.getConnectionRequestByID(organization_id);
  }
}