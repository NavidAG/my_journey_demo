part of 'stops_bloc.dart';

abstract class StopsEvent extends Equatable {
  const StopsEvent();

  @override
  List<Object> get props => [];
}

class FetchStops extends StopsEvent {
  final String searchTerm;

  const FetchStops(this.searchTerm);
}
