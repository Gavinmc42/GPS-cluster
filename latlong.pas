unit latlong;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4;


var

Width:Integer;  {A few variables used by our shapes example}
Height:Integer;
code:Integer;

procedure coordinates(latitude, longitude: string; x,y,w,h:word) ;

implementation

procedure coordinates(latitude, longitude: string; x,y,w,h:word) ;
    var

    Fontsize:Integer;

    begin

      //latitude , longitude

      Fontsize:=Trunc(w * 0.1);

      VGShapesStrokeWidth(h * 0.1);
      VGShapesStroke(181,166,66,1);
      VGShapesFill(20,20,40,1);
      VGShapesRoundrect(x,y,w,h, 10,10);

      VGShapesFill(255,255,255,1);
      VGShapesText(x + w * 0.05,y + h * 0.55,latitude,VGShapesSansTypeface,Fontsize);
      VGShapesText(x + w * 0.05,y + h * 0.15,longitude,VGShapesSansTypeface,Fontsize);

    end;


 end.












