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
  DateUtils,
  Dos,
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
  //gpsdatetime,
  //gpslogging,
  Serial;

 var
  WindowHandle:TWindowHandle;
  Width: Integer;
  Height: Integer;

  datastr:string;
  Character:Char;
  //Characters:String;
  Count:LongWord;

    GPSmess: string;
    GPSlat: string;
    GPSlong: string;
    GPSknots: string;
    GPSheading: string;
    GPSstatus: string;
    GPSNS: string;
    GPSEW: string;

    GPSdata: string;
    GPSslots: TStringArray;

    GPStime: string;
    GPSdate: string;

    gpsDays:word;
    gpsMonths:word;
    gpsYears:word;
    gpsHours:word;
    gpsMinutes:word;
    gpsSeconds:word;

    timeint: Integer;
    timereal: Real;
    code: Integer;

    dateint:Integer;


  procedure getgpsdata();
    begin
    datastr:='';
    Count := 0;

    While True do
        begin
             SerialRead(@Character,SizeOf(Character),Count);
             if Character = #13 then
                begin
                 {If we received a carriage return then write our characters to the console}
                 //ConsoleWindowWriteLn(WindowHandle, datastr);

                 break;
                end
             else
                 datastr:=datastr + Character;
         end;

    GPSslots := datastr.Split(',');

    GPSmess := GPSslots[0];
    GPStime := GPSslots[1];
    GPSstatus := GPSslots[2];
    GPSlat := GPSslots[3];
    GPSNS := GPSslots[4];
    GPSlong := GPSslots[5];
    GPSEW := GPSslots[6];
    GPSknots := GPSslots[7];
    GPSheading := GPSslots[8];
    GPSdate := GPSslots[9];

    if GPStime <> '' then
         begin
            val(GPSdate, dateint, code );

            gpsDays := dateint div 10000;
            gpsMonths := dateint mod 10000 div 100;
            gpsYears := dateint mod 100;

            val(GPStime, timereal, code );
            timeint :=  trunc(timereal);

            gpsHours := timeint div 10000;
            gpsMinutes := timeint mod 10000 div 100;
            gpsSeconds := timeint mod 100;

            SetTime(gpsHours,gpsMinutes,gpsSeconds,0);
            SetDate(2000 + gpsYears, gpsMonths, gpsDays);

         end;

    //testing output;
    //ConsoleWindowWriteLn(WindowHandle,'gpsHours ' + IntToStr(gpsHours));
    //ConsoleWindowWriteLn(WindowHandle,'gpsMinutes ' + IntToStr(gpsMinutes));
    //ConsoleWindowWriteLn(WindowHandle,'gpsSeconds ' + IntToStr(gpsSeconds));
    //ConsoleWindowWriteLn(WindowHandle,'GPSknots ' + GPSknots);

    //ConsoleWindowWriteLn(WindowHandle,'gpsSeconds ' + IntToStr(gpsdatetime.gpsSeconds));

  end;


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

  if SerialOpen(9600,SERIAL_DATA_8BIT,SERIAL_STOP_1BIT,SERIAL_PARITY_NONE,SERIAL_FLOW_NONE,0,0) = ERROR_SUCCESS then
  begin

   {Opened successfully, display a message}
   ConsoleWindowWriteLn(WindowHandle,'GPS module attached');
  end;

  //datastr := '$GPRMC,085705.00,A,2738.12630,S,15252.41706,E,29.816,189.11,250321,,,D*47 ';
  //ConsoleWindowWriteLn(WindowHandle,'Gps data ' + datastr);

  // used for testing
  //While True do
  //      begin
  //      getgpsdata();
  //      ConsoleWindowWriteLn(WindowHandle,'Gpsdata ' + datastr);

  //      Sleep(600);
  //      end;

  // OpenVG dials
  While True do
        begin
        getgpsdata();
        //gpsconv(datastr);

        romanclock(120,280,200);
        steamspeedo(GPSknots, 360,280,200);
        cardcompass(GPSheading,600,280,200);
        coordinates(GPSlat,GPSlong,20,30,270,100 );
        numcalender(430,30,270,100);
        rubyIndicator(GPSstatus, 360, 80,70);

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

