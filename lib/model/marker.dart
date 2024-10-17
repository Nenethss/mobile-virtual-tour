class MarkerModel {
  final double lat;
  final double lng;
  final String title;
  final String description;
  final String image;

  MarkerModel({
    required this.lat,
    required this.lng,
    required this.title,
    required this.description,
    required this.image,
  });

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    return MarkerModel(
      lat: json['lat'],
      lng: json['lng'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
