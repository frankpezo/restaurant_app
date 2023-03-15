import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/view/componentes/adminAddProduct.dart';
import 'package:restaurant_app/view/componentes/adminCatInsert.dart';
import 'package:restaurant_app/view/componentes/adminCatList.dart';
import 'package:restaurant_app/view/componentes/adminListProducto.dart';
import 'package:restaurant_app/view/login.dart';

class AdminPage extends StatefulWidget {
  String user;
  String name;
  AdminPage(this.user, this.name);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //1. Declaramos una lista
  List userData = [];
  //2. Funcion para traer los datos
  Future<void> getData() async {
    //2.1. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/getPeditos.php");
    //2.2. Hacemos el try-catch
    try {
      //2.3. Hacemos la peticion
      var response = await http.get(url);
      //2.4. seteamos los datos
      setState(() {
        userData = json.decode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //2.5. La función lo guardamos en un inistate para que se pueda visualizar los datos
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Pedidos'),
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
              //  color: Color.fromARGB(255, 5, 139, 34),
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

      body: Container(
        child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Cliente: ',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(userData[index]['cliente'],
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Total: ',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text('S/. ${userData[index]['total']}',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Fecha: ',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(userData[index]['fecha_pedido'],
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Mesa: ',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text(userData[index]['num_mesa'],
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
