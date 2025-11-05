class JokeModel {
  final int id;
  final String setup;
  final String punchline;

  JokeModel({required this.id, required this.setup, required this.punchline});

  // Factory constructor to create a JokeModel from JSON
  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      id: json['id'] as int,
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
    );
  }

  // Method to convert JokeModel to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'setup': setup, 'punchline': punchline};
  }
}
