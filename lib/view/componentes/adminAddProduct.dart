import 'dart:convert';

import 'package:flutter/material.dart';

import '../admin.dart';
import '../login.dart';
import 'adminCatInsert.dart';
import 'adminCatList.dart';
import 'adminListProducto.dart';
import 'package:http/http.dart' as http;

class AdminAddProduct extends StatefulWidget {
  String user;
  String name;
  AdminAddProduct(this.user, this.name);

  @override
  State<AdminAddProduct> createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  //1. Creamos los campos
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  //2. Creamos una list para poder llamar a la categoría
  List userData = [];
  //2.1. Cremos un controlador para el dropdown
  dynamic selectname;
  //3. Creamos la función para obtener los datos
  Future<void> getCat() async {
    //3.1. Traemos los datos en la url
    Uri url = Uri.parse("http://10.0.2.2/cajuephp/selectCat.php");
    //3.2. Creamos el try catch
    try {
      var response = await http.get(url);
      //3.3. Utilizamos para cambiar el estado
      setState(() {
        userData = jsonDecode(response.body);
        // print(userData);
      });
      //print(response.body);
    } catch (e) {
      print(e);
    }
  }

  //4 Función para insertar los datos
  Future<void> insertProduct(String idCat) async {
    //4.1. Comprobamos los campos
    if (name.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty) {
      //4.2. Try catch
      try {
        //4.1.1. Traemos el link
        Uri url = Uri.parse("http://10.0.2.2/cajuephp/insertProducto.php");
        var res = await http.post(url, body: {
          'idCat': idCat.toString(),
          'name': name.text,
          'price': price.text,
          'description': description.text,
        });
        print(res.body);
        //4.3. Comprobamos si se insertó
        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Producto insertado');
        } else {
          print('Error al insertar');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Campos vacíos');
    }
  }

  //3.4. Lo iniciamos para que pueda verse
  @override
  void initState() {
    super.initState();
    //selectname = userData.length;
    getCat();
  }

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
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: [
                  //1. Creamos el formulario
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        //1.1. Nombre
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
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Ingrese el nombre del producto',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //1.2. Precio
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
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Ingrese el precio',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //1.3. Descripción
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
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Ingrese una descripción',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        //Lista despegable

                        Container(
                          child: DropdownButton(
                            hint: Text('Seleccione una categoría'),
                            value: selectname,
                            items: userData.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem['nombre']),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectname = value;
                                print(selectname['id_categoria']);
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //1.4. Botón
                        GestureDetector(
                          onTap: () {
                            //getCat();
                            //Para insertar datos
                            /*  for (int i = 0; i < userData.length; i++) {
                              if (userData[i]['nombre'] == selectname) {
                                insertProduct(
                                    userData[i]['id_categoria'].toString());
                              }
                            } */

                            setState(() {
                              insertProduct(
                                  selectname['id_categoria'].toString());
                            });

                            // print('Hols');
                          },
                          child: Container(
                            width: 330,
                            height: 40,
                            margin:
                                EdgeInsets.only(left: 20, right: 10, top: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 5, 139, 34),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                'Agregar ',
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
                ],
              ),
            )),
      ),
    );
  }
}
