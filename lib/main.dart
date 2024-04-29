import 'dart:ui';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:servisuruntakipportali/DonenUrunlerPage.dart';
import 'text.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servis Ürün Takip Portalı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const GidenUrunlerPage(),
    );
  }
}




class GidenUrunlerPage extends StatefulWidget {
  const GidenUrunlerPage({super.key});



  @override
  State<GidenUrunlerPage> createState() => _GidenUrunlerPageState();


}

class _GidenUrunlerPageState extends State<GidenUrunlerPage> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  tepsiMiKontrolTrilece(){
    if(radioDegerTrilece == 1){
      gidenUrunlerDefaultGirdi[4] *= 12;
    }
  }
  tepsiMiKontrolKibris(){
    if(radioDegerKibris == 1){
      gidenUrunlerDefaultGirdi[5] *= 12;
    }
  }

  int sumGidenAdet = 0;
  double sumGidenSogukBaklava = 0;
  double sumGidenEkmekKadayifi = 0;
  double sumGidenEkler = 0;
  double sumGidenSuBoregi = 0;
  var tempText = '';
  int tempInt = 1;
  int radioDegerTrilece = 1;
  int radioDegerKibris = 1;

  int soforIndex = 0;


  TextEditingController _textEditingController = TextEditingController();

  int ctr = 0;

  var urunlerSatisFormat = ["ADET", "TEPSİ"];

  var urunlerTamListe = ["Kazandibi", "Tavukgöğsü", "Sütlaç", "Güveç Sütlaç",
    "Trileçe", "Kıbrıs Tatlısı", "Profiterol", "Supangle", "Aşure",
    "Soğuk Baklava", "Ekmek Kadayıfı", "Ekler", "Su Böreği"];

  var gidenUrunlerDefaultGirdi = [
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

  var soforler = [
    "Fatih Birinci",
    "Mustafa Ebubekir Birinci",
    "Muhammed Şamil Birinci"
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
            icon: Icon(Icons.info_outline_rounded), // Düğmenin ikonu
            onPressed: () {
              _showInfoCard(context);
            },
          ),
        ),

        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<int>(
                dropdownColor: Color(0xFF03033b),
                value: soforIndex,
                onChanged: (newValueIndex) {
                  setState(() {
                    soforIndex = newValueIndex!;
                  });
                },
                items: List<DropdownMenuItem<int>>.generate(soforler.length, (int index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Center(
                        child: Text(soforler[index], style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600))
                    ),
                  );
                }),
              ),
              IconButton(onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonenUrunlerPage(giden_urunler: gidenUrunlerDefaultGirdi, soforler: soforler, soforIndex: soforIndex)), // İkinci sayfa için MaterialPageRoute kullanın
                  );
                });
              }, icon: Icon(Icons.arrow_forward_rounded, size: 24,))
            ],
          ),
        ),
        flexibleSpace:
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
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
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
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
                            gidenUrunlerDefaultGirdi[0].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: gidenUrunlerDefaultGirdi[0].toString()
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);
                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[0] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[0].toString(),
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
                            gidenUrunlerDefaultGirdi[1].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[1].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[1] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[1].toString(),
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
                            gidenUrunlerDefaultGirdi[2].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[2].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[2] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[2].toString(),
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
                            gidenUrunlerDefaultGirdi[3].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[3].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[3] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[3].toString(),
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
                            gidenUrunlerDefaultGirdi[4].toInt().toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[4].toInt().toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[4] =
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(
                                  100.0)
                              )
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsets.only(left: ekranGenisligi/24, right: ekranGenisligi/24),
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
                                            color: Color(0xFF03033b)),),
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
                                        gidenUrunlerDefaultGirdi[4].toInt().toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text("(ADET)",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12
                                      ),)
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
                            gidenUrunlerDefaultGirdi[5].toInt().toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[5].toInt().toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[5] =
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
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsets.only(right: ekranGenisligi/24, left: ekranGenisligi/24),
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
                                        gidenUrunlerDefaultGirdi[5].toInt().toString(),
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
                                      )
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
                            gidenUrunlerDefaultGirdi[6].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[6].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[6] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[6].toString(),
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
                            gidenUrunlerDefaultGirdi[7].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[7].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[7] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[7].toString(),
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
                            gidenUrunlerDefaultGirdi[8].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: gidenUrunlerDefaultGirdi[8].toString(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      dynamic girdi = parseUserInput(
                                          _textEditingController.text);

                                      if (girdi is int) {
                                        gidenUrunlerDefaultGirdi[8] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[8].toString(),
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
                            gidenUrunlerDefaultGirdi[9].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: gidenUrunlerDefaultGirdi[9].toString(),
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
                                        gidenUrunlerDefaultGirdi[9] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        gidenUrunlerDefaultGirdi[9] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        gidenUrunlerDefaultGirdi[9].toString(),
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
                            gidenUrunlerDefaultGirdi[10].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: gidenUrunlerDefaultGirdi[10].toString(),
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
                                        gidenUrunlerDefaultGirdi[10] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        gidenUrunlerDefaultGirdi[10] =
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
                                    padding: EdgeInsets.only(right: ekranGenisligi/10,),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        gidenUrunlerDefaultGirdi[10].toString(),
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
                            gidenUrunlerDefaultGirdi[11].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: gidenUrunlerDefaultGirdi[11].toString(),
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
                                        gidenUrunlerDefaultGirdi[11] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        gidenUrunlerDefaultGirdi[11] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Text("${urunlerTamListe[11]}",
                                      style: TextStyle(color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12,),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        gidenUrunlerDefaultGirdi[11].toString(),
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
                            gidenUrunlerDefaultGirdi[12].toString();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(ProjectTexts().gidenMiktarEditText),
                              content: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: gidenUrunlerDefaultGirdi[12].toString(),
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
                                        gidenUrunlerDefaultGirdi[12] =
                                            girdi;
                                        Navigator.of(context).pop();
                                      } else if (girdi is double) {
                                        gidenUrunlerDefaultGirdi[12] =
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ekranGenisligi/12),
                                    child: Text("${urunlerTamListe[12]}",
                                      style: TextStyle(color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: ekranGenisligi/12),
                                    // İstenilen boşluk miktarını ayarlayabilirsiniz
                                    child: Container(
                                      width: ekranGenisligi/3,
                                      child: Text(
                                        textAlign: TextAlign.right,
                                        gidenUrunlerDefaultGirdi[12].toString(),
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
                        _launchURL("https://www.birincitatli.com/");
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

    int? intValue = int.tryParse(input);
    if (intValue != null) {
      return intValue;
    }

    double? doubleValue = double.tryParse(input);
    if (doubleValue != null) {
      return doubleValue;
    }
    return input;
  }

  void redirectToEmail(String emailUri) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: Uri.parse(emailUri).toString(),
    );

    try {
      await intent.launch();
    } on PlatformException catch (e) {
      print('Error launching email: $e');
    }
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

  void _makePhoneCall(String phoneNumber) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.DIAL',
      data: 'tel:$phoneNumber',
    );
    try {
      await intent.launch();
    } on PlatformException catch (e) {
      print('Error launching phone call: $e');
    }
  }

  void _showContacts(BuildContext context, phone_number, mail_address) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: (){
                //_sendEmail(mail_address);
                  redirectToEmail('mailto:$mail_address?subject=Konu: &body=İçerik: ');
              }, child: Image.asset("resimler/contact-mail-icon.png",
              width: ekranGenisligi/5,
              height: ekranYuksekligi/13)
              ),
              Container(width: ekranGenisligi/40, height: ekranYuksekligi/100,),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: (){
                    _makePhoneCall(phone_number);
                  }, child: Image.asset("resimler/contact-call-icon.jpg",
                    width: ekranGenisligi/5,
                    height: ekranYuksekligi/13
                    ),
              )
            ],
          ),
        );
      },
    );
  }


  void _showInfoCard(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Image.asset("resimler/birinci-tatli-logo.png",
            width: 120,
            height: 120,),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white70, minimumSize: Size(ekranGenisligi/1.8, ekranYuksekligi/8)),
                      onPressed: (){
                      _showContacts(context,"+90545*******", "mebirinci@gmail.com");
                    },
                      child: const Text(
                        "\nCEO Info;\n"
                            "Mustafa Ebubekir Birinci\n"
                            "mebirinci@gmail.com\n"
                            "+90 545 *** ** **\n",
                        style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(height: ekranYuksekligi/50),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                      onPressed: (){
                        _showContacts(context,"+90537*******", "omerbirinci3734@gmail.com");
                    },
                      child: const Text("\nDev. Info;\n"
                          "Ömer Faruk Birinci\n"
                          "omerbirinci3734@gmail.com\n"
                          "+90 537 *** ** **\n",
                          style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w800)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}