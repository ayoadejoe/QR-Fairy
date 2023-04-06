class homey_model {
  final String? serverone;
  final String? servertwo;

  homey_model({
    required this.serverone,
    required this.servertwo,
  });

  factory homey_model.fromJson(Map<String, dynamic> json) {
    return homey_model(
      serverone: json['ServerOne'] as String?,
      servertwo: json['ServerTwo'] as String?,
    );
  }
}
