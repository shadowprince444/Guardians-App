import 'package:pet_adoption_app/data/models/response_wrapper.dart';

import '../../data/models/adoption_history.dart';

abstract class IAdoptionHistoryRepository {
  Future<ApiResponse<List<AdoptionHistory>>> getAdoptionHistory(
    int pageNumber,
  );
}
