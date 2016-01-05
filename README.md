# dxIDETool_FieldsToProperties.exe
Simple IDE tool to convert a list of fields to properties via the clipboard

<h3>One Time Setup:</h3>
Add a new item to the Tools menu:<br/>
<li>Within the Delphi IDE:  Tools-> Configure Tools...-> Add...
<li>Browse to the <b>dxIDETool_FieldsToProperties.exe</b> file and select it.  
<li>Configure the Title: "Fields To Properties"

<h3>Usage:</h3>
After typing one or more class properties...<br/>
<i>example:</i>
```Delphi
TMyClass = class
private
  //select the next two lines in the source editor
  fProp1:String;
  fProp2:Integer;
````
<li>Highlight the desired class fields and copy the line(s) of text to the clipboard (<b>ctrl-c</b>) 
<li>Use the IDE Tool installed via: Tools->Fields To Properties
<li>The contents of the clipboard will be read in and converted by the tool
<li>Now paste back in the results into the source editor to receive formatted property line(s) (<b>ctrl-v</b>)<br/>
<i>example:</i>

```Delphi
    property Prop1:String read fProp1 write fProp1;
    property Prop2:Integer read fProp2 write fProp2;
````

Note:  Class completion is built-into the Delphi IDE and I use it often.  However, I don't always add a Setter to my fields and this is a simple way to define properties in a different format.  Likely the best tool which offers this functionality (as just one of its many features) is ModelMaker Code Explorer: http://www.modelmakertools.com/code-explorer/index.html

