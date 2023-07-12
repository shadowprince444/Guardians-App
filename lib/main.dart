import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/data/repositories/pet_repository.dart';
import 'package:pet_adoption_app/data/repositories/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/adoption_history/adoption_history_bloc.dart';
import 'bloc/get_paginated_pets/get_paginated_pets_bloc.dart';
import 'bloc/pet_adoption/pet_adoption_bloc.dart';
import 'bloc/theme/theme_bloc.dart';
import 'data/repositories/adoption_history.dart';
import 'views/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PetAdoptionApp());
}

class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) =>
              ThemeBloc(SecureStorageService.instance)
                ..add(CurrentThemeSetEvent()),
        ),
        BlocProvider<GetPaginatedPetListBloc>(
          create: (BuildContext context) => GetPaginatedPetListBloc(
              PetRepositoryImpl(FirebaseFirestore.instance))
            ..add(GetPaginatedPetListInitialEvent()),
        ),
        BlocProvider<PetAdoptionBloc>(
          create: (BuildContext context) =>
              PetAdoptionBloc(PetRepositoryImpl(FirebaseFirestore.instance))
                ..add(GetAdoptionListEvent()),
        ),
        BlocProvider<AdoptionHistoryBloc>(
          create: (BuildContext context) => AdoptionHistoryBloc(
              AdoptionHistoryRepository(FirebaseFirestore.instance))
            ..add(const AdoptionHistoryInitialEvent(0)),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, themeData) => MaterialApp(
          title: 'Paw Patrol',
          theme: themeData,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
