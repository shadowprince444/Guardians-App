import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_adoption_app/utils/enums.dart';

import '../../data/models/pet_model.dart';
import '../../domain/repository_interfaces/pet.dart';
import '../../utils/functions.dart';

part 'get_paginated_pets_event.dart';
part 'get_paginated_pets_state.dart';

class GetPaginatedPetListBloc
    extends Bloc<GetPaginatedPetListEvent, GetPaginatedPetListState> {
  final IPetRepository _petRepository;
  final List<PetModel> _getPaginatedPetList = [];
  final List<PetModel> _currentGetPaginatedPetListByCategory = [];
  PetCategory currentSelected = PetCategory.all;
  bool shouldFetchMore = true;
  String? searchText;

  int currentPage = -1;

  GetPaginatedPetListBloc(this._petRepository)
      : super(GetPaginatedPetListInitialState()) {
    on<GetPaginatedPetListInitialEvent>((event, emit) async {
      currentSelected = PetCategory.all;
      searchText = "";
      add(const GetPaginatedPetListNextPageEvent(-1));
    });

    on<GetPaginatedPetListCategoryEvent>((event, emit) async {
      PetCategory petCategory = event.petCategory;
      if (petCategory != currentSelected) {
        currentSelected = petCategory;
        currentPage = -1;
        searchText = "";
        add(GetPaginatedPetListNextPageEvent(currentPage));
      }
    });

    on<GetPaginatedPetListSearchEvent>((event, emit) async {
      emit(GetPaginatedPetListLoading(_getPaginatedPetList));
      String query = event.query;
      searchText = query;
      List<PetModel> list = filterSearchText(_getPaginatedPetList);
      _emitLoadedState(emit, list);
    });

    on<GetPaginatedPetListNextPageEvent>((event, emit) async {
      if (event.page == -1) {
        _getPaginatedPetList.clear();
        if (!shouldFetchMore) {
          shouldFetchMore = true;
          _currentGetPaginatedPetListByCategory.clear();
        }
      }
      if (shouldFetchMore) {
        emit(GetPaginatedPetListLoading(_getPaginatedPetList));

        final result = await _petRepository.getNextPageListByCategory(
            ++currentPage, capitalizeEnumValue(currentSelected.toString()));

        if (result.status == ApiResponseStatus.error || result.data == null) {
          _emitLoadedState(
              emit, filterSearchText(_getListByCategory(currentSelected)));
        } else {
          final list = result.data!;
          _getPaginatedPetList.addAll(list);
          _setCurrentList(_getListByCategory(currentSelected));
          _emitLoadedState(emit, _getListByCategory(currentSelected));
        }
      }
    });
  }

  List<PetModel> filterSearchText(List<PetModel> list) {
    return list.where((element) {
      return element.name
          .toLowerCase()
          .contains(searchText?.toLowerCase() ?? "");
    }).toList();
  }

  int getCountByCategory(PetCategory category) {
    if (category == PetCategory.all) {
      return _getPaginatedPetList.length;
    } else {
      return _getPaginatedPetList.where((element) {
        return element.type.toLowerCase() == category.name.toLowerCase();
      }).length;
    }
  }

  bool isCurrentlySelected(PetCategory petCategory) {
    return currentSelected == petCategory;
  }

  _setCurrentList(List<PetModel> list) {
    _currentGetPaginatedPetListByCategory.clear();
    _currentGetPaginatedPetListByCategory.addAll(list);
  }

  _emitLoadedState(
      Emitter<GetPaginatedPetListState> emit, List<PetModel> list) {
    emit(GetPaginatedPetListLoaded(list));
  }

  List<PetModel> _getListByCategory(PetCategory petCategory) {
    List<PetModel> list = [];
    if (petCategory == PetCategory.all) {
      list = _getPaginatedPetList;
    } else {
      list = _getPaginatedPetList
          .where((element) =>
              element.type.toLowerCase() == petCategory.name.toLowerCase())
          .toList();
    }
    return list;
  }
}
