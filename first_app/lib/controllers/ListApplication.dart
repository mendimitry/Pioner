import 'package:first_app/data/PionerDBContext.dart';
import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/models/Organization.dart';
import 'package:first_app/pages/form_administrator/list_applications.dart';
import 'package:first_app/pages/form_organization/organization_register.dart';
import 'package:first_app/repository/ConnectionRequest.dart';
import 'package:first_app/repository/Organization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListApplicationController{
  final ConnectionRequestRepository _connectionRequestRepository = ConnectionRequestRepository(PionerDB());
  final OrganizationRepository _organizationRepository = OrganizationRepository(PionerDB());

  Future<List<ConnectionRequest>> getAllConnectionRequest() async{
    return _connectionRequestRepository.getAllConnectionRequest();
  }

  Future<ConnectionRequest> getConnectionRequestByID(int organization_id) async{
    return _connectionRequestRepository.getConnectionRequestByID(organization_id);
  }

  Future<Organization> getOrganizationByID(int id) async{
    return _organizationRepository.getOrganizationByID(id);
  }

  Container list_organization() {
    return Container(
      child: FutureBuilder<List<ConnectionRequest>>(
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // return: show loading widget
            }
            if (snapshot.hasError) {
              // return: show error widget
            }
            List<ConnectionRequest> users = snapshot.data ?? [];

            return ListView.builder(
                itemCount: users.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ConnectionRequest user = users[index];
                  return ListTile(
                    title: new Text('${user.reg_number}' +
                        "      " +
                        '${user.date_begin}' +
                        "      " +
                        '${user.organization_id}'),

                    onTap: () async {
                      organization = await getOrganizationByID(user.organization_id);
                      connectionRequest = await getConnectionRequestByID(user.organization_id);
                      await Navigator.pushReplacementNamed(
                          context, 'user_administrator',
                          arguments: [connectionRequest, organization]);
                    },
                  );
                });
          }),
    );
  }
}