import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyBody extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _form1 = GlobalKey<FormState>();

  var text1 = "";

  Widget build(BuildContext context) {
    return Form(
        key: _form1,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
                children: <Widget>[
                  new TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter url',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        text1 = value;
                        return null;
                      }),
                  SizedBox(
                      width: double.infinity,
                      child: FlatButton(onPressed: () async {
                          if(_form1.currentState.validate()) {
                            var response = await http.get(text1);

                            if (response.statusCode == 200) {
                               _controller.text = response.body;
                            } else {
                                _controller.text = 'Error statusCode: ${response.statusCode}';
                            }
                          }
                      }, child: Text('parse site'), color: Colors.green, textColor: Colors.white)
                  ),
                  Container(
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      )
                  )
                ]
            )
        )
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(
        new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Scaffold(
                appBar: new AppBar(title: new Text('My Firts App')),
                body: new MyBody()
            )
        )
    );
  });
}


