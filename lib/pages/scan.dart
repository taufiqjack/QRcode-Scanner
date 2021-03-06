import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  Scan({Key key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final GlobalKey qrKey = GlobalKey();
  var qrTetxt;
  QRViewController controller;

  void _onQRviewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrTetxt = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRviewCreate,
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text('Hasil Scan : $qrTetxt'),
                ))
          ],
        ),
      ),
    );
  }
}