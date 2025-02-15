import 'package:clean_life_capston_project/resources/color_manager.dart';
import 'package:clean_life_capston_project/screens/mainscreen.dart';
import 'package:clean_life_capston_project/screens/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Loginprovider.dart';
import '../resources/strings_manager.dart';
//import '../resources/values_manager.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  void validateForm() {
    setState(() {
      isButtonEnabled = email.text.isNotEmpty && password.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Added padding
            child: Consumer<loginprovider>(
              builder: (context, value, child) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        controller: email,
                        onChanged: (value) => validateForm(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        controller: password,
                        onChanged: (value) => validateForm(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a valid password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dont_have_account,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()),
                              );
                            },
                            child: Text(
                              AppStrings.registerText,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          backgroundColor: isButtonEnabled
                              ? ColorManager.primary // Enabled: Green
                              : ColorManager.gray, // Disabled: Gray
                        ),
                        onPressed: isButtonEnabled
                            ? () async {
                          if (formKey.currentState!.validate()) {
                            await value.login(email.text, password.text);
                            if (value.data?.status == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error")),
                              );
                            }
                          }
                        }
                            : null,
                        child: Text("Login"),
                      ),
                    ],
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
