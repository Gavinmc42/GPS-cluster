unit speedo;

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


procedure steamspeedo(gpsknots:string; x,y,r:LongWord) ;

implementation



procedure steamspeedo(gpsknots:string; x,y,r:LongWord );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Needle:VGfloat;

       knots:Real;
       Speed:VGfloat;
       code:Integer;

       Fontsize:Integer;

       KPH: string;

     begin

       val(gpsknots,knots, code);
       //convert to KPH
       Speed := 100 * knots / 54;

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.88;

       PosNum:= r / 2 * 0.70;
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

       Fontsize:=Trunc(Dial * 0.1);
       VGShapesFill(0,0,0,1);

       VGShapesTextMid(0,-Dial * 0.25,'KPH',VGShapesSerifTypeface,Fontsize);

       Fontsize:=Trunc(Dial * 0.07);
       VGShapesRotate(-210);
       for Ticks := 0 to 100 do
           Begin

                if Ticks mod 10 = 0 then
                Begin
                  KPH := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.01);
                  VGShapesTextMid(0,PosNum,KPH,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.002);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-3);
          end;
       // set to O speed
       VGShapesRotate(-57);

       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dial * 0.08);

       VGShapesRotate(Speed * -3);
       VGShapesStrokeWidth(Dial * 0.025);
       VGShapesLine(0,0, 0,Needle);
       VGShapesRotate(Speed * 3);

        //return to zero rotation
       VGShapesRotate(210);

       //reset back to zero position
       VGShapesTranslate(-x,-y);


  end;

end.

