part of 'get_paginated_pets_bloc.dart';

abstract class GetPaginatedPetListState extends Equatable {
  const GetPaginatedPetListState();

  @override
  List<Object> get props => [];
}

class GetPaginatedPetListInitialState extends GetPaginatedPetListState {}

class GetPaginatedPetListLoading extends GetPaginatedPetListState {
  final List<PetModel> modelList;

  const GetPaginatedPetListLoading(this.modelList);

  @override
  List<Object> get props => [modelList];
}

class GetPaginatedPetListLoaded extends GetPaginatedPetListState {
  final List<PetModel> modelList;

  const GetPaginatedPetListLoaded(this.modelList);

  @override
  List<Object> get props => [modelList];
}

class GetPaginatedPetListEmpty extends GetPaginatedPetListState {}

class GetPaginatedPetListError extends GetPaginatedPetListState {}
