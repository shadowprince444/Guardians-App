import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/adoption_history.dart';
import '../../domain/repository_interfaces/adoption_history.dart';
import '../../utils/enums.dart';

part 'adoption_history_event.dart';
part 'adoption_history_state.dart';

class AdoptionHistoryBloc
    extends Bloc<AdoptionHistoryEvent, AdoptionHistoryState> {
  final IAdoptionHistoryRepository _adoptionHistoryRepository;
  final List<AdoptionHistory> _getPaginatedAdoptionHistoryList = [];
  int currentPage = -1;

  AdoptionHistoryBloc(this._adoptionHistoryRepository)
      : super(AdoptionHistoryInitialState()) {
    on<AdoptionHistoryInitialEvent>((event, emit) async {
      add(const AdoptionHistoryNextPageEvent(-1));
    });

    on<AdoptionHistoryNextPageEvent>((event, emit) async {
      emit(AdoptionHistoryLoading(_getPaginatedAdoptionHistoryList));
      final result =
          await _adoptionHistoryRepository.getAdoptionHistory(++currentPage);

      if (result.status == ApiResponseStatus.error || result.data == null) {
        _emitLoadedState(
          emit,
          _getPaginatedAdoptionHistoryList,
        );
      } else {
        final list = result.data!;
        _getPaginatedAdoptionHistoryList.addAll(list);

        _emitLoadedState(emit, _getPaginatedAdoptionHistoryList);
      }
    });
  }
  _emitLoadedState(
      Emitter<AdoptionHistoryState> emit, List<AdoptionHistory> list) {
    emit(AdoptionHistoryLoaded(list));
  }
}
