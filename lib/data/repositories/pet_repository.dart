import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository_interfaces/pet.dart';
import '../models/pet_model.dart';
import '../models/response_wrapper.dart';

class PetRepositoryImpl implements IPetRepository {
  static const paginationLimit = 5;
  late FirebaseFirestore _firestore;

  // Since firebase doen't support pagination with number like ordinary API end points,
  // We need to store the last fetched document and store it here.
  // Since it's a singleton class and it's being only used by HomeBloc, we can ensure that the value is not being changed from else where.
  static DocumentSnapshot? lastDocumentSnapshot;

  static final PetRepositoryImpl _instance = PetRepositoryImpl._internal();

  factory PetRepositoryImpl(FirebaseFirestore firestore) {
    _instance._firestore = firestore;
    return _instance;
  }

  PetRepositoryImpl._internal();

  @override
  Future<ApiResponse<List<PetModel>>> getAllPets() async {
    try {
      final snapshot = await _firestore.collection('pets').get();
      final pets =
          snapshot.docs.map((doc) => PetModel.fromMap(doc.data())).toList();
      return ApiResponse.completed(pets);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllCategoryPetsPaginated(
      int pageNumber) async {
    final snapshot = pageNumber != 0
        ? await _firestore
            .collection('pets')
            .orderBy('name')
            .startAfterDocument(lastDocumentSnapshot!)
            .limit(paginationLimit)
            .get()
        : await _firestore
            .collection('pets')
            .orderBy('name')
            .limit(paginationLimit)
            .get();
    return snapshot;
  }

  @override
  Future<ApiResponse<List<PetModel>>> getAllAdoptedPets() async {
    try {
      final snapshot = await _firestore
          .collection('pets')
          .where('isAdopted', isEqualTo: true)
          .get();
      final pets =
          snapshot.docs.map((doc) => PetModel.fromMap(doc.data())).toList();
      return ApiResponse.completed(pets);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<String> adoptPet(PetModel petModel) async {
    try {
      final petRef = _firestore.collection('pets').doc(petModel.id);
      await petRef.update({'isAdopted': true});
      return petModel.id;
    } catch (e) {
      throw Exception('Failed to adopt pet: $e');
    }
  }

  @override
  Future<ApiResponse<PetModel>> getPetById(int petId) async {
    try {
      final snapshot =
          await _firestore.collection('pets').doc(petId.toString()).get();
      final pet = PetModel.fromMap(convertFirestoreDocToJson(snapshot));
      return ApiResponse.completed(pet);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Map<String, dynamic> convertFirestoreQueryDocToJson(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return {
      ...data,
      'id': snapshot.id,
    };
  }

  Map<String, dynamic> convertFirestoreDocToJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return {
      ...data!,
      'id': snapshot.id,
    };
  }

  @override
  Future<ApiResponse<List<PetModel>>> getNextPageListByCategory(
      int pageNumber, String category) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> snapshot;
      if (category != "All") {
        snapshot = await getPetsByCategory(pageNumber, category);
      } else {
        snapshot = await getAllCategoryPetsPaginated(pageNumber);
      }
      List<PetModel> pets = [];
      if (snapshot.docs.isNotEmpty) {
        pets = snapshot.docs
            .map((doc) => PetModel.fromMap(convertFirestoreQueryDocToJson(doc)))
            .toList();
        lastDocumentSnapshot = snapshot.docs.last;
      }
      return ApiResponse.completed(pets);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPetsByCategory(
      int pageNumber, String category) async {
    CollectionReference petsCollection = _firestore.collection('pets');

    QuerySnapshot? snapshot;
    if (pageNumber != 0) {
      // Fetch the next page of records starting after the lastDocumentSnapshot
      snapshot = await petsCollection
          .where('species', isEqualTo: category)
          .orderBy('name')
          .startAfterDocument(lastDocumentSnapshot!)
          .limit(paginationLimit)
          .get();
    } else {
      // Fetch the first page of records
      snapshot = await petsCollection
          .where('species', isEqualTo: category)
          .orderBy('name')
          .limit(paginationLimit)
          .get();
    }
    return snapshot as QuerySnapshot<Map<String, dynamic>>;
  }
}
