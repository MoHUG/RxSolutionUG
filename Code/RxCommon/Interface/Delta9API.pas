unit Delta9API;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, ActiveX, AxCtrls;
type


  TPatientDC = class;
  TResponse = class;
  TDelta9 = class;
  
  TMessageResult = class;
  TDelta9 = class(TObject)
  private
  public
    constructor Create;
  published
    function GetPatientByFolderNumber(prmFolderNumber : string): TMessageResult;
  end;

  TPatientDC = class(TObject)
  private
    FAddress1: string;
    FAddress2: string;
    FAddress3: string;
    FClinic: string;
    FDateOfBirth: TDateTime;
    FFirstname: string;
    FFolderLocation: string;
    FFolderNumber: string;
    FIdNumber: string;
    FInitial: string;
    FLanguage: string;
    FLocation: string;
    FMaritalStatus: string;
    FNameKey: string;
    FNationality: string;
    FNextOfAddress1: string;
    FNextOfAddress2: string;
    FNextOfAddress3: string;
    FNextOfHomePhone: string;
    FNextOfKinFirstName: string;
    FNextOfKinSurname: string;
    FNextOfPostalCode: string;
    FNextOfWorkPhone: string;
    FOccupation: string;
    FPhone: string;
    FPostalCode: string;
    FRecentVisitCatagory: string;
    FRecentVisitDate: TDateTime;
    FRecentVisitType: string;
    FRelationshipToPatient: string;
    FReligon: string;
    FSex: string;
    FSurname: string;
    FTitle: string;
    procedure DefaultValues(patient: TPatientDC);
    procedure LoadPatient(wsPatient: OleVariant; patient: TPatientDC; var
        wsResponse: TResponse);
  public
    constructor Create; overload;
    constructor Create(wsPatient: OleVariant; var wsResponse: TResponse); overload;
    function Clear: boolean;
    property Address1: string read FAddress1 write FAddress1;
    property Address2: string read FAddress2 write FAddress2;
    property Address3: string read FAddress3 write FAddress3;
    property Clinic: string read FClinic write FClinic;
    property DateOfBirth: TDateTime read FDateOfBirth write FDateOfBirth;
    property Firstname: string read FFirstname write FFirstname;
    property FolderLocation: string read FFolderLocation write FFolderLocation;
    property FolderNumber: string read FFolderNumber write FFolderNumber;
    property IdNumber: string read FIdNumber write FIdNumber;
    property Initial: string read FInitial write FInitial;
    property Language: string read FLanguage write FLanguage;
    property Location: string read FLocation write FLocation;
    property MaritalStatus: string read FMaritalStatus write FMaritalStatus;
    property NameKey: string read FNameKey write FNameKey;
    property Nationality: string read FNationality write FNationality;
    property NextOfAddress1: string read FNextOfAddress1 write FNextOfAddress1;
    property NextOfAddress2: string read FNextOfAddress2 write FNextOfAddress2;
    property NextOfAddress3: string read FNextOfAddress3 write FNextOfAddress3;
    property NextOfHomePhone: string read FNextOfHomePhone write FNextOfHomePhone;
    property NextOfKinFirstName: string read FNextOfKinFirstName write
        FNextOfKinFirstName;
    property NextOfKinSurname: string read FNextOfKinSurname write
        FNextOfKinSurname;
    property NextOfPostalCode: string read FNextOfPostalCode write
        FNextOfPostalCode;
    property NextOfWorkPhone: string read FNextOfWorkPhone write FNextOfWorkPhone;
    property Occupation: string read FOccupation write FOccupation;
    property Phone: string read FPhone write FPhone;
    property PostalCode: string read FPostalCode write FPostalCode;
    property RecentVisitCatagory: string read FRecentVisitCatagory write
        FRecentVisitCatagory;
    property RecentVisitDate: TDateTime read FRecentVisitDate write
        FRecentVisitDate;
    property RecentVisitType: string read FRecentVisitType write FRecentVisitType;
    property RelationshipToPatient: string read FRelationshipToPatient write
        FRelationshipToPatient;
    property Religon: string read FReligon write FReligon;
    property Sex: string read FSex write FSex;
    property Surname: string read FSurname write FSurname;
    property Title: string read FTitle write FTitle;
  end;

  TResponse = class(TObject)
  private
    FErrors: TStringList;
    FSuccess: Boolean;
    FWarnings: TStringList;
  public
    constructor Create;
    procedure Reset;
    property Errors: TStringList read FErrors write FErrors;
    property Success: Boolean read FSuccess write FSuccess;
    property Warnings: TStringList read FWarnings write FWarnings;
  end;

  TMessageResult = class(TObject)
  private
    FPatientD9: TPatientDC;
    FPatientRx: TPatientDC;
    FResponse: TResponse;
  public
    constructor Create;
    property PatientD9: TPatientDC read FPatientD9 write FPatientD9;
    property PatientRx: TPatientDC read FPatientRx write FPatientRx;
    property Response: TResponse read FResponse write FResponse;
  end;

implementation


constructor TDelta9.Create;
begin
  inherited Create;

end;

function TDelta9.GetPatientByFolderNumber(prmFolderNumber : string):
    TMessageResult;
var
    Delta9Service : OleVariant;
    PatientDC     : OleVariant;

begin
  Result := TMessageResult.Create;
  try

    Delta9Service   := CreateOleObject('Pbg.Rx.Delta9.Administration');
    PatientDC       := Delta9Service.GetPatientByFolderNumber(prmFolderNumber);

  except on e: Exception do
    Result.Response.Errors.Add(e.Message);
  end;

