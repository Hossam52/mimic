class User {
  late final int id;
  late final String name;
  late final String email;
  late final String country;
  late final String city;
  late final String image;
  late final int rank;
  late final String dataOfBirth;
  late final String clientCode;
  late final String description;
  late final String tokenUser;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.country,
    required this.city,
    required this.rank,
    required this.dataOfBirth,
    required this.clientCode,
    required this.description,
    required this.tokenUser,
  });
  factory User.fromJson(Map<String, dynamic> userData) 
  {
    return User(
        id: userData['R0'],
        name: userData['R1'],
        email: userData['R2'],
        country: userData['R3'],
        city: userData['R4'],
        image: userData['R5'],
        rank: userData['R6'],
        dataOfBirth: userData['R7'],
        clientCode: userData['R8'],
        description: userData['R9'],
        tokenUser: userData['RT'],
        );
  }
}
