part of 'adoption_history_bloc.dart';

abstract class AdoptionHistoryState extends Equatable {
  const AdoptionHistoryState();

  @override
  List<Object> get props => [];
}

class AdoptionHistoryInitialState extends AdoptionHistoryState {}

class AdoptionHistoryLoading extends AdoptionHistoryState {
  final List<AdoptionHistory> modelList;

  const AdoptionHistoryLoading(this.modelList);

  @override
  List<Object> get props => [modelList];
}

class AdoptionHistoryLoaded extends AdoptionHistoryState {
  final List<AdoptionHistory> modelList;

  const AdoptionHistoryLoaded(this.modelList);

  @override
  List<Object> get props => [modelList];
}

class AdoptionHistoryEmpty extends AdoptionHistoryState {}

class AdoptionHistoryError extends AdoptionHistoryState {}
