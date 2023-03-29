import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/componentes/produMesero.dart';
import 'package:restaurant_app/view/mesero.dart';
import '../login.dart';
import 'package:http/http.dart' as http;

class CatMesero extends StatefulWidget {
  String user;
  String name;
  CatMesero(this.user, this.name);

  @override
  State<CatMesero> createState() => _CatMeseroState();
}

class _CatMeseroState extends State<CatMesero> {
  //1. Creamos una variable que contendrá la lista de categorías
  List userData = [];
  //2. Creamos la función para traer los datos
  Future<void> getData() async {
    //2.1. Hacemos un try-catch para capturar los errores y traemos el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/viewListCat.php");
    try {
      //2.2. Hacemos la petición http
      var response = await http.get(url);
      //2.3. Seteamo la variable
      setState(() {
        //2.4. Decodificamos el json y lo guardamos en la variable userData
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //2.5. Llamamos la función en el initState
  @override
  void initState() {
    // TODO: implement initState
    //Colocamos aquí la función para que se ejecute al iniciar el widget
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Categoría '),
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

      //Donde se mostrará la lista
      body: Container(
        child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData[index]['nombre'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userData[index]['descripcion'],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        print('seletion');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProduMesero(
                                    widget.user,
                                    widget.name,
                                    userData[index]['id_categoria'].toString(),
                                    userData[index]['nombre'].toString())));
                      }),
                ],
              );
            }),
      ),
    );
  }
}
