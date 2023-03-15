import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/keyController.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //1. Declarmos los controlers
  TextEditingController nombre = TextEditingController();
  TextEditingController dni = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rol = TextEditingController();
  //1. Para visuzalir la contraseña
  bool obscurePass = true;
  //List<String> roles = ['admin', 'empleado'];
  List<dynamic> userData = [];

  //2. Api para traer los roles de la base de datos
  Future<void> getRol() async {
    //2.1. Trayemos el URL y Hacemos un try-catch
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/empleo.php");
    try {
      //2.2. Hacemos la petición
      var response = await http.get(url);
      //2.3. Utilizamos un set State para que se pueda modificar
      setState(() {
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //3. Api para insertar en la base de datos el empleado
  Future<void> insertUser(String idrol) async {
    //3.1. Comprobamos que los campos no esten vacíos
    if (nombre.text.isNotEmpty &&
        dni.text.isNotEmpty &&
        direccion.text.isNotEmpty &&
        celular.text.isNotEmpty &&
        usuario.text.isNotEmpty &&
        password.text.isNotEmpty) {
      //3.2. Hacemos el try-catch
      try {
        //3.3. Traemos el link
        Uri url = Uri.parse("http://10.0.2.2/cajuephp/insertar.php");
        //3.4. Hacemos la petición
        var res = await http.post(url, body: {
          'idRol': idrol.toString(),
          'name': nombre.text,
          'dniU': dni.text,
          'address': direccion.text,
          'phone': celular.text,
          'user': usuario.text,
          'password': password.text
        });
        print(res.body);
        //3.5.
        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Se registró con éxito');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          print('Algo salió mal');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Los campos deben estar rellenado');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 242, 48, 48),
        content: Text(
          'Los campos no deben quedar vacíos',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 5),
      ));
    }
  }

  //2.3.
  @override
  void initState() {
    // TODO: implement initState
    getRol();
    origen = userData.length;
    super.initState();
  }

  var origen;
  String? _selectData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Form(
          // key: formKey,
          child: SafeArea(
              child: Container(
            //Aquí irá el logo
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    margin: EdgeInsets.all(4),
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
                                    height: 13,
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
                                    height: 15,
                                  ),
                                  Text(
                                    'Registrarse',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 5, 139, 34),
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //2. Nombre
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: nombre,
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese el nombre';
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
                                        hintText: 'Nombre',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //3. DNI
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: dni,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese el DNI';
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
                                        hintText: 'DNI',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //4. Direccion
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: direccion,
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese dirección';
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
                                        hintText: 'Dirección',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //5. celular
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: 325,
                                    height: 40,
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    child: TextFormField(
                                      //2. Para acceder
                                      controller: celular,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Ingrese celular';
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
                                        hintText: 'Celular',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                    height: 10,
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
                                          padding: EdgeInsets.only(bottom: 5),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //8. Lista de opciones

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //8.1. Debemos hacer un recorrido con for para poder traer las propiedades
                                      // no olvidemos declarar arriba el String? _selectData para poder usarlo
                                      for (int i = 0; i < userData.length; i++)
                                        Row(
                                          children: [
                                            Radio(
                                                activeColor: Color.fromARGB(
                                                    255, 23, 179, 135),
                                                value: userData[i]['id_rol'],
                                                groupValue: _selectData,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectData =
                                                        value.toString();
                                                    print(
                                                        _selectData); //Nos imprime el id
                                                  });
                                                }),
                                            Text(userData[i]['nombre'])
                                          ],
                                        ),
                                      //S Text(userData[0]['nombre'])
                                    ],
                                  ),

                                  //9. Botón para enviar
                                  GestureDetector(
                                    //1. Para que nos lleve a la página deseada
                                    onTap: () {
                                      print(userData);

                                      //Para usar esto debemos crear una llave globar y debe ir dentro de un form
                                      setState(() {
                                        //  if (formKey.currentState!.validate()) {}
                                        if (_selectData == null) {
                                          print(
                                              'No se ha seleccionado ningún puesto');
                                        }
                                      });

                                      for (int i = 0;
                                          i < userData.length;
                                          i++) {
                                        insertUser(
                                            userData[i]['id_rol'].toString());
                                      }

                                      //9.1 Aquí debe ir la función de la API
                                      /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage())); */
                                    },

                                    child: Container(
                                      width: 300,
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
                                          'Enviar',
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
                              height: 13,
                            ),
                            InkWell(
                              child: GestureDetector(
                                  child: Text(
                                    '¿Ya tiene una cuenta?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 136, 136),
                                        fontSize: 16),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
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
