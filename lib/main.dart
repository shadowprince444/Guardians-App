import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/data/repositories/secure_storage.dart';

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
                ..add(InitialThemeSetEvent()),
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
