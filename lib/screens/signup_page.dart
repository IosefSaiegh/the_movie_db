import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/bloc/login_bloc.dart';
import 'package:the_movie_db/bloc/provide.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoRojo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.redAccent.shade700,
            Colors.red,
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              top: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Registro',
                  style: GoogleFonts.raleway(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.redAccent.shade700,
                Colors.red,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              )
            ],
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              fondoRojo,
              Positioned(top: 90.0, left: 30.0, child: circulo),
              Positioned(bottom: -50.0, right: -10.0, child: circulo),
              Positioned(bottom: 120.0, right: 20.0, child: circulo),
              Positioned(bottom: -50.0, left: -20.0, child: circulo),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Icon(
                      Boxicons.bx_camera_movie,
                      color: Colors.white,
                      size: 100.0,
                    ),
                    SizedBox(height: 10.0, width: double.infinity),
                    Text(
                      'The Movie DB',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    height: 180.0,
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Registrar',
                        style: GoogleFonts.raleway(fontSize: 30.0),
                      ),
                      SizedBox(height: 60.0),
                      StreamBuilder(
                        stream: bloc.userNameStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person_outline_rounded,
                                  color: Colors.redAccent[700],
                                ),
                                labelText: 'Nombre de usuario',
                                labelStyle: GoogleFonts.raleway(
                                  color: Colors.redAccent[700],
                                ),
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                errorStyle: GoogleFonts.raleway(),
                              ),
                              onChanged: bloc.changeUserName,
                              obscureText: false,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                      StreamBuilder(
                        stream: bloc.emailStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.redAccent[700],
                                ),
                                hintText: 'example@example.com',
                                labelText: 'Correo electrónico',
                                labelStyle: GoogleFonts.raleway(
                                  color: Colors.redAccent[700],
                                ),
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                errorStyle: GoogleFonts.raleway(),
                              ),
                              onChanged: bloc.changeEmail,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                      StreamBuilder(
                        stream: bloc.passwordStream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.redAccent[700],
                                ),
                                labelText: 'Contraseña',
                                labelStyle: GoogleFonts.raleway(
                                  color: Colors.redAccent[700],
                                ),
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                errorStyle: GoogleFonts.raleway(),
                              ),
                              onChanged: bloc.changePassword,
                              obscureText: false,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                      StreamBuilder(
                        stream: bloc.formValidStream,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot snapshot,
                        ) {
                          return ElevatedButton(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 15.0),
                                child: Text('Registrar'),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.black),
                                textStyle: MaterialStateProperty.all(
                                  GoogleFonts.raleway(),
                                ),
                              ),
                              onPressed:
                                  snapshot.hasData ? () => signUp(bloc) : null);
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: Text(
                    'Iniciar Sesion',
                    style: GoogleFonts.raleway(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 100.0)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signUp(LoginBloc bloc) async {
    String email = bloc.email.trim();
    String password = bloc.password;
    if (email.isNotEmpty && password.isNotEmpty) {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                'Listo',
                style: GoogleFonts.raleway(),
              ),
              content: Text(
                'Se ha registrado con exito!',
                style: GoogleFonts.raleway(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                    setState(() {
                      email = "";
                      password = "";
                    });
                  },
                  child: Text(
                    'Ok',
                    style: GoogleFonts.raleway(),
                  ),
                )
              ],
            );
          },
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                'Error',
                style: GoogleFonts.raleway(),
              ),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: GoogleFonts.raleway(),
                  ),
                )
              ],
            );
          },
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Rellena los datos correspondientes'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    email = "";
                    password = "";
                  });
                },
                child: Text(
                  'Ok',
                  style: GoogleFonts.raleway(),
                ),
              )
            ],
          );
        },
      );
    }
  }
}
