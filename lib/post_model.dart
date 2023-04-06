class Post {
  final String? username;
  final String? password;
  final String? empty;
  final String? urls;
  final int? clientID;
  final String? clientEmail;
  final String? newuser;

  Post({
    required this.username,
    required this.password,
    required this.empty,
    required this.urls,
    required this.clientID,
    required this.clientEmail,
    required this.newuser,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['clientUsername'] as String?,
      password: json['clientPassword'] as String?,
      clientEmail: json['clientEmail'] as String?,
      urls: json['urls'] as String?,
      clientID: json['clientID'] as int?,
      empty: json['empty'] as String?,
      newuser: json['newUser'] as String?,
    );
  }
}
