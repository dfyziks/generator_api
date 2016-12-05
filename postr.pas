﻿unit postr;

interface

uses Common_Unit, SwConst_TLB, SldWorks_TLB, OleAuto;

procedure turn_to(sel: integer);
procedure basis();//1
procedure shaft();//2
procedure inside();//3
procedure rectangular_element();//4
procedure triangular_element();//5
procedure circular_element();//6
procedure gasket();//7
procedure winding();//8
procedure base();//9

var
  MD: IModelDoc2; // Документ модели
  SelMgr: ISelectionMgr; // Менеджер выделений
  CP: ISketchPoint; // Точка эскиза
  Seg: array [0 .. 70] of ISketchSegment; // Элемент эскиза

implementation

procedure turn_to(sel: integer);
begin
  MD := OpenSW;
  MD.Visible := False;

  case sel of
    1: //Основа
      begin
        basis();
      end;
    2: //Вал
      begin
        shaft();
      end;
    3: //Внутренняя часть
      begin
        Inside();
      end;
    4: //прямоугольный элемент
      begin
        rectangular_element();
      end;
    5: //треугольный элемент
      begin
        triangular_element();
      end;
    6: //круглый элемент
      begin
        circular_element();
      end;
    7: //Прокладка
      begin
        gasket();
      end;
    8: //Обмотка
      begin
        winding();
      end;
    9: //Основание
      begin
        base();
      end;
  end;

  MD.Visible := True;
 // MD.ShowNamedView2('', 7);
end;

