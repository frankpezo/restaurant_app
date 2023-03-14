import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/view/componentes/admiCatEdit.dart';

import '../admin.dart';
import '../login.dart';
import 'adminAddProduct.dart';
import 'adminCatInsert.dart';
import 'adminListProducto.dart';
import 'package:http/http.dart' as http;

class AdminCatList extends StatefulWidget {
  String user;
  String name;
  AdminCatList(this.user, this.name);

  @override
  State<AdminCatList> createState() => _AdminCatListState();
}

class _AdminCatListState extends State<AdminCatList> {
  //1. Creamos una lista donde colocaremos los datos traídos con la Api
  List userData = [];

  //3. Creamos una función para eliminar un elemento de la lista
  Future<void> deleteCat(String id) async {
    //3.1. Traemos el el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/deleteCat.php");
    //3.1. Realizmos un try-catch
    try {
      //3.1.1. Realizamos la petición usando el post
      var res = await http.post(url, body: {"id": id});
      //3.2. Verificamos
      var response = jsonDecode(res.body);
      if (response['success'] == "true") {
        print('Se eliminó con éxito');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 237, 32),
          content: Text(
            'Categoría eliminada con éxito',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 5),
        ));
        //3.3. Colocamos aquí el método de obtener datos para poder obtener el id
        getDatos();
      } else {
        print('Algo salió mal');
      }
    } catch (e) {
      print(e);
    }
  }

  //2. Creamos la función para traer los datos
  Future<void> getDatos() async {
    //2.1. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/viewListCat.php");
    //2.1. Hacemos un try - catch
    try {
      //2.1.1 Realizamos la petición usando el get
      var response = await http.get(url);
      //2.2. Realizamos el setSate para el cambió de estado
      setState(() {
        //2.2.1. Utilizamos la variable tipo list que hemos creado antes
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //2.3. Para que pueda suceder el cambio de estado colocamos el método en un initState
  @override
  void initState() {
    // TODO: implement initState
    getDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text('Lista de categorías'),
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
      body: Container(
        child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
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
                              //Datos
                              Text(
                                userData[index]['nombre'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                userData[index]['descripcion'],
                                style: TextStyle(fontSize: 14),
                              ),
                              //Iconos
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  color: Color.fromARGB(255, 245, 147, 0),
                                  onPressed: () {
                                    print('Editar');
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminCatEdit(
                                                widget.user,
                                                widget.name,
                                                userData[index]['id_categoria'],
                                                userData[index]['nombre'],
                                                userData[index]
                                                    ['descripcion'])));
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    deleteCat(userData[index]['id_categoria']
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
      ),
    );
  }
}
