import 'package:pet_adoption_app/data/models/adoption_history.dart';
import 'package:pet_adoption_app/data/models/response_wrapper.dart';
import 'package:pet_adoption_app/domain/repository_interfaces/adoption_history.dart';

class MockAdoptionHistoryRepository implements IAdoptionHistoryRepository {
  final List<AdoptionHistoryModel> adoptionHistoryList;

  MockAdoptionHistoryRepository(this.adoptionHistoryList);

  @override
  Future<ApiResponse<List<AdoptionHistoryModel>>> getAdoptionHistory(
      int page) async {
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 1));

    // Calculate the starting index for pagination
    final startIndex = page * 5;

    // Calculate the ending index for pagination
    final endIndex = startIndex + 5;

    // Check if there are more pages to load
    List<AdoptionHistoryModel> pageList = [];
    if (endIndex < adoptionHistoryList.length) {
      // Slice the list based on the current page
      pageList = adoptionHistoryList.sublist(startIndex, endIndex);
    }

    // Return the sliced list with pagination information
    return ApiResponse.completed(pageList);
  }
}
