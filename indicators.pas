unit indicators;

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

procedure rubyindicator(active: string; x,y,r:word) ;

implementation

procedure rubyindicator(active: string; x,y,r:word );

  begin

   VGShapesStrokeWidth(r / 7);
   VGShapesStroke(181,166,66,1);

   if  active = 'A' then
       VGShapesFill(255,0,0,1)
   else
       VGShapesFill(60,60,60,1);

   VGShapesCircle(x,y,r);

   end;

end.

