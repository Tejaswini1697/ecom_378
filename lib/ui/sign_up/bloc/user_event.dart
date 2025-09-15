abstract class UserEvent {}

class UserRegisterEvent extends UserEvent {
  String name;
  String email;
  String mobNo;
  String password;

  UserRegisterEvent({
    required this.name,
    required this.email,
    required this.mobNo,
    required this.password,
  });
}

class UserLoginEvent extends UserEvent {
  String email;
  String pass;

  UserLoginEvent({required this.email, required this.pass});
}
