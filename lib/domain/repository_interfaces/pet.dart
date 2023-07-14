import '../../data/models/pet_model.dart';
import '../../data/models/response_wrapper.dart';

abstract class IPetRepository {
  Future<ApiResponse<List<PetModel>>> getAllPets();

  Future<ApiResponse<List<PetModel>>> getNextPageListByCategory(
      int pageNumber, String category);

  Future<ApiResponse<List<PetModel>>> getAllAdoptedPets();

  Future<ApiResponse<String>> adoptPet(PetModel petModel);

  Future<ApiResponse<PetModel>> getPetById(int petId);
}
