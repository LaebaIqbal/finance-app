import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

//ggf später Fehler ausgeben bei Login
  String errorMessage = "";

//wenn man auf login drückt
  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == "test@mail.com" && password == "1234"){
      //zur HomeScreen weiterleiten
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
       );
    }
    else{
      setState((){
        errorMessage = "E-mail or password not correct!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple,
          Colors.purpleAccent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),

    child: Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Welcome to your\nFinance App!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "E-Mail",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    ),
  ),
);
  }
}
