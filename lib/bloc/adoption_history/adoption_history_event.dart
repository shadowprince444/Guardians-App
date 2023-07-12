part of 'adoption_history_bloc.dart';

abstract class AdoptionHistoryEvent extends Equatable {
  const AdoptionHistoryEvent();

  @override
  List<Object> get props => [];
}

class AdoptionHistoryInitialEvent extends AdoptionHistoryEvent {
  final int pageNumber;

  const AdoptionHistoryInitialEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class AdoptionHistoryNextPageEvent extends AdoptionHistoryEvent {
  final int pageNumber;

  const AdoptionHistoryNextPageEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
