part of 'transect_bloc.dart';

sealed class TransectEvent extends Equatable {
  const TransectEvent();

  @override
  List<Object> get props => [];
}

class LoadTransects extends TransectEvent {}

class UpdateTransects extends TransectEvent {
  final List<TransectModel> transects;

  const UpdateTransects({required this.transects});

  @override
  List<Object> get props => [transects];
}
