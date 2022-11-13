import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_journey/blocs/bloc/stops_bloc.dart';

class HomePage extends StatelessWidget {
  final StopsBloc bloc = StopsBloc();
  final TextEditingController controller = TextEditingController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step Finder"),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: "Search a location",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      bloc.add(FetchStops(controller.text));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
          BlocBuilder<StopsBloc, StopsState>(
            builder: (context, state) {
              if (state is StopsInProgress) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is StopsFetched) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.locations.length,
                    itemBuilder: (context, index) {
                      print(state.locations[index].name);
                      return ExpansionTile(
                        title: Text(
                          state.locations[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: state.locations[index].isBest
                            ? const Icon(Icons.directions_walk)
                            : null,
                        expandedAlignment: Alignment.topLeft,
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        subtitle: Text(state.locations[index].type),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coordinations: ${state.locations[index].coord.x}, ${state.locations[index].coord.y}",
                              ),
                              Text(
                                "Match Quality: ${state.locations[index].matchQuality}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "${state.locations[index].name} has been selected as the start point."),
                                      ));
                                    },
                                    child:
                                        Text("Choose as the starting point")),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Text("Nothing is found"),
                  ),
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
