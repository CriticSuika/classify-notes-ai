import 'package:software_studio_project/model/model_log_in_method.dart';

class User {
  String id;
  final String email;
  final String name;
  final String avatarUrl;
  late final List<LogInMethod> logInMethods;

  bool _isModerator = false;
  bool get isModerator => _isModerator;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
    logInMethods,
  }) : logInMethods = logInMethods ?? [];

  User._({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
    logInMethods,
    isModerator = false,
  })  : logInMethods = logInMethods ?? [],
        _isModerator = isModerator;

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User._(
      id: id,
      email: map['email'],
      name: map['name'],
      avatarUrl: map['avatarUrl'],
      logInMethods: (map['logInMethods'] as List<dynamic>)
          .map((logInMethod) => LogInMethod.values.byName(logInMethod))
          .toList(),
      isModerator: map['isModerator'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatarUrl': avatarUrl,
      'logInMethods':
          logInMethods.map((logInMethod) => logInMethod.name).toList(),
      'isModerator': _isModerator,
    };
  }
}
