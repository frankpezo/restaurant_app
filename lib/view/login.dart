import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/admin.dart';
import 'package:restaurant_app/view/mesero.dart';
import 'package:restaurant_app/view/register.dart';

import '../controller/keyController.dart';
import 'package:http/http.dart' as http; //Para consumir la Api

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //1. Declaramos las variables necesarias
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();
  //1. Para visuzalir la contraseña
  bool obscurePass = true;
  List<dynamic> userData = [];
//2. Realizamos la función para traer el datos
  Future<void> getDatos() async {
    //2.1. Comprobamos que el campo no esté vacíos
    if (usuario.text.isNotEmpty && password.text.isNotEmpty) {
      //2.2. Realizamos el try-catch
      try {
        //2.2.1. Tremos el link
        Uri url = Uri.parse("http://10.0.2.2/cajuephp/select.php");
        //2.2.2. Hacemos la petición
        var res = await http
            .post(url, body: {'user': usuario.text, 'password': password.text});
        print(res.body);
        //2.3. Convertimos la respuesta json
        var response = jsonDecode(res.body);
        if (response.length != 0) {
          if (response[0]['id_rol'] == '1') {
            print('admin');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPage(
                      usuario.text, response[0]['nombre'].toString())),
            );
          } else if (response[0]['id_rol'] == '2') {
            print('mesero');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MeseroPage(
                      usuario.text, response[0]['nombre'].toString())),
            );
          }
        } else {
          print('falló');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 242, 48, 48),
            content: Text(
              'Los datos no coinciden',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 5),
          ));
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 242, 48, 48),
        content: Text(
          'Los campos no pueden quedar vacíos',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Form(
          key: formKeyDos,
          child: SafeArea(
              child: Container(
            //Aquí irá el logo
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(17),
                  margin: EdgeInsets.only(top: 80),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    margin: EdgeInsets.all(15),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40, left: 10, right: 10),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 3, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  //1. LOGO
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo/log.png',
                                        width: 95,
                                        height: 95,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text(
                                    'Iniciar Sesión',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 5, 139, 34),
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),

                                  //6. Usuario
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: usuario,
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese su usuario';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Usuario',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  //7. Password
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: password,
                                      obscureText: obscurePass,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese su usuario';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Contraseña',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                        suffixIcon: IconButton(
                                          padding: EdgeInsets.only(bottom: 10),
                                          onPressed: () => setState(() {
                                            obscurePass = !obscurePass;
                                          }),
                                          icon: Icon(obscurePass
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //8. Lista de opciones
                                  SizedBox(
                                    height: 10,
                                  ),

                                  //9. Botón para enviar

                                  GestureDetector(
                                    //1. Para que nos lleve a la página deseada
                                    onTap: () {
                                      //Para usar esto debemos crear una llave globar y debe ir dentro de un form
                                      setState(() {
                                        if (formKeyDos.currentState!
                                            .validate()) {}
                                      });
                                      //9.1 Aquí debe ir la función de la API
                                      getDatos();
                                    },

                                    child: Container(
                                      width: 270,
                                      height: 40,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 10, top: 20),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 5, 139, 34),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Text(
                                          'Ingresar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            InkWell(
                              child: GestureDetector(
                                  child: Text(
                                    '¿Aún no estás registrado?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 136, 136),
                                        fontSize: 16),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterPage()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    ));
  }
}
