import 'dart:ui';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:servisuruntakipportali/SonKontrolPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DonenUrunlerPage(giden_urunler: [], soforler: [], soforIndex: 0,),
    );
  }
}




class DonenUrunlerPage extends StatefulWidget {

  var giden_urunler = [];
  var soforler = [];
  var soforIndex = 0;
  DonenUrunlerPage({required this.giden_urunler, required this.soforler, required this.soforIndex});

  @override
  State<DonenUrunlerPage> createState() => _DonenUrunlerPageState();


}

class _DonenUrunlerPageState extends State<DonenUrunlerPage> {

  tepsiMiKontrolTrilece(){
    if(radioDegerTrilece == 1){
      donen_urunler_default_girdi[4] *= 12;
    }
  }
  tepsiMiKontrolKibris(){
    if(radioDegerKibris == 1){
      donen_urunler_default_girdi[5] *= 12;
    }
  }
  TextEditingController _textEditingController = TextEditingController();

  int sum_donen_adet = 0;
  double sum_donen_soguk_baklava = 0;
  double sum_donen_ekmek_kadayifi = 0;
  double sum_donen_ekler = 0;
  double sum_donen_su_boregi = 0;
  int tempInt = 1;
  int radioDegerTrilece = 1;
  int radioDegerKibris = 1;

  int ctr = 0;

  var urunlerSatisFormat = ["ADET", "TEPSİ"];

  var urunlerTamListe = ["Kazandibi", "Tavukgöğsü", "Sütlaç", "Güveç Sütlaç",
    "Trileçe", "Kıbrıs Tatlısı", "Profiterol", "Supangle", "Aşure",
    "Soğuk Baklava", "Ekmek Kadayıfı", "Ekler", "Su Böreği"];

