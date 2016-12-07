unit Mathbits;

interface

uses Math;

procedure Point_OTC(hR: Extended; hAngl: Integer; var hMasX, hMasY: array of Extended); //Point On The Circle

implementation

procedure Point_OTC(hR: Extended; hAngl: Integer; var hMasX, hMasY: array of Extended); //Point On The Circle
var angl: Extended;
begin
  case hAngl of
    0: angl := 0;
    30: angl := pi / 6;
    45: angl := pi / 4;
    60: angl := pi / 3;
    90: angl := pi / 2;
    120: angl := (2 * pi) / 3;
    135: angl := (3 * pi) / 4;
    150: angl := (5 * pi) / 6;
    180: angl := pi;
    210: angl := (7 * pi) / 6;
    225: angl := (5 * pi) / 4;
    240: angl := (4 * pi) / 3;
    270: angl := (3 * pi) / 2;
    300: angl := (5 * pi) / 3;
    315: angl := (7 * pi) / 4;
    330: angl := (11 * pi) / 6;
    360: angl := 2 * pi;
  end;

  hMasX[0] := (hR * Cos(angl)) / 1000;
  hMasY[0] := (hR * Sin(angl)) / 1000;

end;

end.
