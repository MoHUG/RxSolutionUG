unit frmPatientActiveReasonUFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, RzDlgBtn, RzLine, ExtCtrls;

type
  TfrmPatientActiveReasonFrm = class(TForm)
    pnlRXBackground: TPanel;
    pnlForm_Header: TPanel;
    lblDispenser: TLabel;
    rzdButtons: TRzDialogButtons;
    RzComboBox1: TRzComboBox;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

  
type
  TRXDELETEReason = class(TObject)
  public
     class function Show(vactive: Boolean; const vOption: integer = 0): String;
  end;

var
  frmPatientActiveReasonFrm: TfrmPatientActiveReasonFrm;

implementation

{$R *.dfm}

class function TRXDELETEReason.Show(vactive: Boolean; const vOption: integer = 0): String;
var
  frmRxReason: TfrmPatientActiveReasonFrm;
  vReason: string;
begin

  Result := '';

  frmRxReason := TfrmPatientActiveReasonFrm.Create(nil);

  //Load reasons for removing item
  with frmRxReason.RzComboBox1 do
   begin
   Items.Clear;
   if vactive then
    begin
    Items.Add('Duplication');
    Items.Add('Down Referred Patient');
    Items.Add('Medical Officer');
    Items.Add('Patient Refusal');
    end
   else
    begin
    Items.Add('Medical Officer');
    end;
   end;


 if vOption =1 then
  with frmRxReason.RzComboBox1 do
   begin
   Items.Clear;
   if vactive then
    begin
    Items.Add('Medical Officer');
    end
   else
    begin
    Items.Add('Medical Officer');
    end;
   end; 

  if frmRxReason.ShowModal = mrOK then
   begin
   vReason := frmRxReason.RzComboBox1.Text;
   Result := vReason;
   end;
  frmRxReason.Free;

end;

end.