procedure basis(); //1
var i: integer; sdf: extended; kl: IDispatch; gf: IRefPlane;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза



  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCenterLine(0, 0, 0, 20/1000, 0, 0); //os

  Seg[2] := MD.SketchManager.CreateLine(0, 80/2/1000, 0, 16/1000, 80/2/1000, 0); //pravo
  Seg[3] := MD.SketchManager.CreateLine(16/1000, 80/2/1000, 0, 16/1000, 160/2/1000, 0); //verh
  Seg[4] := MD.SketchManager.CreateLine(16/1000, 160/2/1000, 0, 0, 160/2/1000, 0); //levo
  Seg[5] := MD.SketchManager.CreateLine(0, 160/2/1000, 0, 0, 80/2/1000, 0); //niz

  for i := 2 to 5 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureRevolve2(True, True, False, False, False, False, 0, 0,
    6.2831853071796, 0, False, False, 0.01, 0.01, 0, 0, 0, True, True, True);



   { SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза   }

   gf := MD.FeatureManager.InsertRefPlane(8, 30/1000, 0, 0, 0, 0) as IRefPlane;



  // постройка часть №1
  {FindPlanes(MD);
  if (freePlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');

   SelMgr.IGetSelectedObject();

  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');   }
  {}

  {MD.ShowNamedView2('', 3);
  MD.Extension.SelectByID2('', 'FACE', 0, 5.20574728552326E-02, -3.42904172732419E-02, False, 0, Nil, 0);
  MD.SketchManager.InsertSketch(True);
  MD.ClearSelection2(True);}
  //Seg[6] := MD.SketchManager.CreateArc(0.000178, 0.000178, 0, -0.040687, 0.010127, 0, -0.006968, 0.041624, 0, -1);

 { SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (yzPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');

  MD.FeatureManager.InsertRefPlane(8, 0.016, 0, 0, 0, 0);

  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');
  //sdf := 16/1000;
  Seg[6] := MD.SketchManager.CreateArc(0, 0, 0, -0.03, 0.04, 0, 0.03, 0.04, 0, -1);
  Seg[7] := MD.SketchManager.CreateArc(0, 0, 0, -0.02, 0.03, 0, 0.02, 0.03, 0, -1);
  Seg[8] := MD.SketchManager.CreateLine(-0.03, 0.04, 0, -0.02, 0.03, 0);
  Seg[9] := MD.SketchManager.CreateLine(0.03, 0.04, 0, 0.02, 0.03, 0);    }

end;

procedure shaft(); //2
var i: integer;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCenterLine(0, 0, 0, 20/1000, 0, 0); //os

  Seg[2] := MD.SketchManager.CreateLine(0, 0, 0, (4+56+33)/1000, 0, 0); //pravo
  Seg[3] := MD.SketchManager.CreateLine((4+56+33)/1000, 0, 0, (4+56+33)/1000, 12/2/1000, 0); //verh
  Seg[4] := MD.SketchManager.CreateLine((4+56+33)/1000, 12/2/1000, 0, (4+56)/1000, 12/2/1000, 0); //levo
  Seg[5] := MD.SketchManager.CreateLine((4+56)/1000, 12/2/1000, 0, (4+56)/1000, 15/2/1000, 0); //verh

  Seg[6] := MD.SketchManager.CreateLine((4+56)/1000, 15/2/1000, 0, (4+56-11)/1000, 15/2/1000, 0); //levo
  Seg[7] := MD.SketchManager.CreateLine((4+56-11)/1000, 15/2/1000, 0, (4+12)/1000, 17/2/1000, 0); //levo pod uglom
  Seg[8] := MD.SketchManager.CreateLine((4+12)/1000, 17/2/1000, 0, 4/1000, 17/2/1000, 0); //levo

  Seg[9] := MD.SketchManager.CreateLine(4/1000, 17/2/1000, 0, 4/1000, 52/2/1000, 0); //verh
  Seg[10] := MD.SketchManager.CreateLine(4/1000, 52/2/1000, 0, 0, 52/2/1000, 0); //levo
  Seg[11] := MD.SketchManager.CreateLine(0, 52/2/1000, 0, 0, 0, 0); //levo

   for i := 2 to 11 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureRevolve2(True, True, False, False, False, False, 0, 0,
    6.2831853071796, 0, False, False, 0.01, 0.01, 0, 0, 0, True, True, True);
end;

procedure inside(); //3
var i: integer;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCenterLine(0, 0, 0, 20/1000, 0, 0); //os
  Seg[2] := MD.SketchManager.CreateLine(16/1000, 0, 0, 19/1000, 0, 0); //pravo
  Seg[3] := MD.SketchManager.CreateLine(19/1000, 0, 0, 19/1000, 85/2/1000, 0); //verh
  Seg[4] := MD.SketchManager.CreateLine(19/1000, 85/2/1000, 0, 16/1000, 85/2/1000, 0); //levo
  Seg[5] := MD.SketchManager.CreateLine(16/1000, 85/2/1000, 0, 16/1000, 80/2/1000, 0); //niz
  Seg[6] := MD.SketchManager.CreateLine(16/1000, 80/2/1000, 0, 0, 80/2/1000, 0); //levo
  Seg[7] := MD.SketchManager.CreateLine(0, 80/2/1000, 0, 0, 37/1000, 0); //niz
  Seg[8] := MD.SketchManager.CreateLine(0, 37/1000, 0, 16/1000, 37/1000, 0); //pravo
  Seg[9] := MD.SketchManager.CreateLine(16/1000, 37/1000, 0, 16/1000, 0, 0); //niz

  for i := 2 to 9 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureRevolve2(True, True, False, False, False, False, 0, 0,
    6.2831853071796, 0, False, False, 0.01, 0.01, 0, 0, 0, True, True, True);
end;

procedure rectangular_element(); //4
var i: integer;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateLine(0, 0, 0, 19/1000, 0, 0); //pravo
  Seg[2] := MD.SketchManager.CreateLine(19/1000, 0, 0, 19/1000, 26.1/1000, 0); //verh
  Seg[3] := MD.SketchManager.CreateLine(19/1000, 26.1/1000, 0, 0, 26.1/1000, 0); //levo
  Seg[4] := MD.SketchManager.CreateLine(0, 26.1/1000, 0, 0, 0, 0); //niz

  for i := 1 to 4 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 15/1000, 15/1000,
    False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False,
    False, False, False, True, True, True, 0, 0, False)

end;

procedure triangular_element();//5
var i: integer;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateLine(0, 0, 0, 15/2/1000, 25/1000, 0); //diag verh
  Seg[2] := MD.SketchManager.CreateLine(15/2/1000, 25/1000, 0, -15/2/1000, 25/1000, 0); //levo
  Seg[3] := MD.SketchManager.CreateLine(-15/2/1000, 25/1000, 0, 0, 0, 0); //diag niz

  for i := 1 to 3 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 30/1000, 30/1000,
    False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False,
    False, False, False, True, True, True, 0, 0, False)
end;

procedure circular_element();//6
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCircleByRadius(0, 0, 0, 95/2/1000); //krug1
  Seg[2] := MD.SketchManager.CreateCircleByRadius(0, 0, 0, 150/2/1000); //krug2

  MD.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 1/1000, 1/1000,
    False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False,
    False, False, False, True, True, True, 0, 0, False)
