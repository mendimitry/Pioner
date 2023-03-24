import 'package:first_app/models/AggregatorSpecialist.dart';

abstract class IAggregatorSpecialistRepository{
  Future<List<AggregatorSpecialist>> getAllAggregatorSpecialists();

  Future<AggregatorSpecialist> getAggregatorSpecialistByID(int ID);

  Future<AggregatorSpecialist> getAggregatorSpecialistByPhoneNumber(String phoneNumber);

  Future<int> postAggregatorSpecialist(String aggregator_specialist_surname,String aggregator_specialist_name,
      String aggregator_specialist_department,String aggregator_specialist_position,String aggregator_specialist_phone_number, String? add_info);
}