import 'package:flutter/material.dart';
import 'package:onlinetranslator/Pages/home.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinetranslator/api/translation_api.dart';

import 'dart:io';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _FirstState();
}

const title_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.blueGrey,
);

const button_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const subtitile_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.blueGrey,
);


const scannedText_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const translatedText_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.green,
);


bool textScanning = false;
String scannedText = '';

XFile? imageFile;
final Map<String, String> word = {};

bool isTranslating = false;
String translatedText = "";


class _FirstState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 20,
          margin: EdgeInsets.all(8),
          child: Container(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text("تشخیص متن", style: title_style),
                  SizedBox(height: 2),
                  imageFile==null?
                  Text(
                    "با استفاده از این تکنولوژی میتوانید به راحتی لغات موجود درون تصاویر را با دوربین موبایل خود اسکن کرده و آن ها را ترجمه کنید و یا در نرم افزارهای دیگر استفاده نمایید",
                    style: subtitile_style,
                    textDirection: TextDirection.rtl,) :
                      SizedBox(height: 1,),
                  imageFile == null ? SizedBox(height: 5) : SizedBox(height: 0,),
                  imageFile == null ?

                  Image.asset("assets/scanning.gif", width: 200, height: 200) :
                      Image.file(File(imageFile!.path), width: 250, height: 200,),

                  //for result
                  textScanning == true ?
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircularProgressIndicator(),
                      ) :

                  Container(
                    height: imageFile == null ? 100 : 175,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      elevation: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(scannedText, maxLines: 9, style: scannedText_style,),
                          Text(translatedText, maxLines: 9, style: translatedText_style,),
                        ],
                      ),


                    ),


                  ),

                  SizedBox(height: 7),


                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: MaterialButton(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            padding: EdgeInsets.zero,
                            color: Colors.blue,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image, color: Colors.white, size: 24),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "اسکن از گالری",
                                      style: button_style,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: MaterialButton(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            padding: EdgeInsets.zero,
                            color: Colors.blue,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "اسکن با دوربین",
                                      style: button_style,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  ,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          textScanning = true;
          imageFile = pickedImage;
        });

        getRecognisedText(pickedImage);
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
        scannedText = "Error While Scanning";
      });
    }
  }

  Future<void> getRecognisedText(XFile image) async {
    word.clear();
    scannedText = '';
    translatedText = '';

    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );

    try {
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          word.addAll({line.text: 'none'});
          scannedText += '${line.text}\n';
        }
      }
    } finally {
      await textRecognizer.close();
    }

    print(word);

    if (!mounted) return;

    setState(() {
      textScanning = false;
    });

    translate_fun();
  }

  void translate_fun() async {
    isTranslating = true;
    for(var word_key in word.keys){
      final word_translated = await TranslationApi.translate(word_key, 'en', 'fa');
      word.update(word_key, (value) => word_translated);
    }

    for(var word_value in word.values){
      translatedText = translatedText + word_value + "\n";
    }

    isTranslating = false;
    setState(() {

    });
  }

}
