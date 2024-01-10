unit HtmlLabel;

interface

uses
  Classes, SysUtils, LResources, Graphics, StdCtrls,
  HtmlView, HtmlGlobals;

type
  THtmlLabel = class(THtmlViewer)
  private
    FBody: TStrings;
    FCSS: TStrings;
    procedure SetBody(const Value: TStrings);
    procedure SetCSS(const Value: TStrings);
    procedure UpdateHtml;
  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
  published
    property Body :TStrings read FBody write SetBody;
    property CSS :TStrings read FCSS write SetCSS;
    property DefBackground default clBtnFace;
    property DefFontColor default clWindowText;
    property DefFontSize default 11;
    property BorderStyle default htNone;
    property ScrollBars default ssNone;
  end;

  procedure Register;

implementation

const
  HtmlTemplate = '<!DOCTYPE html><head><style>%s</style></head><body>%s</body>';
  //DefaultCss = 'body {margin: 0.5em 0 0.5em 0;}';

type
  THtmlLabelStrings = class(TStringList)
  private
    FHtmlLabel :THtmlLabel;
  protected
    procedure Changed; override;
  public
    constructor Create(HtmlLabel :THtmlLabel);
  end;

{ THtmlLabel }

constructor THtmlLabel.Create(AOwner: TComponent);
begin
  inherited;
  DefBackground := clBtnFace;
  DefFontColor := clWindowText;
  DefFontName := Font.Name;
  DefFontSize := 11;
  BorderStyle := htNone;
  FBody := THtmlLabelStrings.Create(self);
  FCSS := THtmlLabelStrings.Create(self);
  ScrollBars := ssNone;
  Height := 28;
  Width := 128;
end;

destructor THtmlLabel.Destroy;
begin
  FBody.Free;
  FCSS.Free;
  inherited;
end;

procedure THtmlLabel.SetBody(const Value: TStrings);
begin
  FBody.Assign(Value);
  UpdateHtml;
end;

procedure THtmlLabel.SetCSS(const Value: TStrings);
begin
  FCSS.Assign(Value);
  UpdateHtml;
end;

procedure THtmlLabel.UpdateHtml;
var
  Html :string;
begin
  Html := Format(HtmlTemplate, [FCSS.Text, FBody.Text]);
  LoadFromString(THtString(Html));
  Invalidate;
end;

{ THtmlLabelStrings }

procedure THtmlLabelStrings.Changed;
begin
  inherited;
  FHtmlLabel.UpdateHtml;
end;

constructor THtmlLabelStrings.Create(HtmlLabel: THtmlLabel);
begin
  FHtmlLabel := HtmlLabel;
end;

procedure Register;
begin
  {$I htmllabel.lrs}
  RegisterComponents('Additional',[THtmlLabel]);
end;

end.
