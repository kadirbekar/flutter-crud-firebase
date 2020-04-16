import 'package:flutter/material.dart';

/*Bu sınıfın amacı, sayfalarda kullanılan text widgetlerini tek bir classtan türetme ve istenilen özellikleri
dinamik olarak tanımlayabilmedir*/
class LabelCard extends StatefulWidget {
  final Color color;
  final MediaQuery mediaQuery;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final TextStyle textStyle;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final int satirSayisi;
  final TextAlign textAlign;
  final String fontFamily;

  /*Süslü parantez olarak girilen değerler bu widget çağrıldığında isteğe bağlı olarak girilen değerlerdir.*/
  LabelCard(
      {Key key,
      this.fontSize,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.satirSayisi,
      this.label,
      this.mediaQuery,
      this.textStyle,
      this.alignment,
      this.padding,
      this.fontFamily})
      : super(key: key);

  @override
  _LabelCardState createState() => _LabelCardState();
}

class _LabelCardState extends State<LabelCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      alignment: widget.alignment,
      child: Text(
        widget.label,
        overflow: TextOverflow.ellipsis,
        maxLines: widget.satirSayisi,
        textAlign: widget.textAlign,
        style: TextStyle(
          fontFamily: widget.fontFamily,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.color,
        ),
      ),
    );
  }
}
