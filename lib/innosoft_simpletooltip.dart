library innosoft_simpletooltip;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TooltipDirection { up, down}

enum TooltipStyle { fill, border}

var globalContext;

double oriLayoutHeight, layoutHeight;

bool _isVisible, ftVisible;

class SoftSimpleTooltip extends StatefulWidget {
  Widget content;

  TooltipDirection popupDirection;

  TooltipStyle tooltipStyle;

  Color backgroundColor;

  bool hasShadow;

  double radius,
  //arrowDirection,
      arrowHeight,
      arrowWidth;
  //tt_gravity,;
  double arrowPos,
      heightWall;

  _SoftSimpleTooltip stp = new _SoftSimpleTooltip();

  SoftSimpleTooltip(
      {
        Key key,
        @required this.content, // The contents of the tooltip.
        @required this.popupDirection,
        @required this.backgroundColor,
        @required this.radius,
        @required this.arrowHeight,
        @required this.arrowWidth,
        @required this.arrowPos,
        //@required this.tt_gravity,
        @required this.tooltipStyle,
        this.hasShadow
      }) : super(key: key);

  @override
  _SoftSimpleTooltip createState() => stp;

  void closeTooltip(){
    stp.closeTooltip();
  }

  void showTooltip(){
    stp.showTooltip();
  }
}

class _SoftSimpleTooltip extends State<SoftSimpleTooltip> {
  final String tag = "SoftSimpleTooltip";

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    ftVisible = true;
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void didUpdateWidget(Widget oldWidget)
  {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  void printWrapped(String tag, String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(tag+' -> '+text).forEach((match) => print(match.group(0)));
  }

  void showTooltip(){
    setState(() {
      _isVisible = true;
      layoutHeight = oriLayoutHeight;
    });
  }

  void closeTooltip(){
    setState(() {
      layoutHeight = 0;
    });
    new Future.delayed(new Duration(milliseconds: 180), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  _SoftSimpleTooltip();

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    // TODO: implement build
    return new Container(
      child:
      new Container(
        margin: new EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Visibility (
                visible: _isVisible,
                child:AnimatedContainer(
                  height: layoutHeight,
                  child: CustomPaint(
                    child: Container(
                        margin: _getContainerMargin(),
                        child:widget.content
                    ),
                    painter: PathPainter(
                        widget.popupDirection,
                        widget.backgroundColor,
                        widget.radius,
                        widget.arrowHeight,
                        widget.arrowWidth,
                        widget.arrowPos,
                        widget.tooltipStyle),
                  ),
                  duration: Duration(milliseconds: 200),
                  // Provide an optional curve to make the animation feel smoother.
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getContainerMargin() {
    switch (widget.popupDirection) {
    //
      case TooltipDirection.down:
        double top = widget.arrowHeight+widget.radius;
        return EdgeInsets.fromLTRB(widget.radius, top, widget.radius, widget.radius);

      case TooltipDirection.up:
        double bottom = widget.arrowHeight+widget.radius;
        return EdgeInsets.fromLTRB(widget.radius, widget.radius, widget.radius, bottom);

      default:
        throw AssertionError(widget.popupDirection);
    }
  }
}

class PathPainter extends CustomPainter {

  double radius, arrowHeight, arrowWidth;
  double arrowPos;
  Color backgroundColor;
  TooltipDirection popupDirection;
  TooltipStyle tooltipStyle;

  PathPainter(
      TooltipDirection popupDirection,
      Color backgroundColor,
      double radius,
      double arrowHeight,
      double arrowWidth,
      double arrowPos,
      TooltipStyle tooltipStyle)
  {
    this.popupDirection = popupDirection;
    this.backgroundColor = backgroundColor;
    this.radius = radius;
    this.arrowHeight = arrowHeight;
    this.arrowWidth = arrowWidth;
    this.arrowPos = arrowPos;
    this.tooltipStyle = tooltipStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {

    double w = size.width;
    double h = size.height;
    if(ftVisible) {
      oriLayoutHeight = h;
      ftVisible = false;
    }
    layoutHeight = h;

    Paint paint = Paint();
    paint.color = backgroundColor;

    Path path = Path();

    if(tooltipStyle == TooltipStyle.fill) {
      paint.style = PaintingStyle.fill;
    }
    else{
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 4.0;
    }

    if(arrowHeight > (h/2))arrowHeight = h/2;
    if(arrowWidth > (w/2))arrowWidth = w/2;
    double ch = h/8;
    if(radius > ch)radius = ch;
    double p = arrowHeight;
    double p2 = arrowWidth/2;
    if(arrowPos > 0){
      if(arrowPos < radius)arrowPos = radius;
      else if(arrowPos > (w-(radius*4)))arrowPos = w-(radius*4);
    }
    double c = arrowPos <= 0 ? (w/2)-(p2) : arrowPos;
    c = c.abs();
    if(c < radius)c=radius;
    else {
      double limitRight = w - (radius * 2);
      if (c > limitRight) c = limitRight;
    }

    double c2 = c+p2;
    double c3 = c+(p2*2);
    double y = h-(h-p);

    if(popupDirection == TooltipDirection.down) {
      path.moveTo(0, y + radius);
      path.quadraticBezierTo(0, y, radius, y);
      path.lineTo(c, y);
      path.lineTo(c2, 0);
      path.lineTo(c3, y);

      path.lineTo(w - radius, y);
      path.quadraticBezierTo(w, y, w, y + radius);

      path.lineTo(w, h - radius);
      path.quadraticBezierTo(w, h, w - radius, h);

      path.lineTo(radius, h);
      path.quadraticBezierTo(0, h, 0, h - radius);

      path.lineTo(0, y + radius);
      canvas.drawPath(path, paint);
    }
    else {
      double posFromBottom = h-arrowHeight;
      path.moveTo(0, radius);
      path.quadraticBezierTo(0, 0, radius, 0);

      path.lineTo(w - radius, 0);
      path.quadraticBezierTo(w, 0, w, radius);

      path.lineTo(w, posFromBottom - radius);
      path.quadraticBezierTo(w, posFromBottom, w - radius, posFromBottom);

      path.lineTo(c3, posFromBottom);
      path.lineTo(c2, h);
      path.lineTo(c, posFromBottom);

      path.lineTo(radius, posFromBottom);
      path.quadraticBezierTo(0, posFromBottom, 0, posFromBottom-radius);

      path.lineTo(0, radius);
      canvas.drawPath(path, paint);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
