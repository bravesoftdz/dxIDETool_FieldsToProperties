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
//1.1 dkm 2016-01-02 Issue #1: Strip inline comments
//1.2 dkm 2016-01-02 Issue #2: Maintain leading whitespace
procedure ConvertClipboardFieldsToProperties();
var
  vClipboard:TClipboard;
  vInputText:TStringList;
  vOutputString:String;
  i,j:Integer;
  vLine:String;
  vPos:Integer;
  vFieldName:String;
  vClassType:String;
  vIndent:String;
begin
  vClipboard := TClipboard.Create();
  try
    vInputText := TStringlist.Create();
    try
      vInputText.Text := vClipboard.AsText;
      vOutputString := '';
      for i := 0 to vInputText.Count-1 do
      begin
        vLine := vInputText[i];
        vIndent := '';
        for j := 1 to Length(vLine) do
        begin
          if vLine[j] in [#9,#32] then //keep original whitespace
          begin
            vIndent := vIndent + vLine[j];
          end
          else
          begin
            Break;
          end;
        end;
        vLine := Copy(vLine, Length(vIndent)+1, MaxInt);

        if Length(vLine) > 0 then
        begin
          //convert lines like: "FMyName:MyType;"
          //to "    property MyName:MyType read fMyName write fMyName"
          vPos := Pos(':', vLine);
          if vPos > 1 then
          begin
            vFieldName := Trim(Copy(vLine, 1, vPos - 1));
            vClassType := Trim(Copy(vLine, vPos + 1, Length(vLine) - vPos));
            vPos := Pos(';', vClassType);
            if vPos > -1 then
            begin
              //strip everything past the ;  (Comments)
              vClassType := Copy(vClassType, 1, vPos-1);

              vOutputString := vOutputString + vIndent
                               + 'property '
                               + Copy(vFieldName, 2, Length(vFieldname) - 1)
                               + ':' + vClassType
                               + ' read ' + vFieldName + ' write ' + vFieldName + ';' + #13#10;
            end;
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
