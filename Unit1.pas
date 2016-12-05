unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Common_Unit, postr;

type
  TForm1 = class(TForm)
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button2: TButton;
    GB1: TGroupBox;
    Button3: TButton;
    GB2: TGroupBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  turn_to(3); //Внутренняя часть
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  turn_to(2); //Вал
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  turn_to(1); //Основа
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  turn_to(4); //прямоугольный элемент
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  turn_to(5); //треугольный элемент
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  turn_to(6); //круглый элемент
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  turn_to(7); //Прокладка
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  turn_to(8); //Обмотка
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  turn_to(9); //Основание
end;

end.
