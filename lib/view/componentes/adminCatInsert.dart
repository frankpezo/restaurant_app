import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/admin.dart';
import 'package:restaurant_app/view/componentes/adminCatList.dart';
import '../login.dart';
import 'package:http/http.dart' as http;

import 'adminAddProduct.dart';
import 'adminListProducto.dart';

class AdminCatInsert extends StatefulWidget {
  String user;
  String name;
  AdminCatInsert(this.user, this.name);
  @override
  State<AdminCatInsert> createState() => _AdminCatInsertState();
}

class _AdminCatInsertState extends State<AdminCatInsert> {
  //1. Declaramos los textController
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  //1.1. Función para limpiar los textController
  void cleanText() {
    name.clear();
    description.clear();
  }

//2. Consumir la APi
  Future<void> insertCat() async {
    //2.1. Validamos los campos
    if (name.text.isNotEmpty && description.text.isNotEmpty) {
      //2.2. Hacemos un try-catch
      try {
        //2.2.1. Consumimos la Api
        Uri url = Uri.parse("http://10.0.2.2/cajuephp/insertCat.php");
        //2.2.2. Hacemos la petición
        var res = await http.post(url,
            body: {'name': name.text, 'description': description.text});
        print(res.body);
        //2.3. Validamos la respuesta
        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Se registró con éxito');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 0, 237, 32),
            content: Text(
              'Categoría agregada con éxito',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 5),
          ));
        } else {
          print('Algo salió mal');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('No pueden quedar vacíos los campos');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Agregar categoría'),
        backgroundColor: Color.fromARGB(255, 5, 139, 34),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //1.1. Header
            Container(
              color: Color.fromARGB(255, 5, 139, 34),
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Administrador',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/logo/teamdos.png'))),
                  ),
                  //Los datos del usuario
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.user}',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            //2. Lista de menú
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //Home
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        /*           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmpleadoView())); */
                      },
                    ),
                    //Categoria
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text(
                        'Agregar categoría',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminCatInsert(widget.user, widget.name)));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.view_list),
                      title: Text(
                        'Lista de categorías',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminCatList(widget.user, widget.name)));
                      },
                    ),
                    //Producto
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text(
                        'Agregar producto',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminAddProduct(widget.user, widget.name)));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.view_list),
                      title: Text(
                        'Lista de productos',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminListProduct(
                                    widget.user, widget.name)));
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        'Cerrar sesión',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //NOMBRE
          Container(
            margin: EdgeInsets.only(top: 140, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 340,
                  height: 40,
                  padding: const EdgeInsets.only(top: 3, left: 15),
                  child: TextFormField(
                    //2. Para acceder
                    controller: name,
                    obscureText: false,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Nombre de categoría',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //DESCRIPCION
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: 340,
                  height: 40,
                  padding: const EdgeInsets.only(top: 3, left: 15),
                  child: TextFormField(
                    //2. Para acceder
                    controller: description,
                    obscureText: false,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Descripción',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                //BOTÓN - REGISTRAR
                GestureDetector(
                  //1. Para que nos lleve a la página deseada
                  onTap: () {
                    //Para que se limpie la pantalla

                    //Aquí debe ir la función de la API
                    insertCat();
                    cleanText();
                  },

                  child: Container(
                    width: 330,
                    height: 40,
                    margin: EdgeInsets.only(left: 20, right: 10, top: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 5, 139, 34),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        'Agregar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                //Para poder visualizar los datos
              ],
            ),
          ),
        ],
      ),
    );
  }
}
