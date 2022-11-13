class Location {
  final String id;
  final bool? isGlobalId;
  final String name;
  final String? disassembledName;
  final String type;
  final Coordinations coord;
  final int matchQuality;
  final bool isBest;

  Location({
    required this.id,
    required this.isGlobalId,
    required this.name,
    required this.disassembledName,
    required this.type,
    required this.coord,
    required this.matchQuality,
    required this.isBest,
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isGlobalId = json['isGlobalId'],
        name = json['name'],
        disassembledName = json['disassembledName'],
        type = json['type'],
        coord = Coordinations(
          json['coord'][0],
          json['coord'][1],
        ),
        matchQuality = json['matchQuality'],
        isBest = json['isBest'];
}

class Coordinations {
  final double x;
  final double y;

  Coordinations(this.x, this.y);
}