end;

constructor TResponse.Create;
begin
  inherited Create;
  FErrors   := TStringList.Create;
  FWarnings := TStringList.Create;
  FSuccess  := false;
end;

procedure TResponse.Reset;
begin
  FSuccess    := false;
  FErrors.Clear;
  FWarnings.Clear
end;

constructor TPatientDC.Create;
begin
  inherited create;
  // TODO -cMM: TPatientDC.Create default body inserted
end;

constructor TPatientDC.Create(wsPatient: OleVariant; var wsResponse: TResponse);
begin
  inherited Create;
  LoadPatient(wsPatient, self, wsResponse);
end;

function TPatientDC.Clear: boolean;
begin

  if(self <> nil) then
    begin
    DefaultValues(self);
    Result := true;
    end
  else
    begin
    Result := false;
    end;
    
end;

procedure TPatientDC.DefaultValues(patient: TPatientDC);
begin
    patient.FolderNumber      := '';
    patient.FolderLocation    := '';
    patient.Clinic            := '';

    // Patient personal details
    patient.Surname           := '';
    patient.FirstName         := '';
    patient.Initial           := '';
    patient.Sex               := '';
    patient.DateOfBirth       := Date - 15000;

    // Patient other details
    patient.Religon           := '';
    patient.MaritalStatus     := '';
    patient.Occupation        := '';
    patient.Title             := '';
    patient.Language          := '';
    patient.Nationality       := '';
    patient.IdNumber          := '';

    // Contact details
    patient.Address1          := '';
    patient.Address2          := '';
    patient.Address3          := '';
    patient.PostalCode        := '';
    patient.Phone             := '';

    // Delta9 visit data
    patient.RecentVisitDate   := Date - 15000;
    patient.RecentVisitType   := '';
    patient.RecentVisitCatagory := '';
    patient.NameKey           := '';

    // Next of Kin
    patient.RelationshipToPatient := '';
    patient.NextOfKinSurname  := '';
    patient.NextOfKinFirstName := '';
    patient.NextOfAddress1    := '';
    patient.NextOfAddress2    := '';
    patient.NextOfAddress3    := '';
    patient.NextOfPostalCode  := '';
    patient.NextOfHomePhone   := '';
    patient.NextOfWorkPhone   := '';
end;

procedure TPatientDC.LoadPatient(wsPatient: OleVariant; patient: TPatientDC;
    var wsResponse: TResponse);
begin

  wsResponse.Success := false;
  patient.Clear;

  try

    if (wsPatient.FolderNumber = '') then
      begin
      //wsResponse.Warnings.Add('Folder # (' + prmFolderNumber + ') not found.');
      wsResponse.Warnings.Add('Folder # (?) not found.');
      end
    else
      begin
      // Facility Administration fields
      patient.FolderNumber          := wsPatient.FolderNumber;
      patient.FolderLocation        := wsPatient.FolderLocation;
      patient.Clinic                := wsPatient.Clinic;

      // Patient personal details
      patient.Title                 := wsPatient.Title;
      patient.Surname               := wsPatient.Surname;
      patient.FirstName             := wsPatient.FirstName;
      patient.Initial               := wsPatient.Initial;
      patient.Sex                   := wsPatient.Sex;
      patient.DateOfBirth           := wsPatient.DateOfBirth;

      // Patient other details
      patient.Religon               := wsPatient.Religon;
      patient.MaritalStatus         := wsPatient.MaritalStatus;
      patient.Occupation            := wsPatient.Occupation;
      patient.Language              := wsPatient.Language;
      patient.Nationality           := wsPatient.Nationality;
      patient.IdNumber              := wsPatient.IdNumber;

      // Contact details
      patient.Address1              := wsPatient.Address1;
      patient.Address2              := wsPatient.Address2;
      patient.Address3              := wsPatient.Address3;
      patient.PostalCode            := wsPatient.PostalCode;
      patient.Phone                 := wsPatient.Phone;

      // Delta9 visit data
      patient.RecentVisitDate       := wsPatient.RecentVisitDate;
      patient.RecentVisitType       := wsPatient.RecentVisitType;
      patient.RecentVisitCatagory   := wsPatient.RecentVisitCatagory;
      patient.NameKey               := wsPatient.NameKey;

      // Next of Kin
      patient.RelationshipToPatient := wsPatient.RelationshipToPatient;
      patient.NextOfKinSurname      := wsPatient.NextOfKinSurname;
      patient.NextOfKinFirstName    := wsPatient.NextOfKinFirstName;
      patient.NextOfAddress1        := wsPatient.NextOfAddress1;
      patient.NextOfAddress2        := wsPatient.NextOfAddress2;
      patient.NextOfAddress3        := wsPatient.NextOfAddress3;
      patient.NextOfPostalCode      := wsPatient.NextOfPostalCode;
      patient.NextOfHomePhone       := wsPatient.NextOfHomePhone;
      patient.NextOfWorkPhone       := wsPatient.NextOfWorkPhone;

      wsResponse.Success  := true;
      end;
  except on e: Exception do
    wsResponse.Errors.Add(e.Message);
  end;

end;



constructor TMessageResult.Create;
begin

  inherited Create;
  PatientD9 := TPatientDC.Create;
  PatientRx := TPatientDC.Create;
  Response  := TResponse.Create;
end;


end.


