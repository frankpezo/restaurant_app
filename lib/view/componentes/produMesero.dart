import 'dart:convert';

import 'package:flutter/material.dart';

import '../login.dart';
import '../mesero.dart';
import 'catMesero.dart';
import 'package:http/http.dart' as http;

class ProduMesero extends StatefulWidget {
  String user;
  String name;
  String id;
  String nameCat;
  ProduMesero(this.user, this.name, this.id, this.nameCat);

  @override
  State<ProduMesero> createState() => _ProduMeseroState();
}

class _ProduMeseroState extends State<ProduMesero> {
  //1. Declaramos una lista
  List userData = [];
  //2. Creamos la función para traer los datos
  Future<void> getProducto(String id) async {
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

//2.1. Llamamos la función en el initState
  @override
  void initState() {
    super.initState();
    getProducto(widget.id);
  }

  //1.1. Declaramos una variable para el cambiar de color el icono
  bool isLiked = false;
  void toogleFavorite() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text(widget.nameCat),
        flexibleSpace: Image(
          image: AssetImage('assets/logo/p3.png'),
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
                      image: AssetImage('assets/logo/p3.png'),
                      fit: BoxFit.cover)),
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mesero',
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
                                    MeseroPage(widget.user, widget.name)));
                      },
                    ),
                    //Categoria
                    ListTile(
                      leading: Icon(Icons.category),
                      title: Text(
                        'Categoria',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CatMesero(widget.user, widget.name)));
                      },
                    ),
                    //Producto

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
      //Vamos a hacer una lista en el body
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
                              //'Precio',
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

                        //El botón favorito
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  print('Favorito');
                                  toogleFavorite();
                                  /*  deleteProduct(userData[index]['id_producto']
                                          .toString()); */
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : null,
                                )),
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
