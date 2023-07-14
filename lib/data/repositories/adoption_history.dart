import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_adoption_app/data/models/response_wrapper.dart';

import '../../data/models/adoption_history.dart';
import '../../domain/repository_interfaces/adoption_history.dart';

class AdoptionHistoryRepository implements IAdoptionHistoryRepository {
  static const paginationLimit = 5;
  late FirebaseFirestore _firestore;

  // Since firebase doen't support pagination with number like ordinary API end points,
  // We need to store the last fetched document and store it here.
  // Since it's a singleton class, we can ensure that the value is not being changed from else where.
  static DocumentSnapshot? lastDocumentSnapshot;

  static final AdoptionHistoryRepository _instance =
      AdoptionHistoryRepository._internal();

  factory AdoptionHistoryRepository(FirebaseFirestore firestore) {
    _instance._firestore = firestore;
    return _instance;
  }

  AdoptionHistoryRepository._internal();

  @override
  Future<ApiResponse<List<AdoptionHistoryModel>>> getAdoptionHistory(
    int pageNumber,
  ) async {
    try {
      final snapshot = pageNumber == 0
          ? await _firestore
              .collection('adoptionHistory')
              .orderBy('adoptedTime', descending: true)
              .limit(paginationLimit)
              .get()
          : await _firestore
              .collection('adoptionHistory')
              .orderBy('adoptedTime', descending: true)
              .limit(paginationLimit)
              .startAfterDocument(lastDocumentSnapshot!)
              .get();

      List<AdoptionHistoryModel> historyList = [];
      if (snapshot.docs.isNotEmpty) {
        historyList = snapshot.docs
            .map((doc) => AdoptionHistoryModel.fromSnapshot(doc.data(), doc.id))
            .toList();
        lastDocumentSnapshot = snapshot.docs.last;
      }

      return ApiResponse.completed(historyList);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