end;

procedure gasket();//7
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCircleByRadius(0, 0, 0, 95/2/1000); //krug1
  Seg[2] := MD.SketchManager.CreateCircleByRadius(0, 0, 0, 150/2/1000); //krug2

  MD.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 3/1000, 3/1000,
    False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False,
    False, False, False, True, True, True, 0, 0, False)
end;

procedure winding();//8
var i: integer;
    x1, y1, x2, y2, xc, yc: extended;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  x1 := -16.22785148/1000; x2 := -16.22785148/1000;
  y1 := -14.56873402/1000; y2 := 14.56873402/1000;
  xc := -11.76222297/1000;
  yc := 0;
  Seg[1] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, -1); //duga1 sleva

  x1 := -18.57235541/1000; x2 := -18.57235541/1000;
  y1 := -22.2174791/1000; y2 := 22.2174791/1000;
  xc := -11.76222297/1000;
  yc := 0;
  Seg[2] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, -1); //duga2 sleva

  x1 := 16.22785148/1000; x2 := 16.22785148/1000;
  y1 := -14.56873402/1000; y2 := 14.56873402/1000;
  xc := 11.76222297/1000;
  yc := 0;
  Seg[3] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, 1); //duga3 sprava

  x1 := 18.57235541/1000; x2 := 18.57235541/1000;
  y1 := -22.2174791/1000; y2 := 22.2174791/1000;
  xc := 11.76222297/1000;
  yc := 0;
  Seg[4] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, 1); //duga4 sprava

  x1 := 16.22785148/1000; x2 := -16.22785148/1000;
  y1 := 14.56873402/1000; y2 := 14.56873402/1000;
  xc := 0;
  yc := -38.37325411/1000;
  Seg[5] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, 1); //duga5 vverh

  x1 := 18.57235541/1000; x2 := -18.57235541/1000;
  y1 := 22.2174791/1000; y2 := 22.2174791/1000;
  xc := 0;
  yc := -38.37325411/1000;
  Seg[6] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, 1); //duga6 vverh

  x1 := 16.22785148/1000; x2 := -16.22785148/1000;
  y1 := -14.56873402/1000; y2 := -14.56873402/1000;
  xc := 0;
  yc := 38.37325411/1000;
  Seg[7] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, -1); //duga7 vniz

  x1 := 18.57235541/1000; x2 := -18.57235541/1000;
  y1 := -22.2174791/1000; y2 := -22.2174791/1000;
  xc := 0;
  yc := 38.37325411/1000;
  Seg[8] := MD.SketchManager.CreateArc(xc, yc, 0, x1, y1, 0, x2, y2, 0, -1); //duga8 vniz

  for i := 1 to 8 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureExtrusion2(True, False, False, 0, 0, 15/1000, 15/1000,
    False, False, False, False, 1.74532925199433E-02, 1.74532925199433E-02, False,
    False, False, False, True, True, True, 0, 0, False)
