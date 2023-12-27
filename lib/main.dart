import 'package:flutter/material.dart';
import 'package:flutter_application_darf/Animation/FadeAnimation.dart';
import 'package:flutter_application_darf/pageIn.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/pageIn': (context) =>  pageIn(),
        },
      ),
    );

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false; // Variável para controlar a visibilidade da senha

  Future<void> checkCredentials(String username, String password) async {
    try {
      final String databaseJson =
          await rootBundle.loadString('assets/database.json');
      final List<dynamic> database = json.decode(databaseJson);

      for (var user in database) {
        final String dbUsername = user['username'];
        final String dbPassword = user['password'];

        if (username == dbUsername && password == dbPassword) {
          // Usuário e senha correspondem
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/pageIn');
          return;
        }
      }

      // Credenciais inválidas - Mostrar diálogo
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Credenciais Inválidas'),
            content: const Text('Seu usuário e/ou senha estão incorretos. Tente novamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o pop-up
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Lidar com erros de carregamento do arquivo JSON
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height / 2,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: 365,
                    width: width,
                    child: FadeAnimation(1, Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),

                  Positioned(
                    height: 370,
                    width: width + 5,
                    child: FadeAnimation(1.3, Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const FadeAnimation(1.5, Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  const SizedBox(height: 30,),

                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .5),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),

                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey
                            ))
                          ),

                          child: TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "Usuário",
                              hintText: "Digite seu usuário",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey
                            ))
                          ),

                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Senha",
                              hintText: "Digite sua senha",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !isPasswordVisible,
                          ),
                        ),
                      ]
                    ),
                  )),

                  const SizedBox(height: 80,),
                  FadeAnimation(1.9, Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color.fromRGBO(49, 38, 79, 1)
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          checkCredentials(usernameController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(49, 38, 79, 1), // Cor de fundo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),

                  const SizedBox(height: 20,),
                  const FadeAnimation(1.9,  Center(child: Text("DARF / AD", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 15),))),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
