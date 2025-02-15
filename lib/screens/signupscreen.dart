import 'package:clean_life_capston_project/resources/strings_manager.dart';
import 'package:clean_life_capston_project/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/signupprovider.dart';
import 'loginscreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  void validateForm() {
    setState(() {
      isButtonEnabled = userName.text.isNotEmpty &&
          email.text.isNotEmpty &&
          password.text.isNotEmpty &&
          phone.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    userName.addListener(validateForm);
    email.addListener(validateForm);
    password.addListener(validateForm);
    phone.addListener(validateForm);
  }

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome To SignUp Page")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<signupprovider>(
              builder: (context, value, child) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                AppStrings.Welcomeinlogin,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center, // Center the text
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "UserName",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: userName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter valid name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: password,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter valid password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter valid phone";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            backgroundColor: isButtonEnabled
                                ? Colors.green // Enabled: Green
                                : Colors.grey, // Disabled: Gray
                          ),
                          onPressed: isButtonEnabled
                              ? () async {
                            if (formKey.currentState!.validate()) {
                              bool signup = await value.signup(
                                  userName.text,
                                  email.text,
                                  password.text,
                                  phone.text);
                              if (signup) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error")),
                                );
                              }
                            }
                          }
                              : null,
                          child: Text("Signup"),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Loginscreen()));
                              },
                              child: Text(AppStrings.login_button,
                                style:
                                Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
