import 'package:flutter/material.dart';
import 'package:innosoft_simpletooltip/innosoft_simpletooltip.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TooltipExampleStateful(),
    );
  }
}

class TooltipExampleStateful extends StatefulWidget {
  TooltipExampleStateful({Key key}) : super(key: key);

  @override
  _TooltipExampleStateful createState() => _TooltipExampleStateful();
}

class _TooltipExampleStateful extends State<TooltipExampleStateful> {

  double marginTop = 20;
  SoftSimpleTooltip tooltipUp, tooltipDown;
  bool clsTooltipUp = false;
  bool clsTooltipDown = false;

  @override
  void initState() {
    super.initState();
    tooltipUp = SoftSimpleTooltip(
        content: Container(
          //height: 100.0,
            child:Text("Lorem ipsum dolor sit amet, consetetur sadipscingelitr, "
                "sed diam nonumy eirmod tempor invidunt ut laboreet dolore magna aliquyam erat, "
                "sed diam voluptua. At vero eos et accusam et justoduo dolores et ea rebum. ")
        ),
        popupDirection: TooltipDirection.up,
        backgroundColor: Colors.black,
        radius: 20,
        arrowHeight: 40,
        arrowWidth: 50,
        arrowPos: 200,
        tooltipStyle: TooltipStyle.border);
    tooltipDown = SoftSimpleTooltip(
        content: Container(
          //height: 100.0,
            child:Text("Lorem ipsum dolor sit amet, consetetur sadipscingelitr, "
                "sed diam nonumy eirmod tempor invidunt ut laboreet dolore magna aliquyam erat, "
                "sed diam voluptua. At vero eos et accusam et justoduo dolores et ea rebum. ")
        ),
        popupDirection: TooltipDirection.down,
        backgroundColor: Colors.black,
        radius: 20,
        arrowHeight: 40,
        arrowWidth: 50,
        arrowPos: 200,
        tooltipStyle: TooltipStyle.border);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showHideTooltipUp(){
    clsTooltipUp ? tooltipUp.showTooltip() : tooltipUp.closeTooltip();
    setState(() {
      clsTooltipUp = !clsTooltipUp;
    });
  }

  void showHideTooltipDown(){
    clsTooltipDown ? tooltipDown.showTooltip() : tooltipDown.closeTooltip();
    setState(() {
      clsTooltipDown = !clsTooltipDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'TOOLTIP',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body:
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Row 1
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: new Container(
                            margin: new EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: tooltipUp,
                                ),
                              ],
                            ))
                    ),
                  ]
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: new Container(
                            margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: RaisedButton(
                              onPressed: () {
                                //Navigator.pop(globalContext);
                                showHideTooltipUp();
                              },
                              child: Text('Show Hide Tooltip Up'),
                            ))
                    ),
                  ]
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: new Container(
                            margin: new EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: RaisedButton(
                              onPressed: () {
                                //Navigator.pop(globalContext);
                                showHideTooltipDown();
                              },
                              child: Text('Show Hide Tooltip Down'),
                            ))
                    ),
                  ]
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: new Container(
                            margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: tooltipDown,
                                ),
                              ],
                            ))
                    ),
                  ]
              ),
            ]
        )
    );
  }
}