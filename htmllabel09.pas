{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit HtmlLabel09;

{$warn 5023 off : no warning about unused units}
interface

uses
  HtmlLabel, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('HtmlLabel', @HtmlLabel.Register);
end;

initialization
  RegisterPackage('HtmlLabel09', @Register);
end.
