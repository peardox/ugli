unit FileUtils;

{$ifdef fpc}
{$mode ObjFPC}{$H+}
{$endif}


interface

uses
  Classes, SysUtils;

function ReadTextFile(const AFilename: String): String;

implementation

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


end.

