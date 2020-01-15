import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bottom_ui/check.dart';
import 'package:bottom_ui/camera.dart';
import 'package:bottom_ui/tabBar.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    routes: <String, WidgetBuilder>{
      "/camera": (BuildContext context) => new MyCameraApp(),
      "/tabBar": (BuildContext context) => new MyTabApp(),
    },
  ));
}

Color _homeIcon = Colors.black;
Color _feedIcon = Colors.black;
Color _cartIcon = Colors.black;
Color _accountIcon = Colors.black;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  File _image;
  String barcode = "";
  File galleryFile;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget image_carousel = new Container(
    height: 200,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/img/product.jpg'),
        AssetImage('assets/img/product2.jpg'),
        AssetImage('assets/img/ss.jpg'),
        AssetImage('assets/img/product.jpg'),
        AssetImage('assets/img/product2.jpg'),
      ],
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    ),
  );
  //int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              actions: <Widget>[
                Container(
                    margin:
                        EdgeInsets.only(top: 4, bottom: 10, left: 2, right: 2),
                    padding: EdgeInsets.only(bottom: 8),
                    height: 2,
                    width: 250,
                    decoration: new BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(60))),
                    child: new Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(60),
                            ),
                            hintText: 'I\'m shopping for...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                    )),
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  color: Colors.white,
                  onPressed: getImage,
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Camera"),
                    trailing: Icon(Icons.home),
                    onTap: () {
                      Navigator.of(context).pushNamed("/camera");
                    },
                  ),
                  ListTile(
                    title: Text("TabBar Page"),
                    trailing: Icon(Icons.contact_phone),
                    onTap: () {
                      Navigator.of(context).pushNamed("/tabBar");
                    },
                  ),
                  ListTile(
                      title: Text("Item 3"),
                      trailing: Icon(Icons.system_update)),
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Container(
              color: Colors.pink[50],
              height: 2000,
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Stack(alignment: Alignment.topCenter,
                      //alignment:new Alignment(x, y)
                      children: <Widget>[
                        Container(
                            height: 30,
                            width: 400,
                            child: new Container(
                              decoration: new BoxDecoration(

                                  // Box decoration takes a gradient
                                  gradient: LinearGradient(
                                    // Where the linear gradient begins and ends
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    // Add one stop for each color. Stops should increase from 0 to 1
                                    stops: [0.1, 0.5, 0.7],
                                    colors: [
                                      // Colors are easy thanks to Flutter's Colors class.
                                      Colors.brown[800],
                                      Colors.brown[700],
                                      Colors.brown[500],
                                    ],
                                  ),
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft:
                                          const Radius.elliptical(30.0, 30.0),
                                      bottomRight:
                                          const Radius.elliptical(30.0, 30.0))),
                            )),
                        new Positioned(
                          child: Container(
                            height: 180,
                            width: 320,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: ListView(
                                children: <Widget>[image_carousel],
                              ),
                            ),
                            /*decoration: new BoxDecoration(
                                color: Colors.black,
                                borderRadius: new BorderRadius.only(
                                    bottomLeft:
                                        const Radius.elliptical(30.0, 30.0),
                                    bottomRight:
                                        const Radius.elliptical(30.0, 30.0))),
                            child: ListView(
                              children: <Widget>[image_carousel],
                            ),*/
                          ),
                        )
                      ]),
                  Container(
                    margin: EdgeInsets.all(6),
                    height: 100,
                    width: 350,
                    //circular button container
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding:
                        EdgeInsets.only(top: 1, right: 5, left: 5, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => CheckApp()));
                                },
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/img/category1.jpg')))),
                              ),
                              Text('Categories',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => CheckApp()));
                                },
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/img/category2.jpg')))),
                              ),
                              Text('Coins &\n Coupons',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => CheckApp()));
                                },
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/img/category3.jpg')))),
                              ),
                              Text('Freebies',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => CheckApp()));
                                },
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/img/category4.jpg')))),
                              ),
                              Text('Group \nBuy',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(4),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => CheckApp()));
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/img/category5.jpg')))),
                                ),
                                Text(
                                  'Top \nSelection',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 400,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: 20,
                            child: Image.asset('assets/plus.png')),
                        Container(
                            height: 20,
                            width: 300,
                            child: Text('New User Zone',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12)))
                      ],
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    height: 50,
                    width: 400,

                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Image.asset('assets/img/midbanner.jpg',
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(
                      //color: Colors.grey,
                      //),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(top: 3, right: 8),
                        height: 20,
                        width: 330,
                        alignment: Alignment.centerLeft,
                        child: Text('Ideas for your First Order',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: 2, left: 5, right: 5, bottom: 2),
                          height: 150,
                          width: 360,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(3),
                                    height: 130,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      // color: Colors.white12,
                                      // ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/img/ss.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Text('US \$3.05')
                                    ])),
                                Container(
                                    padding: EdgeInsets.all(3),
                                    height: 130,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      //border: Border.all(
                                      //  color: Colors.white12,
                                      //  ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/img/ss.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Text('US \$3.05')
                                    ])),
                                Container(
                                    padding: EdgeInsets.all(3),
                                    height: 130,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      //border: Border.all(
                                      //color: Colors.white12,
                                      //),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/img/ss.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Text('US \$3.05')
                                    ])),
                                Container(
                                    padding: EdgeInsets.all(3),
                                    height: 130,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //color: Colors.white12,
                                      //),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Column(children: [
                                      Image.asset(
                                        'assets/img/ss.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Text('US \$3.05')
                                    ])),
                              ]))
                    ]),
                  ),
                  Container(
                    height: 180,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white12,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.only(top: 3, right: 8),
                        height: 20,
                        width: 330,
                        alignment: Alignment.centerLeft,
                        child: Text('Flash Deals',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: 2, left: 5, right: 5, bottom: 2),
                        height: 150,
                        width: 380,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(3),
                                  height: 130,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/img/ss.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                    Text('US \$3.05')
                                  ])),
                              Container(
                                  padding: EdgeInsets.all(3),
                                  height: 130,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    //border: Border.all(
                                    //color: Colors.white12,
                                    //),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/img/ss.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                    Text('US \$3.05')
                                  ])),
                              Container(
                                  padding: EdgeInsets.all(3),
                                  height: 130,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //color: Colors.white12,
                                    //),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/img/ss.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                    Text('US \$3.05')
                                  ])),
                              Container(
                                  padding: EdgeInsets.all(3),
                                  height: 130,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    // color: Colors.white12,
                                    //),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Column(children: [
                                    Image.asset(
                                      'assets/img/ss.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                    Text('US \$3.05')
                                  ])),
                            ]),
                      )
                    ]),
                  ),
                  //Container for baby dress start
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(2),
                    height: 280,
                    width: 370,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 270,
                          width: 170,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 2, left: 2, right: 2),
                                height: 200,
                                width: 170,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.asset('assets/img/product.jpg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                child: Text('Red/pink Baby Girls Dress',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                              Container(
                                child: Text('US \$2.88',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                              ),
                              Container(
                                child: Text(
                                  '32 sold',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 270,
                          width: 170,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 2, left: 2, right: 2),
                                height: 200,
                                width: 170,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.asset('assets/img/product.jpg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                child: Text('Red/pink Baby Girls Dress',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                              Container(
                                child: Text('US \$2.88',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                              ),
                              Container(
                                child: Text(
                                  '32 sold',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(2),
                    height: 280,
                    width: 370,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 270,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 2, left: 2, right: 2),
                                height: 200,
                                width: 170,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.asset('assets/img/product2.jpg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                child: Text('Red/pink Baby Girls Dress',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                              Container(
                                child: Text('US \$2.88',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                              ),
                              Container(
                                child: Text(
                                  '32 sold',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 270,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 2, left: 2, right: 2),
                                height: 200,
                                width: 170,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.asset('assets/img/product2.jpg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                child: Text('Red/pink Baby Girls Dress',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                              Container(
                                child: Text('US \$2.88',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                              ),
                              Container(
                                child: Text(
                                  '32 sold',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 300,
                          child: new RaisedButton(
                              onPressed: barcodeScanning,
                              child: new Text("Capture")),
                          padding: const EdgeInsets.all(5.0),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(5.0),
                        ),
                        new Text("Barcode Number after Scan : " + barcode),
                      ],
                    ),
                  )
                ],
              ),
            )),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                new BottomNavigationBarItem(
                  icon: IconButton(
                      icon: Icon(Icons.home),
                      color: _homeIcon,
                      onPressed: () {
                        setState(() {
                          _homeIcon = Colors.red;
                          _feedIcon = Colors.black;
                          _cartIcon = Colors.black;
                          _accountIcon = Colors.black;
                        });
                      }),
                  title: Text(
                    'Home',
                    style: TextStyle(color: _homeIcon),
                  ),
                ),
                new BottomNavigationBarItem(
                    icon: IconButton(
                        color: _feedIcon,
                        icon: Icon(Icons.wifi),
                        onPressed: () {
                          setState(() {
                            _homeIcon = Colors.black;
                            _feedIcon = Colors.red;
                            _cartIcon = Colors.black;
                            _accountIcon = Colors.black;
                          });
                        }),
                    title: Text(
                      'Feed',
                      style: TextStyle(color: _feedIcon),
                    )),
                new BottomNavigationBarItem(
                    icon: IconButton(
                        color: _cartIcon,
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          setState(() {
                            _homeIcon = Colors.black;
                            _feedIcon = Colors.black;
                            _cartIcon = Colors.red;
                            _accountIcon = Colors.black;
                          });
                        }),
                    title: Text(
                      'Cart',
                      style: TextStyle(color: _cartIcon),
                    )),
                new BottomNavigationBarItem(
                  icon: IconButton(
                      color: _accountIcon,
                      icon: Icon(Icons.account_circle),
                      onPressed: () {
                        setState(() {
                          _homeIcon = Colors.black;
                          _feedIcon = Colors.black;
                          _cartIcon = Colors.black;
                          _accountIcon = Colors.red;
                        });
                      }),
                  title: Text(
                    'Account',
                    style: TextStyle(
                      color: _accountIcon,
                    ),
                  ),
                ),
              ],
            )));
  }

  // Method for scanning barcode....
  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
