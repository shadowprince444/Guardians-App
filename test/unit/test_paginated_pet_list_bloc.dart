import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/bloc/get_paginated_pets/get_paginated_pets_bloc.dart';
import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:pet_adoption_app/utils/enums.dart';

import '../mocks/mock_paginated_pet_repository.dart';

void main() {
  group('GetPaginatedPetListBloc', () {
    late GetPaginatedPetListBloc bloc;

    setUp(() {
      bloc = GetPaginatedPetListBloc(MockPetRepository([]));
    });

    tearDown(() {
      bloc.close();
    });

    test('Initial state is GetPaginatedPetListInitialState', () {
      expect(bloc.state, isA<GetPaginatedPetListInitialState>());
    });

    test('GetPaginatedPetListInitialEvent triggers loading state', () async {
      // Create a list of pet models for testing
      final petList = List.generate(
        10,
        (index) => PetModel(
          id: faker.guid.guid(),
          name: faker.lorem.word(),
          age: faker.randomGenerator.integer(10, min: 1),
          price: faker.randomGenerator.integer(100, min: 10),
          character: faker.lorem.sentence(),
          type: faker.randomGenerator
              .element(PetCategory.values)
              .toString()
              .split('.')
              .last,
          imageURL: faker.image.image(),
          isAdopted: faker.randomGenerator.boolean(),
          sex: faker.lorem.word(),
          color: faker.lorem.word(),
        ),
      );

      // Set up the repository to return the pet list
      final repository = MockPetRepository(petList);
      bloc = GetPaginatedPetListBloc(repository);

      // Dispatch the initial event
      bloc.add(GetPaginatedPetListInitialEvent());

      // Wait for the state to be updated
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<GetPaginatedPetListLoading>(),
          isA<GetPaginatedPetListLoaded>(),
        ]),
      );
    });

    test(
      'GetPaginatedPetListCategoryEvent updates category and fetches new data',
      () async {
        // Create a list of pet models for testing
        final petList = List.generate(
          10,
          (index) => PetModel(
            id: faker.guid.guid(),
            name: faker.lorem.word(),
            age: faker.randomGenerator.integer(10, min: 1),
            price: faker.randomGenerator.integer(100, min: 10),
            character: faker.lorem.sentence(),
            type: faker.randomGenerator
                .element(PetCategory.values)
                .toString()
                .split('.')
                .last,
            imageURL: faker.image.image(),
            isAdopted: faker.randomGenerator.boolean(),
            sex: faker.lorem.word(),
            color: faker.lorem.word(),
          ),
        );

        // Set up the repository to return the pet list
        final repository = MockPetRepository(petList);
        bloc = GetPaginatedPetListBloc(repository);

        // Dispatch the category event
        bloc.add(GetPaginatedPetListCategoryEvent(PetCategory.dog));

        // Wait for the state to be updated
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<GetPaginatedPetListLoading>(),
            isA<GetPaginatedPetListLoaded>(),
          ]),
        );

        // Verify that the currentSelected category is updated to 'dog'
        expect(bloc.currentSelected, PetCategory.dog);
      },
    );

    test(
      'GetPaginatedPetListNextPageEvent fetches next page of pet list',
      () async {
        // Create a list of pet models for testing
        final petList = List.generate(
          10,
          (index) => PetModel(
            id: faker.guid.guid(),
            name: faker.lorem.word(),
            age: faker.randomGenerator.integer(10, min: 1),
            price: faker.randomGenerator.integer(100, min: 10),
            character: faker.lorem.sentence(),
            type: faker.randomGenerator
                .element(PetCategory.values)
                .toString()
                .split('.')
                .last,
            imageURL: faker.image.image(),
            isAdopted: faker.randomGenerator.boolean(),
            sex: faker.lorem.word(),
            color: faker.lorem.word(),
          ),
        );

        // Set up the repository to return the pet list
        final repository = MockPetRepository(petList);
        bloc = GetPaginatedPetListBloc(repository);

        // Dispatch the next page event
        bloc.add(const GetPaginatedPetListNextPageEvent(0));

        // Wait for the state to be updated
        await expectLater(
          bloc.stream,
          emitsInOrder([
            isA<GetPaginatedPetListLoading>(),
            isA<GetPaginatedPetListLoaded>(),
          ]),
        );

        // Verify that the paginated pet list is updated
        final currentState = bloc.state;
        expect(currentState, isA<GetPaginatedPetListLoaded>());
        final loadedState = currentState as GetPaginatedPetListLoaded;
        expect(loadedState.modelList.length, 5);
      },
    );
  });
}
