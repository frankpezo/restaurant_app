import 'dart:convert';

import 'package:flutter/material.dart';

import '../login.dart';
import 'catMesero.dart';
import 'package:http/http.dart' as http; //Para consumir la Api

class PedidoProductLista extends StatefulWidget {
  String user;
  String name;
  String produName;
  String id;
  String precio;
  PedidoProductLista(
      this.user, this.name, this.produName, this.id, this.precio);

  @override
  State<PedidoProductLista> createState() => _PedidoProductListaState();
}

class _PedidoProductListaState extends State<PedidoProductLista> {
  //Creamos los edit controler
  TextEditingController id = TextEditingController();
  TextEditingController precio = TextEditingController();
  int cant = 0;
  double total = 0;

  //1.1. Hacemos el init para cambiar los valores
  @override
  void initState() {
    id.text = widget.id;
    precio.text = widget.precio;
    super.initState();
  }

  //2. Función para insertar a la base de datos
  //Pasamos tres parametros para que se envíe en la base de datos
  Future<void> inserDeta(/* idP, */ cantidad, monto) async {
    //2.1. Hacemos el try-catch
    try {
      //2.2. Traemos el link
      Uri url = Uri.parse("http://10.0.2.2/cajuephp/mesero/insertDetai.php");
      var res = await http.post(url, body: {
        /*   'idP': idP.toString(), */
        'cantidad': cantidad.toString(),
        'monto': monto.toString(),
      });

      print(res.body);
      /*   var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        print('Se inserto correctamente');
      } else {
        print('Error al insertar');
      } */
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1. Creamos el drawer
      appBar: AppBar(
        title: Text(widget.produName),
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
                        /*           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmpleadoView())); */
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
                    //Producto
                    ListTile(
                      leading: Icon(Icons.category),
                      title: Text(
                        'Pedido',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        /*    Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CatMesero(widget.user, widget.name))); */
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

      //Body
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                //margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),

                margin: EdgeInsets.only(
                  top: 150,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.produName}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 91, 20, 20),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'S/. $total',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.greenAccent,
                                      minimumSize: Size(5, 3)),
                                  onPressed: () {
                                    setState(() {
                                      if (cant >= 1) {
                                        cant -= 1;
                                        total =
                                            cant * double.parse(precio.text);
                                      }
                                    });
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(fontSize: 22),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Card(
                                elevation: 8,
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${cant}',
                                    //'${mainProductos[index].cantidad}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 88, 191, 141),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.greenAccent,
                                      minimumSize: Size(5, 3)),
                                  onPressed: () {
                                    print('más');
                                    setState(() {
                                      cant += 1;
                                      total = cant * double.parse(precio.text);
                                    });
                                  },
                                  child: Text(
                                    '+',
                                    style: TextStyle(fontSize: 22),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  minimumSize: Size(10, 10)),
                              onPressed: () {
                                print('Apretado');
                                inserDeta(cant, total);
                                //Para enviar los datos
                                /*  Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) {
                                                                return ListaPedidosEm(
                                                                  produ: mainProductos[
                                                                      index],
                                                                );
                                                              }),
                                                            ); */
                              },
                              child: Text(
                                'Enviar',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
