import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/bloc/get_paginated_pets/get_paginated_pets_bloc.dart';
import 'package:pet_adoption_app/bloc/pet_adoption/pet_adoption_bloc.dart';
import 'package:pet_adoption_app/data/models/pet_model.dart';
import 'package:pet_adoption_app/views/screens/home/home_screen.dart';
import 'package:pet_adoption_app/views/screens/home/widgets/widgets.dart';

import '../mocks/mock_paginated_pet_repository.dart';

void main() {
  testWidgets('HomeScreen displays AppBar and icons',
      (WidgetTester tester) async {
    final list = List.generate(
        10,
        (index) => PetModel(
              id: Faker().guid.guid(),
              name: Faker().lorem.word(),
              age: Faker().randomGenerator.integer(10, min: 1),
              price: Faker().randomGenerator.integer(100, min: 10),
              character: Faker().lorem.sentence(),
              type: Faker().lorem.word(),
              imageURL: Faker().image.image(),
              isAdopted: Faker().randomGenerator.boolean(),
              sex: Faker().lorem.word(),
              color: Faker().lorem.word(),
            ));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<GetPaginatedPetListBloc>(
              create: (BuildContext context) =>
                  GetPaginatedPetListBloc(MockPetRepository(list))
                    ..add(GetPaginatedPetListInitialEvent()),
            ),
            BlocProvider<PetAdoptionBloc>(
              create: (BuildContext context) =>
                  PetAdoptionBloc(MockPetRepository(list))
                    ..add(GetAdoptionListEvent()),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(NavDrawer), findsOneWidget);
    expect(find.byType(PetCategoriesWidget), findsOneWidget);

    await tester.pump();
  });
}
