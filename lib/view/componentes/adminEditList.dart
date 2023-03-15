import 'dart:convert';

import 'package:flutter/material.dart';

import '../admin.dart';
import '../login.dart';
import 'adminAddProduct.dart';
import 'adminCatInsert.dart';
import 'adminCatList.dart';
import 'package:http/http.dart' as http;

class AdminEditList extends StatefulWidget {
  String user;
  String name;
  String id;
  String nombre;
  String precio;
  String descrip;

  AdminEditList(
      this.user, this.name, this.id, this.nombre, this.precio, this.descrip);
  @override
  State<AdminEditList> createState() => _AdminEditListState();
}

class _AdminEditListState extends State<AdminEditList> {
  //1. Declaramos los controlers
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  //2. La función para modificar el producto
  Future<void> updateProduct() async {
    //2.1. Verificamos los campos
    if (id.text.isNotEmpty &&
        name.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty) {
      //2.2. Traemos el link
      Uri url = Uri.parse("http://10.0.2.2/cajuephp/updateProduct.php");
      //2.2.1. Hacemos el try-catch
      try {
        //2.3. Hacemos la petición
        var res = await http.post(url, body: {
          'id': id.text,
          'name': name.text,
          'price': price.text,
          'description': description.text,
        });
        //2.4. Verificamos la respuesta
        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Se modificó el producto');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 0, 237, 32),
            content: Text(
              'El producto se modificó  correctamente',
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
      print('Los campos no pueden estar vacíos');
    }
  }

  //1.1. Hacemos el init para cambiar los valores
  @override
  void initState() {
    id.text = widget.id;
    name.text = widget.nombre;
    price.text = widget.precio;
    description.text = widget.descrip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Editar Producto'),
        flexibleSpace: Image(
          image: AssetImage('assets/logo/p2.png'),
          fit: BoxFit.cover,
        ),
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
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //id
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
                  //Name
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
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Price
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: 340,
                    height: 40,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    child: TextFormField(
                      //2. Para acceder
                      controller: price,
                      obscureText: false,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Precio de producto',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Description
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
                  GestureDetector(
                    //1. Para que nos lleve a la página deseada
                    onTap: () {
                      //Aquí debe ir la función de la API
                      updateProduct();
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
