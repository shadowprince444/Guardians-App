part of 'pet_adoption_bloc.dart';

abstract class PetAdoptionState {}

class PetAdoptionInitialState extends PetAdoptionState {}

class PetAdoptionLoadingState extends PetAdoptionState {}

class PetAdoptionErrorState extends PetAdoptionState {}

class PetAdoptedState extends PetAdoptionState {
  final PetModel petModel;
  final String tag;

  PetAdoptedState(this.petModel, {this.tag = ""});
}

class PetAlreadyAdoptedState extends PetAdoptionState {
  final PetModel petModel;

  PetAlreadyAdoptedState(this.petModel);
}

class PetAdoptionListLoadingState extends PetAdoptionState {}

class PetAdoptionListLoadedState extends PetAdoptionState {
  final List<PetModel> list;

  PetAdoptionListLoadedState(this.list);
}
