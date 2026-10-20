import 'package:flutter/material.dart';
import 'package:onlinetranslator/Pages/home.dart';
import 'package:onlinetranslator/api/translation_api.dart';
import 'package:onlinetranslator/api/translations.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

const tab_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.blueGrey,
);

const button_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

List<String> source = [
  "انگلیسی",
  "اسپانیایی",
  "فرانسوی",
  "آلمانی",
  "ایتالیایی",
  "روسی",
  "فارسی",
];

List<String> destination = [
  "فارسی",
  "روسی",
  "ایتالیایی",
  "آلمانی",
  "فرانسوی",
  "اسپانیایی",
  "انگلیسی",
];

String selectedItem_source = 'انگلیسی';
String selectedItem_destination = 'فارسی';
TextEditingController _controller = TextEditingController();

class _FirstState extends State<First> {
  String language1 = Translations.language_latin.first;
  String language2 = Translations.language_latin.last;
  String result_value = '';

  TextToSpeech tts = TextToSpeech();

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox.expand(
          child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 20,
          margin: EdgeInsets.all(8),
          child: Container(
            margin: EdgeInsets.all(8),
            
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
              
                    children: [
                      Text("زبان مقصد", style: tab_style),
              
                      Text("زبان مبدا", style: tab_style),
                    ],
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // for destination
              
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 80,
                          height: 48,
                          margin: EdgeInsets.all(16),
                          child: DropdownButtonFormField<String>(
                            style: tab_style,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: Colors.grey[200],
                            ),
                            value: selectedItem_destination,
                            items: destination
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: tab_style,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    alignment: AlignmentDirectional.centerEnd,
                                  ),
                                )
                                .toList(),
              
                            onChanged: (item) => setState(() {
                              selectedItem_destination = item!;
              
                              String? res = Translations.language_map[item];
                              language2 = res!;
                              print(language2);
                            }),
                          ),
                        ),
                      ),
              
                      // for source
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 80,
                          height: 48,
                          margin: EdgeInsets.all(16),
                          child: DropdownButtonFormField<String>(
                            style: tab_style,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: Colors.grey[200],
                            ),
                            value: selectedItem_source,
                            items: source
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: tab_style,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    alignment: AlignmentDirectional.centerEnd,
                                  ),
                                )
                                .toList(),
              
                            onChanged: (item) => setState(() {
                              selectedItem_source = item!;
              
                              String? res = Translations.language_map[item];
                              language1 = res!;
                              print(language1);
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  SizedBox(height: 10),
                  Container(
                    height: 140,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        textDirection: TextDirection.rtl,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelStyle: tab_style,
                          hintText: "متن خود را وارد نمایید",
                          hintStyle: tab_style,
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _controller.text = "";
                                },
                                child: Icon(Icons.clear, color: Colors.red),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  String text = _controller.text;
                                  String lan = 'en-US';
                                  tts.setLanguage(lan);
                                  tts.speak(text);
                                },
                                child: Icon(Icons.volume_up, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
              
                        controller: _controller,
              
                        onChanged: (text) {
                          //code to write
                        },
                      ),
                    ),
                  ),
                    SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      translate_func();
                    },
                    height: 60,
                    minWidth: 300,
                    color: Colors.blue,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("ترجمه کن", style: button_style),
                  ),
              
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        width: MediaQuery.of(context).size.width - 75,
                        height: 150,
              
                        child: Center(
                          child: Text(result_value, style: tab_style),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          endRadius: 40,
          glowColor: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 2000),
          repeatPauseDuration: Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_off_outlined),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize();

      if (available) {
        setState(() => _isListening = true);

        _speech?.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            _controller.text = _text;
          }),
        );
      } else {
        setState(() => _isListening = false);
        await _speech?.stop();
      }
    }else{
      setState(() => _isListening = false);
      await _speech?.stop();
    }
  }

  void translate_func() async {
    final fromLanguageCode = Translations.getlangugageCode(language1);
    final toLanguageCode = Translations.getlangugageCode(language2);

    String message = _controller.text;

    final result = await TranslationApi.translate(
      message,
      fromLanguageCode,
      toLanguageCode,
    );

    setState(() {
      result_value = result;
    });
  }
}
