import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/bloc/adoption_history/adoption_history_bloc.dart';
import 'package:pet_adoption_app/data/models/adoption_history.dart';

import '../mocks/mock_paginated_adoption_history.dart';

void main() {
  group('AdoptionHistoryBloc', () {
    late AdoptionHistoryBloc bloc;
    final faker = Faker();

    setUp(() {
      final mockRepository = MockAdoptionHistoryRepository([]);
      bloc = AdoptionHistoryBloc(mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is AdoptionHistoryInitialState', () {
      expect(bloc.state, isA<AdoptionHistoryInitialState>());
    });

    test('AdoptionHistoryInitialEvent triggers loading state', () async {
      final mockRepository = MockAdoptionHistoryRepository([]);
      bloc = AdoptionHistoryBloc(mockRepository);

      bloc.add(const AdoptionHistoryInitialEvent(-1));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<AdoptionHistoryLoading>(),
          isA<AdoptionHistoryLoaded>(),
        ]),
      );
    });

    test('AdoptionHistoryNextPageEvent fetches next page of adoption history',
        () async {
      final mockModelList = List.generate(
        10,
        (_) => AdoptionHistoryModel(
          id: faker.guid.guid(),
          name: faker.person.firstName(),
          age: faker.randomGenerator.integer(10),
          sex: faker.randomGenerator.element(['Male', 'Female']),
          imageUrl: faker.image.image(),
          adoptedTime: faker.date.dateTime(minYear: 2010, maxYear: 2023),
        ),
      );

      final mockRepository = MockAdoptionHistoryRepository(
        mockModelList,
      );
      bloc = AdoptionHistoryBloc(mockRepository);

      bloc.add(AdoptionHistoryNextPageEvent(-1));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<AdoptionHistoryLoading>(),
          isA<AdoptionHistoryLoaded>(),
        ]),
      );

      final currentState = bloc.state;
      expect(currentState, isA<AdoptionHistoryLoaded>());
      final loadedState = currentState as AdoptionHistoryLoaded;
      expect(loadedState.modelList.length, 5);
    });

    test('AdoptionHistoryNextPageEvent handles empty data from repository',
        () async {
      final mockRepository = MockAdoptionHistoryRepository(
        [],
      );
      bloc = AdoptionHistoryBloc(mockRepository);

      bloc.add(AdoptionHistoryNextPageEvent(-1));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<AdoptionHistoryLoading>(),
          isA<AdoptionHistoryLoaded>(),
        ]),
      );

      final currentState = bloc.state;
      expect(currentState, isA<AdoptionHistoryLoaded>());
      final loadedState = currentState as AdoptionHistoryLoaded;
      expect(loadedState.modelList.length, 0);
    });
  });
}
