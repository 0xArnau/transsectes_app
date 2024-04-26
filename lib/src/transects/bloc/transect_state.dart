part of 'transect_bloc.dart';

sealed class TransectState extends Equatable {
  const TransectState();

  @override
  List<Object> get props => [];
}

final class TransectInitial extends TransectState {}

final class TransectLoaded extends TransectState {
  final List<TransectModel> transects;

  TransectLoaded({required this.transects});

  @override
  List<Object> get props => [transects];
}
