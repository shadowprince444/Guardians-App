import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/spacing_widgets.dart';

import '../../../bloc/adoption_history/adoption_history_bloc.dart';
import 'widget/adopted_pet_widget.dart';

class AdoptionHistoryScreen extends StatefulWidget {
  const AdoptionHistoryScreen({super.key});

  @override
  State<AdoptionHistoryScreen> createState() => _AdoptionHistoryScreenState();
}

class _AdoptionHistoryScreenState extends State<AdoptionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      pagination();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: SafeArea(
        child: BlocBuilder<AdoptionHistoryBloc, AdoptionHistoryState>(
          builder: (context, petAdoptionBlocState) {
            if (petAdoptionBlocState is AdoptionHistoryLoaded) {
              final list = petAdoptionBlocState.modelList;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                controller: _scrollController,
                separatorBuilder: (context, index) => const VSpace(16),
                itemBuilder: (context, index) {
                  var petHistoryModel = list[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      40.vdp(),
                    ),
                    child: AdoptedPetWidget(
                      petHistoryModel: petHistoryModel,
                    ),
                  );
                },
              );
            } else if (petAdoptionBlocState is AdoptionHistoryLoading) {
              final list = petAdoptionBlocState.modelList;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length + 1,
                separatorBuilder: (context, index) => const VSpace(16),
                itemBuilder: (context, index) {
                  if (index == list.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var petHistoryModel = list[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      40.vdp(),
                    ),
                    child: AdoptedPetWidget(
                      petHistoryModel: petHistoryModel,
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void pagination() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final petAdoptionHistoryBloc = context.read<AdoptionHistoryBloc>();
      petAdoptionHistoryBloc.add(
          AdoptionHistoryNextPageEvent(petAdoptionHistoryBloc.currentPage));
    }
  }
}
