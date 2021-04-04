program gpscluster;

{$mode objfpc}{$H+}

{ Raspberry Pi Application                                                     }
{  Add your program code below, add additional units to the "uses" section if  }
{  required and create new units by selecting File, New Unit from the menu.    }
{                                                                              }
{  To compile your program select Run, Compile (or Run, Build) from the menu.  }

uses
  RaspberryPi,
  GlobalConfig,
  GlobalConst,
  GlobalTypes,
  Platform,
  console,
  Threads,
  SysUtils,
  Classes,
  dos,
  Ultibo,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4,
  compass,
  clocks,
  speedo,
  latlong,
  calender,
  indicators,
  gpsdatetime
   { Add additional units here };

 var
  WindowHandle:TWindowHandle;
  Width: Integer;
  Height: Integer;


 begin
  WindowHandle:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_FULL,True);

  ConsoleWindowWriteLn(WindowHandle,'Hello Ultibo!');

  VGShapesInit(Width, Height);
  VGShapesBackground(102,51,0);
  vgSeti(VG_STROKE_CAP_STYLE,VG_CAP_ROUND);

  Sleep(1000);

  ConsoleWindowWriteLn(WindowHandle, DateTimeToStr(Now));
  {Let's print the timezone to see what it is set to}
  ConsoleWindowWriteLn(WindowHandle,'Timezone is ' + GetCurrentTimezone);

  {Now we can set the timezone to another place and see what the time is there}
  {Australia}
  ConsoleWindowWriteLn(WindowHandle,'Setting Timezone to "E. Australia Standard Time"');
  SetCurrentTimezone('E. Australia Standard Time');
  ConsoleWindowWriteLn(WindowHandle,'The date and time is now ' + FormatDateTime(DefaultFormatSettings.LongDateFormat + ' ' + DefaultFormatSettings.LongTimeFormat,Now));
  ConsoleWindowWriteLn(WindowHandle,'');

  //set initial time date
  settimegps();


  While True do
        begin

        romanclock(120,280,200);
        steamspeedo(gpsdatetime.GPSknots, 360,280,200);
        cardcompass(gpsdatetime.GPSheading,600,280,200);
        coordinates(gpsdatetime.GPSlat,gpsdatetime.GPSlong,20,30,270,100 );
        numcalender(430,30,270,100);
        rubyIndicator(gpsdatetime.GPSstatus, 360, 80,70);

        VGShapesEnd;
        //Inc(Seconds);
        Sleep(600);

        end;
    {Sleep for 10 seconds}
  Sleep(100000);

   {Clear our screen, cleanup OpenVG and deinitialize VGShapes}
  VGShapesFinish;

  {VGShapes calls BCMHostInit during initialization, we should also call BCMHostDeinit to cleanup}
  BCMHostDeinit;

  ConsoleWindowWriteLn(WindowHandle, DateTimeToStr(Now));

  ThreadHalt(0);
 end.

