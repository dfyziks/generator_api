unit Common_Unit;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SwConst_TLB, Math, ExtCtrls, SldWorks_TLB, System.Win.ComObj,
  ComCtrls, Menus;

function OpenSW: IModelDoc2;
function FindPlanes(ModelDoc: IModelDoc2): HResult;
function CloseSWSave: string;
function CloseSWShow: HResult;

var
  xyPlane: IRefPlane; // Главная плоскость XY
  xzPlane: IRefPlane; // Главная плоскость XZ
  yzPlane: IRefPlane; // Главная плоскость YZ
  //freePlane: IRefPlane; // Свободная плоскость
  Razmer, privyaz: boolean;
  hr: HResult;
  SW: ISldWorks;
  MD: IModelDoc2;

Type
  TmyRecord = Record
  end;

  Trec = file of TmyRecord;

implementation

// uses Unit1;

function FindPlanes(ModelDoc: IModelDoc2): HResult;
var

  f: IFeature;
  rp: IRefPlane;
  i: Byte;
  v: Variant;
  hr: HResult;
begin
  hr := S_OK;
  f := ModelDoc.IFirstFeature;
  if f = nil then
    hr := S_FALSE;
  i := 0;
  while (f <> nil) and (i <= 3) do
  begin
    if f.GetTypeName = 'RefPlane' then
    begin
      rp := f.GetSpecificFeature as IRefPlane;
      v := rp.GetRefPlaneParams;
      if (v[0] = 0) and (v[1] = 0) and (v[2] = 0) then
      begin
        Inc(i);
        if (v[6] = 0) and (v[7] = 0) and (v[8] <> 0) then
          xyPlane := rp
        else if (v[6] <> 0) and (v[7] = 0) and (v[8] = 0) then
          yzPlane := rp
        else if (v[6] = 0) and (v[7] <> 0) and (v[8] = 0) then
          xzPlane := rp
        {else if (v[6] <> 0) and (v[7] <> 0) and (v[8] <> 0) then
          freePlane := rp
        else if (v[3] <> 0) and (v[4] = 0) and (v[5] = 0) then
          freePlane := rp
        else if (v[3] = 0) and (v[4] = 0) and (v[5] <> 0) then
          freePlane := rp}
      end;
    end;
    f := f.IGetNextFeature;
  end;
  if (xyPlane = nil) or (yzPlane = nil) or (xzPlane = nil){ or (freePlane = nil)} then
    hr := S_FALSE;
  Result := hr;
end;

function OpenSW: IModelDoc2;
begin
  { Запуск SW и создание нового документа }
  SW := CreateOleObject('SldWorks.Application') as ISldWorks;
  if SW = nil then
    hr := E_OutOfMemory;
  If SW.Visible = false then
    SW.Visible := true;
  // привязки убираем   и размеры убираем
  Result := SW.NewPart as IModelDoc2;
  MD := Result;
  Razmer := SW.GetUserPreferenceToggle(SWInputDimValOnCreate);
  SW.SetUserPreferenceToggle(SWInputDimValOnCreate, false);
  privyaz := MD.GetInferenceMode;
  MD.SetInferenceMode(false);

end;

function CloseSWSave: string;
var
  a: Trec;
begin
  // привязки и размеры включаем
  MD.SetInferenceMode(privyaz);
  SW.SetUserPreferenceToggle(SWInputDimValOnCreate, Razmer);
  SW.Visible := false;

  // if Form1.SD1.execute then
  // begin
  // MD.SaveAs(Form1.SD1.FileName);
  // Result := Form1.SD1.FileName;
  // end;
  { Case Form1.SD1.FilterIndex of    //использовать для нескольких разных типов
    0:AssignFile(a,Form1.SD1.FileName+'.prt' + ';' + '.SLDPRT');
    1:AssignFile(a,Form1.SD1.FileName+'.SLDPRT');
    end; }

end;

function CloseSWShow: HResult;
var
  a: Trec;
begin
  // привязки и размеры включаем
  MD.SetInferenceMode(privyaz);
  SW.SetUserPreferenceToggle(SWInputDimValOnCreate, Razmer);
  SW.Visible := true;
  Result := S_OK;
end;

end.
