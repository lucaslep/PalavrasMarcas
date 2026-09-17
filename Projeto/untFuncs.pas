unit untFuncs;

interface

function ArrayHasValue(Arr: array of Integer; Value: Integer): Boolean;

implementation

uses
  SysUtils;

function ArrayHasValue(Arr: array of Integer; Value: Integer): Boolean;
var
  j: Integer;
begin
  Result := False;
  for j := Low(Arr) to High(Arr) do
  begin
    if Arr[j] = Value then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.
