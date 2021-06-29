// import 'package:flutter/material.dart';
// import 'package:flutter_boxicons/flutter_boxicons.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();

//   bool oculto = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Iniciar Sesion',
//           style: GoogleFonts.raleway(
//             color: Colors.redAccent[700],
//           ),
//         ),
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Boxicons.bx_arrow_back,
//             color: Colors.redAccent[700],
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.all(10.0),
//             child: Form(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     style: GoogleFonts.raleway(fontSize: 25.0),
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       labelText: 'Correo electronico',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     style: GoogleFonts.raleway(fontSize: 25.0),
//                     decoration: InputDecoration(
//                       fillColor: Color(0xFFD50000),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       labelText: 'Contraseña',
//                       suffixIcon: IconButton(
//                         color: Color(0xFFD50000),
//                         onPressed: () {
//                           if (oculto == true) {
//                             setState(() {
//                               oculto = false;
//                             });
//                           } else {
//                             setState(() {
//                               oculto = true;
//                             });
//                           }
//                         },
//                         icon: oculto == true
//                             ? Icon(FontAwesome5.eye)
//                             : Icon(FontAwesome5.eye_slash),
//                       ),
//                     ),
//                     obscureText: oculto,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text('Iniciar Sesion'),

//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db/bloc/login_bloc.dart';
import 'package:the_movie_db/bloc/provide.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
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
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: GoogleFonts.raleway(fontSize: 30.0),
                ),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: GoogleFonts.raleway(),
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    bool oculto = true;
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.redAccent[700],
                ),
                suffixIcon: IconButton(
                  color: Color(0xFFD50000),
                  onPressed: () {
                    if (oculto == true) {
                      setState(() {
                        oculto = false;
                      });
                    } else {
                      setState(() {
                        oculto = true;
                      });
                    }
                  },
                  icon: oculto == true
                      ? Icon(FontAwesome5.eye)
                      : Icon(FontAwesome5.eye_slash),
                ),
                labelText: 'Contraseña',
                labelStyle: GoogleFonts.raleway(
                  color: Colors.redAccent[700],
                ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: GoogleFonts.raleway(),
              ),
              onChanged: bloc.changePassword,
              obscureText: false // == true ? true : false,
              ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black),
              textStyle: MaterialStateProperty.all(
                GoogleFonts.raleway(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context) {
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

    return Stack(
      children: <Widget>[
        fondoRojo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
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
    );
  }
}
