import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

const _months = [
  "OCAK",
  "ŞUBAT",
  "MART",
  "NİSAN",
  "MAYIS",
  "HAZİRAN",
  "TEMMUZ",
  "AĞUSTOS",
  "EYLÜL",
  "EKİM",
  "KASIM",
  "ARALIK"
];


//credentials olusturma
const _credentials = r'''
...
''';


//spreadsheet id
const _spreadsheetId = '...';




class SonKontrolPage extends StatefulWidget {
  dynamic surucuIndex;
  dynamic soforler = [];
  dynamic gidenler = [];
  dynamic donenler = [];
  var urunlerTamListe = ["Kazandibi", "Tavukgöğsü", "Sütlaç", "Güveç Sütlaç",
    "Trileçe", "Kıbrıs Tatlısı", "Profiterol", "Supangle", "Aşure",
    "Soğuk Baklava", "Ekmek Kadayıfı", "Ekler", "Su Böreği"];

  bool isProcessing = false;
  bool isDalogOpen = false;



  SonKontrolPage({required this.gidenler, required this.donenler, required this.soforler, required this.surucuIndex});

  @override
  State<SonKontrolPage> createState() => _SonKontrolPageState();
}



class _SonKontrolPageState extends State<SonKontrolPage> {

  void _showDialogAwait() {
    widget.isDalogOpen = true;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("İşlem Sürüyor. Lütfen Bekleyiniz...\n\nİşlem tamamlandıysa bu mesajı dikkate almayınız.")
        );
      },
    );
  }



  // user defined function
  void _showDialogDone() {
    Navigator.of(context).pop();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Veri Tabanına Kaydedildi."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }

  Future<void> kaydet() async{
    widget.isProcessing = true;
    var ay = DateTime.now().month;
    var gun = DateTime.now().day;
    _showDialogAwait();
    // init Gsheets
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    // get worksheet by its title
    var sheet = ss.worksheetByTitle(_months[ay-1]);
    for(int i = 0; i<13;i++){
      var satilan = widget.gidenler[i] - widget.donenler[i];
      var temp = satilan.toString().replaceAll('.', ',');
      sheet?.values.insertValue(temp, column: i+2, row: ((widget.surucuIndex*38)+gun+1));
    }
    for(int i = 0; i<13;i++){
      widget.gidenler[i] = 0;
      widget.donenler[i] = 0;
    }
    _showDialogDone();
  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    var urunlerTamListe = ["Kazandibi", "Tavukgöğsü", "Sütlaç", "Güveç Sütlaç",
      "Trileçe", "Kıbrıs Tatlısı", "Profiterol", "Supangle", "Aşure",
      "Soğuk Baklava", "Ekmek Kadayıfı", "Ekler", "Su Böreği"];

    var satilanUrunlerListe = [
      widget.gidenler[0] - widget.donenler[0],
      widget.gidenler[1] - widget.donenler[1],
      widget.gidenler[2] - widget.donenler[2],
      widget.gidenler[3] - widget.donenler[3],
      widget.gidenler[4] - widget.donenler[4],
      widget.gidenler[5] - widget.donenler[5],
      widget.gidenler[6] - widget.donenler[6],
      widget.gidenler[7] - widget.donenler[7],
      widget.gidenler[8] - widget.donenler[8],
      widget.gidenler[9] - widget.donenler[9],
      widget.gidenler[10] - widget.donenler[10],
      widget.gidenler[11] - widget.donenler[11],
      widget.gidenler[12] - widget.donenler[12],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.soforler[widget.surucuIndex]),
        actions: [
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: widget.isProcessing ? null : () async{
                setState(() {
                  widget.isProcessing = true;
                });
                await kaydet();
                setState(() {
                  widget.isProcessing = false;
                  widget.isDalogOpen = false;
                });
              }, icon:
              Icon(Icons.save_rounded)),
            ],
          ),
        )
        ],
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
      body:
      Stack(
        children: [
          Container(
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
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12,),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[0]}\n"
                                          " Dönen = ${widget.donenler[0]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[0]}",
                                    style: TextStyle(color: Color(0xFF03033b),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900
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
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[1]}\n"
                                          " Dönen = ${widget.donenler[1]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[1]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ekranGenisligi/12),
                              child: Container(
                                width: ekranGenisligi/2.5,
                                child: Text("${urunlerTamListe[2]}",
                                    style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[2]}\n"
                                          " Dönen = ${widget.donenler[2]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[2]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      ,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ekranGenisligi/12),
                              child: Container(
                                width: ekranGenisligi/2.5,
                                child: Text("${urunlerTamListe[3]}",
                                    style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[3]}\n"
                                          " Dönen = ${widget.donenler[3]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[3]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ekranGenisligi/12),
                              child: Container(
                                width: ekranGenisligi/2.5,
                                child: Text("${urunlerTamListe[4]}",
                                    style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[4]}\n"
                                          " Dönen = ${widget.donenler[4]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[4]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ekranGenisligi/12),
                              child: Container(
                                width: ekranGenisligi/2.5,
                                child: Text("${urunlerTamListe[5]}",
                                    style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[5]}\n"
                                          " Dönen = ${widget.donenler[5]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[5]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(
                              100.0))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ekranGenisligi/12),
                              child: Container(
                                width: ekranGenisligi/2.5,
                                child: Text("${urunlerTamListe[6]}",
                                    style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                              // İstenilen boşluk miktarını ayarlayabilirsiniz
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n  Giden = ${widget.gidenler[6]}\n"
                                          " Dönen = ${widget.donenler[6]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF03033b),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Satılan = ${satilanUrunlerListe[6]}",
                                      style: TextStyle(color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[7]}",
                                      style: TextStyle(
                                          color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[7]}\n"
                                            " Dönen = ${widget.donenler[7]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xFF03033b),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[7]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[8]}",
                                      style: TextStyle(
                                          color: Color(0xFF03033b),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[8]}\n"
                                            " Dönen = ${widget.donenler[8]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xFF03033b),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[8]}",
                                        style: TextStyle(color: Color(0xFF03033b),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF03033b),
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[9]}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[9]}\n"
                                            " Dönen = ${widget.donenler[9]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[9]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF03033b),
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[10]}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[10]}\n"
                                            " Dönen = ${widget.donenler[10]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[10]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF03033b),
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[11]}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[11]}\n"
                                            " Dönen = ${widget.donenler[11]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[11]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ekranGenisligi / 50,
                      right: ekranGenisligi / 50,
                      bottom: ekranYuksekligi / 70,
                      top: ekranYuksekligi / 70),
                  child: Container(
                    height: ekranYuksekligi / 6,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF03033b),
                            borderRadius: BorderRadius.all(Radius.circular(
                                100.0)
                            )
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ekranGenisligi/12),
                                child: Container(
                                  width: ekranGenisligi/2.5,
                                  child: Text("${urunlerTamListe[12]}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ekranGenisligi/12, right: ekranGenisligi/12),
                                // İstenilen boşluk miktarını ayarlayabilirsiniz
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "\n  Giden = ${widget.gidenler[12]}\n"
                                            " Dönen = ${widget.donenler[12]}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Satılan = ${satilanUrunlerListe[12]}",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
          )
        ],
      ),
    );
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

