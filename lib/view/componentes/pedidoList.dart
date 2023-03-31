import 'package:flutter/material.dart';

import '../login.dart';
import 'catMesero.dart';

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
                      /*   //id
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
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'id',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                      ), */
                      /*  SizedBox(
                        height: 15,
                      ),
                      //Name
              
                      SizedBox(
                        height: 15,
                      ), */
                      //Price
                      /*    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: 340,
                        height: 40,
                        padding: const EdgeInsets.only(top: 3, left: 15),
                        child: TextFormField(
                          //2. Para acceder
                          controller: precio,
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
                      ), */
                      /*  SizedBox(
                        height: 15,
                      ),
              
                      GestureDetector(
                        //1. Para que nos lleve a la página deseada
                        onTap: () {
                          //Aquí debe ir la función de la API
                          //updateProduct();
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
                              'Enviar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ), */
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
