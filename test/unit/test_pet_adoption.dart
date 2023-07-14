import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/bloc/pet_adoption/pet_adoption_bloc.dart';
import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:faker/faker.dart';

import '../mocks/mock_paginated_pet_repository.dart';

void main() {
  final faker = Faker();

  group('PetAdoptionBloc', () {
    test('AdoptPetEvent updates the adopted pets list', () async {
      final petModelList = List.generate(
          10,
          (index) => PetModel(
                id: faker.guid.guid(),
                name: faker.animal.name(),
                age: faker.randomGenerator.integer(10),
                price: faker.randomGenerator.integer(500),
                character: faker.lorem.word(),
                type: faker.lorem.word(),
                imageURL: faker.image.image(),
                isAdopted: false,
                sex: faker.lorem.word(),
                color: faker.lorem.word(),
              ));

      late MockPetRepository mockPetRepository =
          MockPetRepository(petModelList);
      late PetAdoptionBloc petAdoptionBloc = PetAdoptionBloc(mockPetRepository);

      final petModel = petModelList[0];
      final tag = faker.lorem.word();
      expect(petAdoptionBloc.isAdopted(petModel), false);

      petAdoptionBloc.add(AdoptPetEvent(petModel, tag: tag));

      // Wait for the state to be updated
      await expectLater(
        petAdoptionBloc.stream,
        emitsInOrder([
          isA<PetAdoptionLoadingState>(),
          isA<PetAdoptedState>(),
        ]),
      );
      expect(petAdoptionBloc.isAdopted(petModel), true);
      petAdoptionBloc.close();
    });

    test('GetAdoptionListEvent updates the adopted pets list', () async {
      final petModelList = List.generate(
          10,
          (index) => PetModel(
                id: faker.guid.guid(),
                name: faker.animal.name(),
                age: faker.randomGenerator.integer(10),
                price: faker.randomGenerator.integer(500),
                character: faker.lorem.word(),
                type: faker.lorem.word(),
                imageURL: faker.image.image(),
                isAdopted: index % 2 == 0,
                sex: faker.lorem.word(),
                color: faker.lorem.word(),
              ));

      late MockPetRepository mockPetRepository =
          MockPetRepository(petModelList);
      late PetAdoptionBloc petAdoptionBloc = PetAdoptionBloc(mockPetRepository);

      petAdoptionBloc.add(GetAdoptionListEvent());
      await expectLater(
        petAdoptionBloc.stream,
        emitsInOrder([
          isA<PetAdoptionLoadingState>(),
          isA<PetAdoptionListLoadedState>(),
        ]),
      );
      final currentState = petAdoptionBloc.state;
      expect(currentState, isA<PetAdoptionListLoadedState>());
      final loadedState = currentState as PetAdoptionListLoadedState;
      expect(loadedState.list.length, 5);
      petAdoptionBloc.close();
    });
  });
}
