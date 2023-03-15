import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/admin.dart';

import '../login.dart';
import 'adminAddProduct.dart';
import 'adminCatInsert.dart';
import 'adminCatList.dart';
import 'adminListProducto.dart';
import 'package:http/http.dart' as http;

class AdminCatEdit extends StatefulWidget {
  String user;
  String name;
  String id;
  String nombre;
  String descrip;
  AdminCatEdit(this.user, this.name, this.id, this.nombre, this.descrip);
  @override
  State<AdminCatEdit> createState() => _AdminCatEditState();
}

class _AdminCatEditState extends State<AdminCatEdit> {
  //1. Un init state con los datos que queremos actualizar, pero primero declaramos los controlers
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  //2 La función para modificr la categoría
  Future<void> updateCat() async {
    if (id.text.isNotEmpty &&
        name.text.isNotEmpty &&
        description.text.isNotEmpty) {
      //2.1. Traemos el link
      Uri url = Uri.parse("http://10.0.2.2/cajuephp/updateCat.php");
      //2.2. Realizamos el try-catch
      try {
        //2.2.1. Hacemos la petición
        var res = await http.post(url, body: {
          'id': id.text,
          'name': name.text,
          'description': description.text
        });
        //2.2. Si todo va bien
        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Se modificó con éxito');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 0, 237, 32),
            content: Text(
              'Se modificó correctamente',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 5),
          ));
        } else {
          print('Falló la modificación');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Los campos no pueden quedar vacíos');
    }
  }

  //1.1. Hacemos el initState
  @override
  void initState() {
    // TODO: implement initState
    //1.1. Treamos
    id.text = widget.id;
    name.text = widget.nombre;
    description.text = widget.descrip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //1. Creamos el drawer
        appBar: AppBar(
          title: Text('Editar categoría'),
          backgroundColor: Color.fromARGB(255, 5, 139, 34),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              //1.1. Header
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo/p2.png'),
                        fit: BoxFit.cover)),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminPage(widget.user, widget.name)));
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
                                  builder: (context) => AdminCatInsert(
                                      widget.user, widget.name)));
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
                                  builder: (context) => AdminAddProduct(
                                      widget.user, widget.name)));
                        },
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
              margin: EdgeInsets.only(top: 100, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: 340,
                    height: 40,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    child: Visibility(
                      visible: false,
                      child: TextFormField(
                        //2. Para acceder
                        controller: id,
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
                          hintText: 'id',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                      //Aquí debe ir la función de la API
                      updateCat();
                    },

                    child: Container(
                      width: 330,
                      height: 40,
                      margin: EdgeInsets.only(left: 20, right: 10, top: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 245, 147, 0),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Modificar',
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
        ));
  }
}