  var donen_urunler_default_girdi = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Container(width: 160,
                child: TextButton(
                  child: Center(
                      child: Column(
                        children: [
                          Text("Dönenler",
                            style: TextStyle(color: Colors.white, fontSize: 16),)
                        ],
                      )),
                  onPressed: (){
                    _launchURL('https://www.birincitatli.com/');
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: IconButton(onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SonKontrolPage(gidenler: widget.giden_urunler, donenler: donen_urunler_default_girdi, soforler: widget.soforler, surucuIndex: widget.soforIndex,)),
                  );
                });
              }, icon: Icon(Icons.arrow_forward_rounded, size: 24,)),
            )
          ],
        ),
        flexibleSpace:
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightBlue.shade700,
                  Colors.deepPurpleAccent.shade100,
                ],
              )
          ),
        ),
      ),
      body: Stack(
          children: [
            Center(
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue,
                          Colors.pinkAccent,
                        ],
                      )
                  ),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white
                    ),
                  )
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(
                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[0].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[0].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);
                                      if (girdi is int) {
                                        donen_urunler_default_girdi[0] = girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[0]}",
                                          style: TextStyle(
                                              color: Color(0xFF03033b),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.start),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[0].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[1].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[1].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[1] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[1]}",
                                          style: TextStyle(
                                              color: Color(0xFF03033b),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.start),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[1].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[2].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[2].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[2] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[2]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[2].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[3].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[3].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[3] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[3]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[3].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(
                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[4].toInt().toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[4].toInt().toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[4] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                      tepsiMiKontrolTrilece();
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 6,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text(
                                    "${urunlerTamListe[4]}",
                                    style: TextStyle(color: Color(0xFF03033b),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/24 ,right: ekranGenisligi/24),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                          value: 0,
                                          groupValue: radioDegerTrilece,
                                          onChanged: (value) {
                                            setState(() {
                                              radioDegerTrilece = 0;
                                            });
                                          }
                                      ),
                                      Text('${urunlerSatisFormat[0]}',
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF03033b)),
                                      ),
                                      Radio(
                                        value: 1,
                                        groupValue: radioDegerTrilece,
                                        onChanged: (value) {
                                          setState(() {
                                            radioDegerTrilece = 1;
                                          });
                                        },
                                      ),
                                      Text('${urunlerSatisFormat[1]}',
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF03033b)),),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: Container(
                                  width: ekranGenisligi/8,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[4].toInt().toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text("(ADET)",
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(
                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[5].toInt().toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[5].toInt().toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[5] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                      tepsiMiKontrolKibris();
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 6,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text(
                                    "${urunlerTamListe[5]}",
                                    style: TextStyle(color: Color(0xFF03033b),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/24, right: ekranGenisligi/24),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: 0,
                                        groupValue: radioDegerKibris,
                                        onChanged: (value) {
                                          setState(() {
                                            radioDegerKibris = 0;
                                          });
                                        },
                                      ),
                                      Text('${urunlerSatisFormat[0]}',
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF03033b)),),
                                      Radio(
                                        value: 1,
                                        groupValue: radioDegerKibris,
                                        onChanged: (value) {
                                          setState(() {
                                            radioDegerKibris = 1;
                                          });
                                        },
                                      ),
                                      Text('${urunlerSatisFormat[1]}',
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF03033b)),),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: Container(
                                  width: ekranGenisligi/8,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[5].toInt().toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text("(ADET)",
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[6].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[6].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[6] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[6]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[6].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[7].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[7].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[7] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[7]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[7].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],

                              )
                          ),
                        ),
                      ),
                    ),
                  ), Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[8].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[8].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[8] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[8]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[8].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[9].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[9].toString(),
                                    helperText: ProjectTexts().inputHint
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[9] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        donen_urunler_default_girdi[9] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF03033b),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[9]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[9].toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[10].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[10].toString(),
                                    helperText: ProjectTexts().inputHint
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[10] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        donen_urunler_default_girdi[10] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF03033b),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[10]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[10].toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[11].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[11].toString(),
                                    helperText: ProjectTexts().inputHint
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[11] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        donen_urunler_default_girdi[11] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF03033b),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[11]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[11].toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ekranGenisligi / 50,
                        right: ekranGenisligi / 50,
                        bottom: ekranYuksekligi / 70,
                        top: ekranYuksekligi / 70),
                    child: GestureDetector(

                      onTap: () {
                        _textEditingController.text =
                            donen_urunler_default_girdi[12].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().donenMiktarEditText, style: TextStyle(fontSize: 19),),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: donen_urunler_default_girdi[12].toString(),
                                    helperText: ProjectTexts().inputHint
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        donen_urunler_default_girdi[12] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        donen_urunler_default_girdi[12] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else {
                                      }
                                    });
                                  },
                                  child: Text('Kaydet'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Container(
                        height: ekranYuksekligi / 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF03033b),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  100.0))),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Container(
                                      width: ekranGenisligi/2.5,
                                      child: Text("${urunlerTamListe[12]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.start,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        donen_urunler_default_girdi[12].toString(),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: ekranYuksekligi/8,
                    height: ekranYuksekligi/8,
                    child: TextButton(
                      child: Center(
                          child: Image.asset("resimler/birinci-tatli-logo.png",)
                      ),
                      onPressed: (){
                        _launchURL('https://www.birincitatli.com/');
                      }
                    ),
                  )
                ],
              ),
            ),
          ]
      ),


    );
  }

  dynamic parseUserInput(String input) {
    // Önce integer olarak dene
    int? intValue = int.tryParse(input);
    if (intValue != null) {
      return intValue;
    }
    // Sonra double olarak dene
    double? doubleValue = double.tryParse(input);
    if (doubleValue != null) {
      return doubleValue;
    }
    return input;
  }

  void _launchURL(String url) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: Uri.parse(url).toString(),
    );

    try {
      await intent.launch();
    } on PlatformException catch (e) {
      print('Error launching website: $e');
    }
  }
}