import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_journey/models/location.dart';
import 'package:my_journey/repositories/stopfinder_repository.dart';

part 'stops_event.dart';
part 'stops_state.dart';

class StopsBloc extends Bloc<StopsEvent, StopsState> {
  StopsBloc() : super(StopsInitial()) {
    on<FetchStops>(_onFetchStopsEvent);
  }
  Future<void> _onFetchStopsEvent(
      FetchStops event, Emitter<StopsState> emit) async {
    emit(StopsInProgress());
    List<Location> locations = [];
    locations = await StopfinderRepository.findStops(event.searchTerm);
    print(locations.length);
    emit(StopsFetched(locations));
  }
}
