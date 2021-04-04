unit compass;

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


procedure magcompass(gpsheading: string; x,y,r:word) ;

procedure cardcompass(gpsheading: string; x,y,r:word) ;


implementation

procedure cardcompass(gpsheading: string; x,y,r:word );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;

       Degree: string;
       Degreereal:Real;
       Degreeint:Integer;

       Fontsize:Integer;
       code:Integer;

     begin

       val(gpsheading,Degreereal, code);
       Degreeint :=  trunc(Degreereal);

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.90;
       PosT2:= r / 2 * 0.82;
       PosDeg:= r / 2 * 0.70;
       PosNum:= r / 2 * 0.50;
       Dial:= r * 1.0;

       VGShapesStrokeWidth(Dial / 30);
       VGShapesStroke(181,166,66,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0, Dial);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT1);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT2);

       // triangle pointer
       VGShapesStrokeWidth(Dial * 0.006);
       VGShapesLine(0,r / 2 * 0.86, Dial * 0.02, r / 2 * 0.97);
       VGShapesLine(0,r / 2 * 0.86, Dial * -0.02, r / 2 * 0.97);

       //rotate whole card  reversed from mag compass as the card moves not the needle
       VGShapesRotate(Degreeint * 1);

       VGShapesStrokeWidth(Dial * 0.004);

       //Fontsize:= 12;
       VGShapesFill(0,0,0,1);
       //VGShapesTextMid(0,Dial * 0.6,IntToStr(Degrees),VGShapesSerifTypeface,Fontsize);

       Fontsize:=Trunc(Dial * 0.085);

       VGShapesFill(0,0,0,1);
       VGShapesTextMid(0,PosNum,'N',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'E',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'S',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'W',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);

       Fontsize:=Trunc(Dial * 0.045);

       for Ticks := 0 to 360 do
           Begin

                if Ticks mod 10 = 0 then
                 Begin
                  Degree := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.005);
                 end

                else
                   VGShapesStrokeWidth(Dial * 0.001);

                if Ticks mod 20 = 0 then
                 Begin
                   VGShapesTextMid(0,PosDeg,Degree,VGShapesSansTypeface,Fontsize);
                 end;


                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-1);
          end;

       //hub pivot
       VGShapesStroke(181,166,66,1);
       VGShapesFill(181,166,66,1);
       VGShapesCircle(0,0, r * 0.1);


       //back to zero tick rotation
       VGShapesRotate(1);

       //rotate  back to zero card rotation
       VGShapesRotate(Degreeint * -1);

       //reset back ot zero position
       VGShapesTranslate(-x,-y);


  end;



procedure magcompass(gpsheading: string; x,y,r:word );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Needle:VGfloat;

       Degree: string;
       Degreereal:Real;
       Degreeint:Integer;

       PolyX:array[0..3] of VGfloat;
       PolyY:array[0..3] of VGfloat;

       Fontsize:Integer;
       code:Integer;

     begin

       val(gpsheading,Degreereal, code);
       Degreeint :=  trunc(Degreereal);

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.90;
       PosDeg:= r / 2 * 0.83;
       PosNum:= r / 2 * 0.65;
       Needle:= r / 2 * 0.92;
       Dial:= r * 1.0;

       VGShapesStrokeWidth(Dial / 30);
       VGShapesStroke(181,166,66,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0, Dial);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT1);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT2);

       Fontsize:= 12;
       VGShapesFill(0,0,0,1);
       //VGShapesTextMid(0,Dial * 0.6,IntToStr(Degrees),VGShapesSerifTypeface,Fontsize);

       Fontsize:=Trunc(Dial * 0.08);

       VGShapesFill(0,0,0,1);
       VGShapesTextMid(0,PosNum,'N',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'E',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'S',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'W',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);

       Fontsize:=Trunc(Dial * 0.025);

       for Ticks := 0 to 360 do
           Begin

                if Ticks mod 10 = 0 then
                Begin
                  Degree := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.005);
                  VGShapesTextMid(0,PosDeg,Degree,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.001);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-1);
          end;

       //back to zero rotation
       VGShapesRotate(1);


       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(40,40,40,1);

       VGShapesFill(200,0,0,1);

       PolyX[0]:=Dial * 0.06;
       PolyX[1]:=0;
       PolyX[2]:=-Dial * 0.06;

       PolyY[0]:=0;
       PolyY[1]:=Needle;
       PolyY[2]:=0;

       VGShapesRotate(Degreeint * -1);
       VGShapesLine(Dial * 0.06,0, 0, Needle);
       VGShapesLine(-Dial * 0.06,0, 0, Needle);
       VGShapesPolygon(@PolyX,@PolyY,3);
       VGShapesRotate(Degreeint * 1);

       VGShapesFill(255,255,255,1);

       PolyX[0]:=Dial * 0.06;
       PolyX[1]:=0;
       PolyX[2]:=-Dial * 0.06;

       PolyY[0]:=0;
       PolyY[1]:=-Needle;
       PolyY[2]:=0;

       VGShapesRotate(Degreeint * -1);
       VGShapesLine(Dial * 0.06,0, 0, -Needle);
       VGShapesLine(-Dial * 0.06,0, 0, -Needle);
       VGShapesPolygon(@PolyX,@PolyY,3);
       VGShapesRotate(Degreeint * 1);

       VGShapesStroke(90,83,33,1);
       VGShapesFill(181,166,66,1);
       VGShapesCircle(0,0,Dial * 0.08);

       //reset back ot zero position
       VGShapesTranslate(-x,-y);


  end;

end.

