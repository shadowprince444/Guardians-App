part of 'pet_adoption_bloc.dart';

abstract class PetAdoptionEvent extends Equatable {}

class AdoptPetEvent extends PetAdoptionEvent {
  final PetModel petModel;
  final String tag;

  AdoptPetEvent(this.petModel, {this.tag = ""});

  @override
  List<Object?> get props => [];
}

class ClearAdoptionListEvent extends PetAdoptionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAdoptionListEvent extends PetAdoptionEvent {
  @override
  List<Object?> get props => [];
}
