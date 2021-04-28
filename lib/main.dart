import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

//  MediaQuery.of(context).size.width,
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var txt1 = TextEditingController();
  var txt2 = TextEditingController();
  var count = 10;
  var signe;
  final List<String> buttons = [
    'C',
    '%',
    '/',
    'DEL',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '+/-',
    '.',
    '0',
    '=',
  ];
  void text1(val) {
    txt1.text += buttons[val];
  }

  void text2(val) {
    txt2.text += buttons[val];
  }

  // void calcul() {
  //   value2 = double.parse(txt2.text);
  //   switch (signe) {
  //     case "+":
  //       txt2.text = (value1 + value2).toString();
  //       break;
  //     case "x":
  //       txt2.text = (value1 * value2).toString();
  //       break;
  //     case "/":
  //       if (double.parse(txt2.text) == 0) {
  //         showDialog(
  //             context: context,
  //             builder: (_) => new AlertDialog(
  //                   title: new Text("Eror"),
  //                   content: new Text("Can't devide by zero"),
  //                   actions: <Widget>[
  //                     FlatButton(
  //                       color: Color(0xFFe84545),
  //                       child: Text('Got it'),
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                         txt2.text = '';
  //                         txt1.text = '';
  //                         value1 = 0;
  //                       },
  //                     )
  //                   ],
  //                 ));
  //       } else {
  //         txt2.text = (value1 / value2).toString();
  //       }
  //       break;
  //     case "-":
  //       txt2.text = (value1 - value2).toString();
  //       break;
  //     case "%":
  //       txt2.text = (value1 % value2).toString();
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Calculator',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 10.00,
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 15.0, right: 10),
          child: TextField(
            enabled: false,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 30, fontFamily: "Calculator"),
            decoration: InputDecoration(border: InputBorder.none),
            controller: txt1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 50,
            right: 10,
          ),
          child: TextField(
            textAlign: TextAlign.right,
            showCursor: true,
            cursorColor: Color(0xFF84142d),
            style: TextStyle(fontSize: 60, fontFamily: "Calculator"),
            decoration: InputDecoration(border: InputBorder.none),
            controller: txt2,
            readOnly: true,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return RaisedButton(
                        color: Color(0xFFc02739),
                        child: Text(
                          buttons[index],
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () => {
                              txt2.text = '',
                              txt1.text = '',
                            });
                  }
                  if (index == 3) {
                    return Container(
                        child: RaisedButton(
                            child: Text(
                              "DEL",
                              style: TextStyle(fontSize: 20),
                            ),
                            color: Color(0xFFc02739),
                            onPressed: () {
                              if (txt2.text == '') {
                                txt1.text = txt1.text
                                    .substring(0, txt1.text.length - 1);
                              } else {
                                txt2.text = txt2.text
                                    .substring(0, txt2.text.length - 1);
                              }
                            }));
                  }
                  if (index == 1 ||
                      index == 2 ||
                      index == 7 ||
                      index == 11 ||
                      index == 15) {
                    return Container(
                      child: RaisedButton(
                          color: Color(0xFFc02739),
                          child: Text(
                            buttons[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                                text1(index),
                                txt2.text = '',
                              }),
                    );
                  }
                  if (index == 19) {
                    return Container(
                      child: FlatButton(
                          color: Color(0xFFc02739),
                          child: Text(
                            buttons[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if (txt1.text.contains('/0')) {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("Eror"),
                                        content:
                                            new Text("Can't devide by zero"),
                                        actions: <Widget>[
                                          FlatButton(
                                            color: Color(0xFFe84545),
                                            child: Text('Got it'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              txt2.text = '';
                                              txt1.text = '';
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              var finaInput = txt1.text.replaceAll('x', '*');
                              Parser p = Parser();
                              Expression exp = p.parse(finaInput);
                              ContextModel cm = ContextModel();
                              double eval =
                                  exp.evaluate(EvaluationType.REAL, cm);
                              txt2.text = eval.toString();
                            }
                          }),
                    );
                  } else {
                    return RaisedButton(
                        color: Colors.black,
                        child: Text(
                          buttons[index],
                          style: TextStyle(fontSize: 20),
                        ),
                        splashColor: Colors.green,
                        onPressed: () => {text2(index), text1(index)});
                  }
                }),
          ),
        ),
      ]),
    );
  }
}
