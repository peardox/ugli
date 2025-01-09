unit Unit1;

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

implementation

{$R *.lfm}

function ReadTextFile(const AFilename: String): String;
var
  F: TFileStream;
begin
  Result := String.Empty;
  if(FileExists(AFilename)) then
    begin
      F := TFileStream.Create(AFilename, fmOpenRead, fmShareDenyNone);
      F.Seek(0, soFromBeginning);
      SetLength(Result, F.Size);
      if F.Size <> 0 then
        F.ReadBuffer(Result[1], Length(Result));
    end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$if defined(WINDOWS)}
  Memo1.Text := ReadTextFile('C:\\Program Files (x86)\\Steam\\config\\libraryfolders.vdf');
  {$elseif defined(DARWIN)}
  Memo1.Text := ReadTextFile(GetUserDir() + 'Library/Application Support/Steam/config/libraryfolders.vdf');
  {$endif}
end;

end.

