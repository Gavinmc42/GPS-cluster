unit gpsdatetime;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  dos,
  SysUtils;

var
    GPSlat: string;
    GPSlong: string;
    GPSknots: string;
    GPSheading: string;
    GPSstatus: string;
    GPSNS: string;
    GPSEW: string;


procedure settimegps();


implementation

 procedure settimegps();

 var
  GPSdata: string;
  GPSslots: TStringArray;

  GPStime: string;
  GPSdate: string;


  Days:word;
  Months:word;
  Years:word;
  Hours:word;
  Minutes:word;
  Seconds:word;

  timeint: Integer;
  timereal: Real;
  code: Integer;

  dateint:Integer;


    begin

      GPSdata := ' $GPRMC,085705.00,A,2738.12630,S,15252.41706,E,29.816,189.11,250321,,,D*47 ';

      GPSslots := GPSdata.Split(',');

      if (GPSslots[0] = ' $GPRMC') then
         begin
              GPStime := GPSslots[1];
              GPSstatus := GPSslots[2];
              GPSlat := GPSslots[3];
              GPSNS := GPSslots[4];
              GPSlong := GPSslots[5];
              GPSEW := GPSslots[6];
              GPSknots := GPSslots[7];
              GPSheading := GPSslots[8];
              GPSdate := GPSslots[9];
         end
         else
              GPSstatus := 'V';

      val(GPSdate, dateint, code );

      Days := dateint div 10000;
      Months := dateint mod 10000 div 100;
      Years := dateint mod 100;

      val(GPStime, timereal, code );
      timeint :=  trunc(timereal);

      Hours := timeint div 10000;
      Minutes := timeint mod 10000 div 100;
      Seconds := timeint mod 100;

      SetTime(Hours,Minutes,Seconds,0);
      SetDate(2000 + Years, Months, Days);
    end;

end.

