program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Common_Unit in 'Common_Unit.pas',
  SldWorks_TLB in 'SldWorks_TLB.pas',
  SwConst_TLB in 'SwConst_TLB.pas',
  postr in 'postr.pas',
  Mathbits in 'Mathbits.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
