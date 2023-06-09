import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/componentes/adminEditList.dart';

import '../admin.dart';
import '../login.dart';
import 'adminAddProduct.dart';
import 'adminCatInsert.dart';
import 'adminCatList.dart';
import 'package:http/http.dart' as http; //Para consumir la Api

class AdminListProduct extends StatefulWidget {
  String user;
  String name;
  String id;
  String nameCat;
  AdminListProduct(this.user, this.name, this.id, this.nameCat);

  @override
  State<AdminListProduct> createState() => _AdminListProductState();
}

class _AdminListProductState extends State<AdminListProduct> {
  //1. Declaramos una lista
  List userData = [];

//3. Función para eliminar el producto
  Future<void> deleteProduct(String id) async {
    //3.1. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/deleteProduct.php");
    //3.2.Try-Catch
    try {
      var res = await http.post(url, body: {'id': id});
      //3.3. Hacemos la petición
      var response = jsonDecode(res.body);
      if (response['success'] == "true") {
        print('Se eliminó el producto');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 237, 32),
          content: Text(
            'Se eliminó el producto',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 5),
        ));
      } else {
        print('No se eliminó el producto');
      }

      setState(() {
        userData = jsonDecode(res.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //2. Función para traer
  Future<void> getProduct(String id) async {
    //2.1. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/viewProduct.php");
    //2.2.Try-Catch
    try {
      var res = await http.post(url, body: {'id': id.toString()});

      setState(() {
        userData = jsonDecode(res.body);
      });
    } catch (e) {
      print(e);
    }
  }

//2.3. initState
  @override
  void initState() {
    super.initState();
    //Para traer el id de la categoría
    getProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text(widget.nameCat),
        //  backgroundColor: Color.fromARGB(255, 5, 139, 34),
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
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Datos
                            Text(
                              userData[index]['nombre'].toString(),
                              //'Nombre',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'S/. ${userData[index]['precio_venta'].toString()}',
                              // 'Precio',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              userData[index]['descripcion'].toString(),
                              //'Descripción',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        //Iconos
                        Row(
                          children: [
                            IconButton(
                                color: Color.fromARGB(255, 245, 147, 0),
                                onPressed: () {
                                  print('Editar');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminEditList(
                                                widget.user,
                                                widget.name,
                                                userData[index]['id_producto'],
                                                userData[index]['nombre'],
                                                userData[index]['precio_venta'],
                                                userData[index]['descripcion'],
                                              )));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: Colors.redAccent,
                                onPressed: () {
                                  print('Eliminar');
                                  deleteProduct(userData[index]['id_producto']
                                      .toString());
                                },
                                icon: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
