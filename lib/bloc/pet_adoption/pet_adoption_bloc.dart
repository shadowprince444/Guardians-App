import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/enums.dart';

import '../../data/models/pet_model.dart';
import '../../domain/repository_interfaces/pet.dart';

part 'pet_adoption_event.dart';

part 'pet_adoption_state.dart';

class PetAdoptionBloc extends Bloc<PetAdoptionEvent, PetAdoptionState> {
  final IPetRepository _petRepository;
  final Map<String, PetModel> _adoptedPetsList = {};

  PetAdoptionBloc(this._petRepository) : super(PetAdoptionInitialState()) {
    on<AdoptPetEvent>((event, emit) async {
      emit(PetAdoptionLoadingState());
      final petModel = event.petModel;
      final tag = event.tag;
      await _petRepository.adoptPet(petModel);
      emit(PetAdoptedState(petModel, tag: tag));
      add(GetAdoptionListEvent());
    });

    on<CheckAdoptionEvent>((event, emit) async {
      emit(PetAdoptionLoadingState());
      final petId = event.petId;
      final result = await _petRepository.getPetById(petId);
      if (result.status == ApiResponseStatus.error || result.data == null) {
        emit(PetAdoptionErrorState());
      } else {
        emit(PetAlreadyAdoptedState(result.data!));
      }
    });

    on<GetAdoptionListEvent>((event, emit) async {
      emit(PetAdoptionLoadingState());
      final result = await _petRepository.getAllAdoptedPets();
      if (result.status == ApiResponseStatus.error || result.data == null) {
        emit(PetAdoptionErrorState());
      } else {
        _adoptedPetsList.clear();
        for (final petModel in result.data!) {
          _adoptedPetsList[petModel.id] = petModel;
        }
        emit(PetAdoptionListLoadedState(result.data!));
      }
    });
  }

  bool isAdopted(PetModel petModel) {
    return _adoptedPetsList.keys.contains(petModel.id);
  }
}
