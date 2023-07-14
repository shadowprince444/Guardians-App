import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/adoption_history.dart';
import '../../domain/repository_interfaces/adoption_history.dart';
import '../../utils/enums.dart';

part 'adoption_history_event.dart';
part 'adoption_history_state.dart';

/// BLoC responsible for managing the adoption history data
class AdoptionHistoryBloc
    extends Bloc<AdoptionHistoryEvent, AdoptionHistoryState> {
  final IAdoptionHistoryRepository _adoptionHistoryRepository;
  final List<AdoptionHistoryModel> _getPaginatedAdoptionHistoryList = [];
  int currentPage = -1;
  bool shouldLoadMore = true;

  AdoptionHistoryBloc(this._adoptionHistoryRepository)
      : super(AdoptionHistoryInitialState()) {
    on<AdoptionHistoryInitialEvent>((event, emit) async {
      // Trigger the event to fetch the initial page of adoption history
      add(const AdoptionHistoryNextPageEvent(-1));
    });

    on<AdoptionHistoryNextPageEvent>((event, emit) async {
      if (event.pageNumber == -1) {
        _getPaginatedAdoptionHistoryList.clear();
        shouldLoadMore = true;
      }
      if (shouldLoadMore) {
        // Emit the loading state to indicate that the data is being fetched
        emit(AdoptionHistoryLoading(_getPaginatedAdoptionHistoryList));

        // Retrieve the next page of adoption history from the repository
        final result =
            await _adoptionHistoryRepository.getAdoptionHistory(++currentPage);

        if (result.status == ApiResponseStatus.error ||
            result.data == null ||
            result.data?.isNotEmpty != true) {
          shouldLoadMore = false;
          // If there was an error or no data returned, emit the loaded state with the existing list
          _emitLoadedState(
            emit,
            _getPaginatedAdoptionHistoryList,
          );
        } else {
          final list = result.data!;
          // Append the retrieved data to the existing list
          _getPaginatedAdoptionHistoryList.addAll(list);

          // Emit the loaded state with the updated list
          _emitLoadedState(emit, _getPaginatedAdoptionHistoryList);
        }
      }
    });
  }

  // Helper method to emit the loaded state
  _emitLoadedState(
      Emitter<AdoptionHistoryState> emit, List<AdoptionHistoryModel> list) {
    emit(AdoptionHistoryLoaded(list));
  }
}
