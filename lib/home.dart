import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import './pdf_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = 'No File Chosen';
  String pathPDF = "";

  Future<void> _pickFile() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      File file = File(result.files.first.path);

      setState(() {
        pathPDF = file.path;
      });

      PlatformFile files = result.files.first;

      setState(() {
        text = files.name;
      });

      print(files.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Pdf Uploader and Viewer',
            style: GoogleFonts.roboto(color: Colors.white)),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(color: Colors.black)),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Pick File',
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
                onPressed: _pickFile),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'View File',
                style: GoogleFonts.roboto(color: Colors.white),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfScreen(pathPDF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
