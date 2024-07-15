class Restaurant {
  final int id;
  final String name;
  final String description;
  final String googleMapsLink;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.googleMapsLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'googleMapsLink': googleMapsLink,
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      googleMapsLink: json['googleMapsLink'],
    );
  }
}
