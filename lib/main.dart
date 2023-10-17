import 'package:e_commerce_app/screens/screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const E_commerce_App());
}

class E_commerce_App extends StatelessWidget {
  const E_commerce_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      initialRoute: Home_Screen.id,
      routes: {
        Login_Screen.id: (context) => Login_Screen(),
        SignUp_Screen.id: (context) => SignUp_Screen(),
        Home_Screen.id: (context) => Home_Screen(),
        Forget_Screen.id: (context) => Forget_Screen(),
      },
    );
  }
}
