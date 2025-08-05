class ProfileUpdated {
  final String firstName;
  final String lsatName;
  final String mobile;
  final String email;

  ProfileUpdated({
    required this.firstName,
    required this.lsatName,
    required this.mobile,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lsatName,
      'mobile': mobile,
      'email': email,
    };
  }
}
