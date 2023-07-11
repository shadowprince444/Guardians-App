part of 'get_paginated_pets_bloc.dart';

abstract class GetPaginatedPetListEvent extends Equatable {
  const GetPaginatedPetListEvent();

  @override
  List<Object> get props => [];
}

class GetPaginatedPetListInitialEvent extends GetPaginatedPetListEvent {}

class GetPaginatedPetListNextPageEvent extends GetPaginatedPetListEvent {
  final int page;

  const GetPaginatedPetListNextPageEvent(this.page);
}

class GetPaginatedPetListCategoryEvent extends GetPaginatedPetListEvent {
  final PetCategory petCategory;

  const GetPaginatedPetListCategoryEvent(this.petCategory);
}

class GetPaginatedPetListSearchEvent extends GetPaginatedPetListEvent {
  final String query;

  const GetPaginatedPetListSearchEvent(this.query);
}
