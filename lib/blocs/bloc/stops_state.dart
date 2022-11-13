part of 'stops_bloc.dart';

abstract class StopsState extends Equatable {
  const StopsState();

  @override
  List<Object> get props => [];
}

class StopsInitial extends StopsState {}

class StopsInProgress extends StopsState {}

class StopsFetched extends StopsState {
  final List<Location> locations;

  const StopsFetched(this.locations);
  @override
  List<Object> get props => [locations];
}

class StopsFailed extends StopsState {}