end;

procedure base();//9
var i: integer;
begin
  if MD = nil then
    begin
      Raise EOleError.Create('не создан документ!');
    end;
  SelMgr := MD.ISelectionManager;
  if SelMgr = nil then
    Raise EOleError.Create('xm!'); // Вошел в режим эскиза

  // постройка часть №1
  FindPlanes(MD);
  if (xyPlane as IFeature).Select(False) then
    MD.InsertSketch
  else
    Raise EOleError.Create('Не выбрана плоскость!');
  if MD.SelectByID('', 'EXTSKETCHPOINT', 0, 0, 0) then
    CP := SelMgr.IGetSelectedObject(1) as ISketchPoint
  else
    Raise EOleError.Create('Не выбрана исходная точка!');
  if CP = nil then
    Raise EOleError.Create('Не выбран указатель на исходную точку!');

  Seg[1] := MD.SketchManager.CreateCenterLine(0, 0, 0, 20/1000, 0, 0); //os
  Seg[2] := MD.SketchManager.CreateLine(1/1000, 35/2/1000, 0, (11+1)/1000, 35/2/1000, 0); //pravo
  Seg[3] := MD.SketchManager.CreateLine((11+1)/1000, 35/2/1000, 0, (11+1)/1000, 27/2/1000, 0); //niz
  Seg[4] := MD.SketchManager.CreateLine((11+1)/1000, 27/2/1000, 0, (47+10-26)/1000, 27/2/1000, 0); //pravo
  Seg[5] := MD.SketchManager.CreateLine((47+10-26)/1000, 27/2/1000, 0, (47+10-26)/1000, 35/2/1000, 0); //verh
  Seg[6] := MD.SketchManager.CreateLine((47+10-26)/1000, 35/2/1000, 0, (47+10-12)/1000, 35/2/1000, 0); //pravo
  Seg[7] := MD.SketchManager.CreateLine((47+10-12)/1000, 35/2/1000, 0, (47+10-12)/1000, 40/2/1000, 0); //verh
  Seg[8] := MD.SketchManager.CreateLine((47+10-12)/1000, 40/2/1000, 0, (47+10)/1000, 40/2/1000, 0); //pravo
  Seg[9] := MD.SketchManager.CreateLine((47+10)/1000, 40/2/1000, 0, (47+10)/1000, 50/2/1000, 0); //verh
  Seg[10] := MD.SketchManager.CreateLine((47+10)/1000, 50/2/1000, 0, 10/1000, 50/2/1000, 0); //levo
  Seg[11] := MD.SketchManager.CreateLine(10/1000, 50/2/1000, 0, 10/1000, 180/2/1000, 0); //verh
  Seg[12] := MD.SketchManager.CreateLine(10/1000, 180/2/1000, 0, 1/1000, 180/2/1000, 0); //levo
  Seg[13] := MD.SketchManager.CreateLine(1/1000, 180/2/1000, 0, 1/1000, 100/2/1000, 0); //niz
  Seg[14] := MD.SketchManager.CreateLine(1/1000, 100/2/1000, 0, 0, 100/2/1000, 0); //levo
  Seg[15] := MD.SketchManager.CreateLine(0, 100/2/1000, 0, 0, 62/2/1000, 0); //niz
  Seg[16] := MD.SketchManager.CreateLine(0, 62/2/1000, 0, 1/1000, 62/2/1000, 0); //pravo
  Seg[17] := MD.SketchManager.CreateLine(1/1000, 62/2/1000, 0, 1/1000, 35/2/1000, 0); //niz

  for i := 2 to 17 do
    Seg[i].Select(True);
  MD.SketchAddConstraints('sgFIXED');

  MD.FeatureManager.FeatureRevolve2(True, True, False, False, False, False, 0, 0,
    6.2831853071796, 0, False, False, 0.01, 0.01, 0, 0, 0, True, True, True);
end;

end.
