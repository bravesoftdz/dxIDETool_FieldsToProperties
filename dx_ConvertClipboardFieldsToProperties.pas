unit dx_ConvertClipboardFieldsToProperties;

interface

  procedure ConvertClipboardFieldsToProperties();

implementation
uses
  SysUtils,
  Classes,
  Clipbrd,
  Windows;

//1.0 dkm 2016-01-01 Initial creation
procedure ConvertClipboardFieldsToProperties();
var
  vClipboard:TClipboard;
  vInputText:TStringList;
  vOutputString:String;
  i:Integer;
  vLine:String;
  vColonIndex:Integer;
  vFieldName:String;
  vClassType:String;
begin
  vClipboard := TClipboard.Create();
  try
    vInputText := TStringlist.Create();
    try
      vInputText.Text := vClipboard.AsText;
      vOutputString := '';
      for i := 0 to vInputText.Count-1 do
      begin
        vLine := Trim(vInputText[i]);

        if Length(vLine) > 0 then
        begin
          //convert lines like: "FMyName:MyType;"
          //to "    property MyName:MyType read fMyName write fMyName"
          vColonIndex := Pos(':', vLine);
          if vColonIndex > 1 then
          begin
            vFieldName := Trim(Copy(vLine, 1, vColonIndex - 1));
            vClassType := Trim(Copy(vLine, vColonIndex + 1, Length(vLine) - vColonIndex -1));

            vOutputString := vOutputString
                             + '    property '
                             + Copy(vFieldName, 2, Length(vFieldname) - 1)
                             + ':' + vClassType
                             + ' read ' + vFieldName + ' write ' + vFieldName + ';' + #13#10;
          end;
        end;
      end;
      if Length(vOutputString) > 0 then
      begin
        vClipboard.AsText := vOutputString;
      end;
    finally
      vInputText.Free();
    end;
  finally
    vClipboard.Free();
  end;
end;


end.
