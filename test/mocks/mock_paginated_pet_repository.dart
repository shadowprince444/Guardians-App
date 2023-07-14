import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:pet_adoption_app/data/models/response_wrapper.dart';
import 'package:pet_adoption_app/domain/repository_interfaces/pet.dart';

class MockPetRepository implements IPetRepository {
  final List<PetModel> completeList;
  MockPetRepository(this.completeList);
  @override
  Future<ApiResponse<List<PetModel>>> getAllPets() async {
    return ApiResponse.completed(completeList);
  }

  @override
  Future<ApiResponse<List<PetModel>>> getNextPageListByCategory(
      int pageNumber, String category) async {
    if (pageNumber * 5 < completeList.length) {
      return ApiResponse.completed(
          completeList.sublist((pageNumber) * 5, (pageNumber * 5) + 5));
    } else {
      return ApiResponse.completed([]);
    }
  }

  @override
  Future<ApiResponse<List<PetModel>>> getAllAdoptedPets() async {
    return ApiResponse.completed(
        completeList.where((element) => element.isAdopted == true).toList());
  }

  @override
  Future<ApiResponse<String>> adoptPet(PetModel petModel) async {
    try {
      List<PetModel> templist = completeList
          .map((e) => e.id == petModel.id ? e.copyWith(isAdopted: true) : e)
          .toList();
      completeList.clear();
      completeList.addAll(templist);
      return ApiResponse.completed(petModel.id);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<PetModel>> getPetById(int petId) async {
    return ApiResponse.completed(const PetModel(
      id: '',
      name: '',
      age: 0,
      price: 0,
      character: '',
      type: '',
      imageURL: '',
      isAdopted: false,
      sex: '',
      color: '',
    ));
  }
}
