class SignUpModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String password;

  SignUpModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
  });

  Map<String,dynamic>toJson(){
    return {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
      "password":password,
      "photo":""
    };
  }
}
