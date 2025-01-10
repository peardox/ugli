unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;
  { ~/Library/Application Support/Steam/libraryfolders.vdf }
  { C:\Program Files (x86)\Steam\config\libraryfolders.vdf }
type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  SteamPath: String;

implementation

{$R *.lfm}
uses
  FileUtils, Network;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  Apps: String;
begin
  {$if defined(WINDOWS)}
  // Computer\HKEY_CURRENT_USER\Software\Valve\Steam SteamPath
  SteamPath := 'C:\\Program Files (x86)\\Steam';
  Memo1.Text := ReadTextFile(SteamPath + '\\config\\libraryfolders.vdf');
  {$elseif defined(DARWIN)}
  SteamPath := GetUserDir() + 'Library/Application Support/Steam';
  Memo1.Text := ReadTextFile(SteamPath + '/config/libraryfolders.vdf');
  {$elseif defined(LINUX)}
  SteamPath := GetUserDir() + '.local/share/Steam';
  Memo1.Text := ReadTextFile(SteamPath + '/config/libraryfolders.vdf');
  {$endif}
  Apps := ReadApplist;
  if Length(Apps) > 0 then
     Memo1.Text := Apps;
end;

end.

