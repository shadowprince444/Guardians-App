import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/bloc/get_paginated_pets/get_paginated_pets_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:pet_adoption_app/views/screens/home/widgets/pets_listing.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/nav_drawer.dart';
import 'widgets/pet_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      pagination();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        searchTextController: _searchTextController,
      ),
      drawer: const NavDrawer(),
      body: ResponsiveSafeArea(builder: (context, size) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              PetCategoriesWidget(
                searchTextController: _searchTextController,
              ),
              Expanded(
                  flex: 1,
                  child: BlocBuilder<GetPaginatedPetListBloc,
                      GetPaginatedPetListState>(builder: (context, state) {
                    if (state is GetPaginatedPetListLoading) {
                      final petList = state.modelList;
                      return PetListingWidget(
                          scrollController: _scrollController,
                          petList: petList);
                    }
                    if (state is GetPaginatedPetListLoaded) {
                      final petList = state.modelList;
                      return PetListingWidget(
                          scrollController: _scrollController,
                          petList: petList);
                    }
                    return const SizedBox();
                  }))
            ],
          ),
        );
      }),
    );
  }

  void pagination() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final petListBloc = context.read<GetPaginatedPetListBloc>();
      petListBloc
          .add(GetPaginatedPetListNextPageEvent(petListBloc.currentPage));
    }
  }
}
