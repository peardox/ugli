unit MainFMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

Uses
  Network;

procedure TForm1.FormCreate(Sender: TObject);
var
   Dict: TSteamApps;
begin
  Dict := ReadApplist();
  if Assigned(Dict) then
    ShowMessage('Apps = ' + IntToStr(Dict.Count));
end;

end.
