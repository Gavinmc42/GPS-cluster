unit calender;

{$mode objfpc}{$H+}

interface

uses
    Classes,
    SysUtils,
    VGShapes,     {Include the VGShapes unit to give us access to all the functions}
    VC4;


var

Width:Integer;  {A few variables used by our shapes example}
Height:Integer;

procedure numcalender(x,y,w,h:word) ;

implementation

procedure numcalender(x,y,w,h:word );
  var

    Fontsize:Integer;
    Datestr: string;
    Datearray:  TStringArray;

  begin

    Datestr := DateToStr(Now);

    Datearray := Datestr.Split('-');

    VGShapesStrokeWidth(h * 0.1);
    VGShapesStroke(181,166,66,1);
    VGShapesFill(20,20,40,1);
    VGShapesRoundrect(x,y,w,h,10,10);

    Fontsize:=Trunc(w * 0.16);
    VGShapesFill(255,255,255,1);
    VGShapesText(x + w * 0.05,y + h * 0.3,Datestr,VGShapesSansTypeface,Fontsize);


  end;


end.

