import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          child: Text('scan qr code'),
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  GlobalKey globalKey=GlobalKey();

  //Barcode qrText;

  var qrText='';
  QRViewController qrViewController;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,

            child: QRView(
                key: globalKey,
                overlay:  QrScannerOverlayShape(
                  borderRadius: 10,
                  borderColor: Colors.red,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
                onQRViewCreated: _onQRViewCreated),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: qrText!=null? Text('scan code result $qrText'):Text("Scan a code"),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    qrViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController=qrViewController;
    
    qrViewController.scannedDataStream.listen((scanData) {
      setState(() {

        print(" scan data $scanData");

        qrText=scanData;


      });
    });
  }
}
