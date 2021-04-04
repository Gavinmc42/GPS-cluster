unit clocks;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  dos,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4;


var

Width:Integer;  {A few variables used by our shapes example}
Height:Integer;

procedure romanclock(x,y,r:word) ;

implementation

procedure romanclock(x,y,r:word );
    var
       Ticks:Integer;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Dialsec:VGfloat;

       Fontsize:Integer;

       Timearray:  TStringArray;
       Timestr: string;

       rhours:Word;
       rmins:Word;
       rsecs:Word;

     begin

       Timestr := TimeToStr(Now);

       Timearray := Timestr.Split(':');

       rhours := StrToInt(Timearray[0]);
       rmins := StrToInt(Timearray[1]);
       rsecs := StrToInt(Timearray[2]);

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.90;
       PosNum:= r / 2 * 0.72;
       Dial:= r * 1.0;
       Dialsec:= r * 0.3;

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

       Fontsize:= 18;
       VGShapesFill(0,0,0,1);
       //VGShapesTextMid(300,320,timestr,VGShapesSerifTypeface,Fontsize);
       // VGShapesTextMid(300,300,IntToStr(timeint),VGShapesSerifTypeface,Fontsize);
       //VGShapesTextMid(300,280,IntToStr(Hours),VGShapesSerifTypeface,Fontsize);
       //VGShapesTextMid(300,260,IntToStr(Minutes),VGShapesSerifTypeface,Fontsize);
       //VGShapesTextMid(300,240,IntToStr(Seconds),VGShapesSerifTypeface,Fontsize);

       Fontsize:=Trunc(Dial * 0.08);

       VGShapesFill(0,0,0,1);
       VGShapesTextMid(0,PosNum,'XII',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'I',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'II',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'III',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'IIII',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'V',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'VI',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'VII',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum,'VII',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum, 'IX',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum, 'X',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);
       VGShapesTextMid(0,PosNum, 'XI',VGShapesSerifTypeface,Fontsize);

       VGShapesRotate(-30);

       //Minute ticks
       for Ticks := 0 to 59 do
           Begin
                if Ticks mod 5 = 0 then
                   VGShapesStrokeWidth(Dial * 0.025)
                else
                   VGShapesStrokeWidth(Dial * 0.005);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-6);
           end;


       // seconds dial
       VGShapesTranslate(0,-Dialsec * 0.8);
       VGShapesStrokeWidth(Dialsec * 0.02);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,Dialsec);

       for Ticks := 0 to 59 do
           Begin
                if Ticks mod 5 = 0 then
                   VGShapesStrokeWidth(Dialsec * 0.03)
                else
                    VGShapesStrokeWidth(Dialsec * 0.01);

                VGShapesLine(0,Dialsec / 2 * 0.9, 0,Dialsec / 2);
                VGShapesRotate(-6);
           end;

       // draw the seconds hand
       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dialsec * 0.08);

       VGShapesRotate(rsecs * -6);
       VGShapesStrokeWidth(Dialsec * 0.02);
       VGShapesLine(0,0, 0,Dialsec / 2 * 0.9);
       VGShapesRotate(rsecs * 6);

       //return to center
       VGShapesTranslate(0,Dialsec * 0.8);

       //draw hour minute hands over second dial
       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dial * 0.08);

       VGShapesRotate(rhours * -30 + rmins * -0.5);
       VGShapesStrokeWidth(Dial * 0.025);
       VGShapesLine(0,0, 0,PosNum);
       VGShapesRotate(rhours * 30 + rmins * 0.5);

       VGShapesRotate(rmins * -6);
       VGShapesStrokeWidth(Dial * 0.01);
       VGShapesLine(0,0, 0,PosT2);
       VGShapesRotate(rmins * 6);

       //reset back ot zero position
       VGShapesTranslate(-x,-y);


  end;

end.

