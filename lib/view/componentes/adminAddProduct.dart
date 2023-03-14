import 'package:flutter/material.dart';

import '../login.dart';
import 'adminCatInsert.dart';
import 'adminCatList.dart';
import 'adminListProducto.dart';

class AdminAddProduct extends StatefulWidget {
  String user;
  String name;
  AdminAddProduct(this.user, this.name);

  @override
  State<AdminAddProduct> createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Agregar producto'),
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
    );
  }
}
