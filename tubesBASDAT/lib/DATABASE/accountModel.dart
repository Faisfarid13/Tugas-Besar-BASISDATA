final String tableAccount = 'account';

class AccountFields{
  static final List<String> values = [
    id, email, password, username
  ];

  static final String id = 'id';
  static final String email = 'email';
  static final String password = 'password';
  static final String username = 'username';
}

class Account{
  final int? id;
  final String email;
  final String password;
  final String username;

  const Account({
    this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  Account copy({
    int? id,
    String? email,
    String? password,
    String? username,
  })=>
      Account(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
      );

  static Account fromJson(Map<String, Object?> json) => Account(
    id: json[AccountFields.id] as int?,
    email: json[AccountFields.email] as String,
    password: json[AccountFields.password] as String,
    username: json[AccountFields.username] as String,
  );

  Map<String, Object?> toJson() =>{
    AccountFields.id : id,
    AccountFields.email : email,
    AccountFields.password : password,
    AccountFields.username : username,
  };
}
