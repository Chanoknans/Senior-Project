class Profile {
  String email;
  String password;
  String confirmpassword;
  String name;
  String gen;
  String date;
  // ignore: non_constant_identifier_names
  String Imageurl;
  
  Profile(
      {required this.email,
      required this.password,
      required this.confirmpassword,
      required this.date,
      required this.gen,
      required this.name,
      // ignore: non_constant_identifier_names
      required this.Imageurl
      });
}
