unit PrepackingUDM;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ADODB, Variants, ppBands, ppClass, ppCtrls, ppPrnabl,
  ppCache, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppReport,  ExtCtrls,
    MyApplicationUtilities, ActnList, DBActns, ppParameter,
  ppModule, raCodMod, ppVar, DateUtils, myChkBox, ppStrtch, RBTableGrid,
  ppEndUsr;


const
  HST_ADD     = 'ADDED';
  HST_DEL     = 'DELETED';
  HST_EDT     = 'EDITED';
  HST_OVR     = '*ADMIN OVERRIDE*';
  HST_ERR     = '*ERROR*';
  HST_PRN     = 'PRINTED';
  HST_CHG     = 'CHANGED PRODUCT';
  HST_LBL     = 'RESULT LABEL UPDATED';

  ADD_ITEM    = 0;
  ADD_RET     = 1;


type
  TPrepackingDM = class(TDataModule)
    adoPrepacking: TADOConnection;
    qryPrepacking: TADOQuery;
    qryPrepackingItems: TADOQuery;
    dsqryPrepacking: TDataSource;
    dsPrepackingItems: TDataSource;
    dsDemanders: TDataSource;
    tblSystemUsers: TADOQuery;
    tblDemanders: TADOQuery;
    dsUsers: TDataSource;
    qryItemEditHisory: TADOQuery;
    dsqryItemEditHisory: TDataSource;
    stp_Totals: TADOStoredProc;
    ActionList1: TActionList;
    atnSaveClose: TAction;
    AdoAddSingleItem: TADOCommand;
    atnAddSingleItem: TAction;
    tblProducts: TADOQuery;
    dsProducts: TDataSource;
    atnDeleteItem: TAction;
    atnDeleteAllItems: TAction;
    ItemsFirst1: TDataSetFirst;
    ItemsPrior1: TDataSetPrior;
    ItemsNext1: TDataSetNext;
    ItemsLast1: TDataSetLast;
    ItemsPost1: TDataSetPost;
    ItemsCancel1: TDataSetCancel;
    qryItemEditHisoryPrepackingHistory_ID: TAutoIncField;
    qryItemEditHisoryPrepacking_ID: TIntegerField;
    qryItemEditHisoryPrepackingItem_ID: TIntegerField;
    qryItemEditHisoryDescription_str: TStringField;
    qryItemEditHisoryDate_dat: TDateTimeField;
    qryItemEditHisoryProductCode_ID: TIntegerField;
    qryItemEditHisoryType_str: TStringField;
    qryItemEditHisoryUser_ID: TIntegerField;
    qryItemEditHisoryUserName_str: TStringField;
    tblDemandersDemander_ID: TAutoIncField;
    tblDemandersCode_str: TWideStringField;
    tblDemandersName_str: TWideStringField;
    tblDemandersDemanderUnique_ID: TGuidField;
    tblProductsProductCode_ID: TAutoIncField;
    tblProductsDescription_str: TStringField;
    tblProductsICN_str: TWideStringField;
    tblProductsPackSizeValue_dbl: TFloatField;
    tblProductsCost_mon: TBCDField;
    tblProductsBin_str: TWideStringField;
    tmpItems: TADOQuery;
    dstmpItems: TDataSource;
    dsqryProductBatch: TDataSource;
    qryProductBatch: TADOQuery;
    qryFindBatch: TADOQuery;
    stp_ADDProductBatches: TADOCommand;
    atnSelectBatch: TAction;
    qryPrepackingItemsPrepackingItem_ID: TAutoIncField;
    qryPrepackingItemsPrepacking_ID: TIntegerField;
    qryPrepackingItemsNSN_str: TStringField;
    qryPrepackingItemsECN_str: TStringField;
    qryPrepackingItemsICN_str: TStringField;
    qryPrepackingItemsProductCode_ID: TIntegerField;
    qryPrepackingItemsDescription_str: TWideStringField;
    qryPrepackingItemsProductBatch_ID: TIntegerField;
    qryPrepackingItemsBatchNumber_str: TWideStringField;
    qryPrepackingItemsExpiry_dat: TDateTimeField;
    qryPrepackingItemsPackCost_mon: TBCDField;
    qryPrepackingItemsExtendedCost_mon: TBCDField;
    qryPrepackingItemsQtyOnHand_int: TIntegerField;
    qryPrepackingItemsAvailable: TIntegerField;
    qryPrepackingWorker: TADOQuery;
    dsqryPrepackingWorker: TDataSource;
    qryPrepackingWorkerPrepacking_ID: TAutoIncField;
    qryPrepackingWorkerSystemStore_ID: TIntegerField;
    qryPrepackingWorkerCreated_dat: TDateTimeField;
    qryPrepackingWorkerPrepackingRefNo_str: TWideStringField;
    qryPrepackingWorkerPackedBy_str: TWideStringField;
    qryPrepackingWorkerPacked_dat: TDateTimeField;
    qryPrepackingWorkerCheckedBy_str: TWideStringField;
    qryPrepackingWorkerChecked_dat: TDateTimeField;
    qryPrepackingWorkerProductCode_ID: TIntegerField;
    qryPrepackingWorkerResultantItem_str: TWideStringField;
    qryPrepackingWorkerResultPackSize_int: TIntegerField;
    qryPrepackingWorkerICN_str: TWideStringField;
    qryPrepackingWorkerRemainderDemander_str: TWideStringField;
    qryPrepackingWorkerRemainderDemander_ID: TIntegerField;
    qryPrepackingWorkerTotalCost_mon: TBCDField;
    qryPrepackingWorkerItemsNo_int: TIntegerField;
    qryPrepackingWorkerResultExpiry_dat: TDateTimeField;
    qryPrepackingWorkerResultBatchNumber_str: TWideStringField;
    qryPrepackingWorkerAdditionalCost_mon: TBCDField;
    qryPrepackingWorkerFinalYield_int: TIntegerField;
    qryPrepackingWorkerExpectedYield_int: TIntegerField;
    qryPrepackingWorkerRemainder_int: TIntegerField;
    qryPrepackingWorkerHumidity_dbl: TFloatField;
    qryPrepackingWorkerTemperature_dbl: TFloatField;
    qryPrepackingWorkerPosted_bol: TBooleanField;
    qryPrepackingWorkerPosted_dat: TDateTimeField;
    qryPrepackingWorkerRemarks_mem: TMemoField;
    q: TWideStringField;
    qryPrepackingWorkerLastEditedBy_ID: TIntegerField;
    qryPrepackingWorkerLastUpdate_dat: TDateTimeField;
    qryPrepackingWorkerCheckedOut_bol: TBooleanField;
    qryPrepackingWorkerCheckedOutName_str: TWideStringField;
    qryPrepackingWorkerCheckedOut_dat: TDateTimeField;
    atnPrePostandClose: TAction;
    qryPrepackingWorkerCheckedOutBy_ID: TIntegerField;
    stp_PrepackingMarkComplete: TADOQuery;
    tmpItemsPrepackingItem_ID: TAutoIncField;
    tmpItemsPrepacking_ID: TIntegerField;
    tmpItemsNSN_str: TStringField;
    tmpItemsECN_str: TStringField;
    tmpItemsICN_str: TStringField;
    tmpItemsProductCode_ID: TIntegerField;
    tmpItemsDescription_str: TWideStringField;
    tmpItemsProductBatch_ID: TIntegerField;
    tmpItemsBatchNumber_str: TWideStringField;
    tmpItemsExpiry_dat: TDateTimeField;
    tmpItemsPackCost_mon: TBCDField;
    tmpItemsExtendedCost_mon: TBCDField;
    tmpItemsQtyOnHand_int: TIntegerField;
    tmpItemsBatchQty: TIntegerField;
    qryBatchOnHold: TADOQuery;
    qryBatchOnHoldTotal: TADOQuery;
    qryProductPack: TADOQuery;
    qryGeneric_1: TADOQuery;
    tblProductsGenericName_str: TWideStringField;
    qryPrepackingItemsBin_str: TWideStringField;
    tmpItemsBin_str: TWideStringField;
    tblProductBatch: TADOQuery;
    tblProductBatchProductBatch_ID: TAutoIncField;
    tblProductBatchProductCode_ID: TIntegerField;
    tblProductBatchSupplier_ID: TIntegerField;
    tblProductBatchPrice_mon: TBCDField;
    tblProductBatchContractBrandName_str: TWideStringField;
    tblProductBatchSupplierCode_str: TWideStringField;
    tblProductBatchBatchNumber_str: TWideStringField;
    tblProductBatchBarCode_str: TWideStringField;
    tblProductBatchExpiry_dat: TDateTimeField;
    tblProductBatchQtyOnHand_int: TIntegerField;
    tblProductBatchQtyReceived_int: TIntegerField;
    tblProductBatchQtyOnHold_int: TIntegerField;
    tblProductBatchBin_str: TWideStringField;
    tblProductBatchReceived_dat: TDateTimeField;
    tblProductBatchLastLeadTime_int: TIntegerField;
    tblProductBatchRemarks_mem: TMemoField;
    tblProductBatchLastUpdate_dat: TDateTimeField;
    tblProductBatchShippingPack_int: TIntegerField;
    atnPostandClose: TAction;
    qryPrepackingWorkerAccount_ID: TIntegerField;
    qryPrepackingWorkerAccount_str: TWideStringField;
    qryPrepackingItemsNotFromBulk_bol: TBooleanField;
    stp_DeleteAllItems: TADOQuery;
    qryPrepackingItemsProductCode_Str: TWideStringField;
    tmpItemsProductCode_Str: TWideStringField;
    tmpItemsNotFromBulk_bol: TBooleanField;
    qryTotalQtyonHand: TADOQuery;
    qryPrepackingWorkerPreposted_bol: TBooleanField;
    qryPrepackingWorkerPreposted_dat: TDateTimeField;
    qryProductPackProductCode_ID: TAutoIncField;
    qryProductPackPackSizeValue_dbl: TFloatField;
    qryProductPackICN_str: TWideStringField;
    qryProductPackECN_str: TWideStringField;
    qryProductPackNSN_str: TWideStringField;
    qryProductPackProductCode_str: TWideStringField;
    qryProductPackproductPackSize_ID: TGuidField;
    qryPrepackingItemsQtyUsed_dbl: TFloatField;
    qryPrepackingItemsSourcePortion_dbl: TFloatField;
    qryPrepackingItemsRemainingSKUCalc_dbl: TFloatField;
    qryPrepackingItemsRemainingSKUActual_dbl: TFloatField;
    tmpItemsQtyUsed_dbl: TFloatField;
    tmpItemsRemainingSKUCalc_dbl: TFloatField;
    tmpItemsRemainingSKUActual_dbl: TFloatField;
    tmpItemsSourcePortion_dbl: TFloatField;
    qryPrepackingWorkerCalcYield_int: TIntegerField;
    qryPrepackingWorkerExpectedUnits_int: TIntegerField;
    qryPrepackingWorkerCharges_mon: TBCDField;
    qryPrepackingWorkerResultCost_mon: TBCDField;
    qryItemPrices: TADOQuery;
    qryItemPricesProductCode_ID: TIntegerField;
    qryItemPricesPackCost_mon: TBCDField;
    qryItemPricesSourcePortion_dbl: TFloatField;
    qryReportMain: TADOStoredProc;
    dsqryReportMain: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppReportMain: TppReport;
    ppParameterList1: TppParameterList;
    atnPrintMainReport: TAction;
    stpStockDemanderMoveStock: TADOStoredProc;
    qryProductBatchProductBatch_ID: TAutoIncField;
    qryProductBatchProductCode_ID: TIntegerField;
    qryProductBatchSupplier_ID: TIntegerField;
    qryProductBatchPrice_mon: TBCDField;
    qryProductBatchContractBrandName_str: TWideStringField;
    qryProductBatchSupplierCode_str: TWideStringField;
    qryProductBatchBatchNumber_str: TWideStringField;
    qryProductBatchBarCode_str: TWideStringField;
    qryProductBatchExpiry_dat: TDateTimeField;
    qryProductBatchQtyOnHand_int: TIntegerField;
    qryProductBatchQtyReceived_int: TIntegerField;
    qryProductBatchQtyOnHold_int: TIntegerField;
    qryProductBatchBin_str: TWideStringField;
    qryProductBatchReceived_dat: TDateTimeField;
    qryProductBatchLastLeadTime_int: TIntegerField;
    qryProductBatchRemarks_mem: TMemoField;
    qryProductBatchLastUpdate_dat: TDateTimeField;
    qryProductBatchShippingPack_int: TIntegerField;
    qryProductBatchQty: TADOQuery;
    AutoIncField1: TAutoIncField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    BCDField1: TBCDField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    DateTimeField1: TDateTimeField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    WideStringField5: TWideStringField;
    DateTimeField2: TDateTimeField;
    IntegerField6: TIntegerField;
    MemoField1: TMemoField;
    DateTimeField3: TDateTimeField;
    IntegerField7: TIntegerField;
    qryProductBatchDescription_str: TStringField;
    stp_TotalsCountOfPrepackingItem_ID: TIntegerField;
    stp_TotalsSumOfExtendedCost_mon: TBCDField;
    stp_TotalsAddCosts: TFloatField;
    qryItemPricesQtyUsed_dbl: TFloatField;
    qryIsRecordLocked: TADOQuery;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppDBText4: TppDBText;
    ppDBText12: TppDBText;
    ppLine3: TppLine;
    ppLabel6: TppLabel;
    ppDBText13: TppDBText;
    ppLabel7: TppLabel;
    ppDBText14: TppDBText;
    ppLabel8: TppLabel;
    ppDBText15: TppDBText;
    ppLabel9: TppLabel;
    ppDBText16: TppDBText;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel3: TppLabel;
    ppLabel16: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBCalc1: TppDBCalc;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    myDBCheckBox1: TmyDBCheckBox;
    ppFooterBand1: TppFooterBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLine2: TppLine;
    ppLabel20: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppDBText7: TppDBText;
    tblProductsNSN_str: TWideStringField;
    tblProductsECN_str: TWideStringField;
    tblProductsProductCode_str: TWideStringField;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppDBText3: TppDBText;
    ppDBText18: TppDBText;
    atnPrintReport: TAction;
    qryFindMainIngredient: TADOQuery;
    ppLabel29: TppLabel;
    ppSystemVariable5: TppSystemVariable;
    ppSystemVariable6: TppSystemVariable;
    ppReportLabels: TppReport;
    ppDBPipeline2: TppDBPipeline;
    ppParameterList2: TppParameterList;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppDBText17: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    atnPrintLabels: TAction;
    ppDesigner1: TppDesigner;
    atnEditLabel: TAction;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    procedure atnSaveCloseExecute(Sender: TObject);
    procedure atnAddSingleItemExecute(Sender: TObject);
    procedure qryPrepackingItemsBeforePost(DataSet: TDataSet);
    procedure atnDeleteItemExecute(Sender: TObject);
    procedure atnSelectBatchExecute(Sender: TObject);
    procedure qryPrepackingWorkerAfterScroll(DataSet: TDataSet);
    procedure qryPrepackingAfterScroll(DataSet: TDataSet);
    procedure qryPrepackingWorkerProductCode_IDChange(Sender: TField);
    procedure atnPrePostandCloseExecute(Sender: TObject);
    procedure tmpItemsAfterPost(DataSet: TDataSet);
    procedure tmpItemsBeforePost(DataSet: TDataSet);
    procedure tmpItemsAfterScroll(DataSet: TDataSet);
    procedure atnPostandCloseExecute(Sender: TObject);
    procedure atnDeleteAllItemsExecute(Sender: TObject);
    procedure qryPrepackingWorkerExpectedYield_intChange(Sender: TField);
    procedure qryPrepackingWorkerBeforePost(DataSet: TDataSet);
    procedure atnPrintMainReportExecute(Sender: TObject);
    procedure qryPrepackingWorkerCharges_monChange(Sender: TField);
    procedure qryPrepackingItemsAfterPost(DataSet: TDataSet);
    function IsRecordLocked: Boolean;
    procedure atnPrintReportExecute(Sender: TObject);
    procedure qryPrepackingWorkerFinalYield_intChange(Sender: TField);
    procedure atnPrintLabelsExecute(Sender: TObject);
    procedure atnEditLabelExecute(Sender: TObject);
    
  private
    { Private declarations }
    vCurrentRecord: integer;
    CustomReportPATH: string;
    procedure LoadPrepackingTotals;
    procedure UpdatePrepackingSubTotals;
    procedure AddPrepackingItem(pReqID, pProductID: double);
    procedure AddEditHistory(const pType, pStr :string; pAddType: integer );

    procedure AddBatchItemsToList(pReqID, pProductID  :double; pBatchID:integer);
    procedure LoadBatches;
    function BatchExists(ReqID: integer; BatchID: integer): Boolean;
    procedure LoadTmpTable;
    procedure UpdateProductBatch(item_id: double; bin_str: string; batchnumber_str: string;
  expiry: TDateTime; qtyrec: integer; price_mon: Double; shippingPack: integer);
//  procedure StockItemTransfer(prmDemander: string; prmSKU: Double;
//    prmReason: string; prmPackQty : Double; vProductStringID: string; vexpiry: TDateTime; vBatchNumber: string; vRef: string);
    function FindMainIngredient: Integer;
    procedure LoadCustomReports;


  public
    { Public declarations }
    FUserName : string;
    FUserID : Variant;
    FUsesBatchManagement : Boolean;
    CheckComplete, atnEnabled, lockedByUser, AddNewRecord: Boolean;
    procedure DataConnect(startDate : TDateTime; endDate :TDateTime);
    procedure CloseAllTables;
    procedure LoadItems;
    procedure LoadUsers;
    procedure LoadDemanders;
    procedure LoadEditHistory;
    procedure LoadProductItems;

    procedure RefreshPrepackingList;

    procedure AddPrepacking;
    procedure EditPrepacking;

    function ValidatePosting: Boolean;
    function ValidatePrePosting: Boolean;
    function PrePostRecord: Boolean;
    function PostRecord : Boolean;
    function TotalOnHoldBatch: integer;

    procedure SetActionsDisplay;
    function IsGenericSameAsResult: Boolean; Overload;
    function IsGenericSameAsResult(vProductCode: integer): Boolean; Overload;
    function IsLockedBySameUser: Boolean;
    function PackSizeofItem(Product: integer): integer;
    function CalculateCalcYield: Double;
    function NewSumPrice: Double;
    procedure PrintReportMain;
    procedure UnLockRecord;
    procedure UnLockRecordMain;
    procedure CheckFinalYield;
    procedure PrintLabels;
    procedure EditCustomLabels(vReport: TppReport);

  end;

var
  PrepackingDM: TPrepackingDM;

implementation

uses MainUDM, RxSolutionUFrm, RxSolutionSecurityClass, ProductGeneralUFrm,
  PrepackingItemsUFrm, RepackBatchSelectUFrm;

{$R *.dfm}

function UpdateLastDayMon(MyDate : TDate): TDate;
begin
 result := EncodeDate(YearOf(Mydate),MonthOf(MyDate), DaysInMonth(MyDate));
end;

procedure TPrepackingDM.DataConnect(startDate : TDateTime; endDate :TDateTime);
var
 FDataBasePath       : string;
begin

if Assigned(MainDM) then
 begin
 adoPrepacking.ConnectionString := MainDM.ADOMainDBConnection.ConnectionString;

 with qryPrepacking do
  begin
  Close;
  Prepared := False;
  Parameters.ParamByName('StartDate').Value     := startDate;
  Parameters.ParamByName('EndDate').Value       := endDate+1;
  Prepared := True;
  Open;
  end;

 vCurrentRecord := qryPrepacking.FieldByName('Prepacking_ID').AsInteger;

 FUserName      := RxSolutionFrm.Security.User.LastName.ToString + ', ' +
                RxSolutionFrm.Security.User.FirstName.ToString;
 FUserID        := RxSolutionFrm.Security.User.UserNumID.Value;
 FUsesBatchManagement := MainDm.tblMainSystem.FieldByName('batchManagement_bol').AsBoolean;

 end;
 
end;

procedure TPrepackingDM.CloseAllTables;
begin
 with qryPrepackingWorker do
  Close;

 with qryPrepackingItems do
  Close;

 with qryItemEditHisory do
  Close;                                                                                             

 with tblDemanders do
  close;

 with tblSystemUsers do
  Close;

 with tblProducts do
  Close;
end;

procedure TPrepackingDm.LoadItems;
begin
 with qryPrepackingItems do
  begin
  Close;
  Parameters.ParamByName('Prepacking_ID').Value := vCurrentRecord;
  Open;
  end; 
end;

procedure TPrepackingDM.LoadUsers;
begin

 with tblSystemUsers do
  begin
  Close;
  Open;
  end;
end;

procedure TPrepackingDM.LoadDemanders;
begin

 with tblDemanders do
  begin
  Close;
  Open;
  end;
end;

procedure TPrepackingDM.LoadEditHistory;
begin

 with qryItemEditHisory do
  begin
  Close;
  Open;
  end;
end;

procedure TPrepackingDM.LoadProductItems;
begin
 with tblProducts do
  begin
  Close;
  Open;
  end;
end;


procedure TPrepackingDM.LoadPrepackingTotals;
begin

 if qryPrepackingWorker.Active then
  with stp_Totals do
   begin
   Close;
   Parameters.ParamByName('@PrepackingID').Value := vCurrentRecord;
   Open;
   end;
end;

procedure TPrepackingDM.UpdatePrepackingSubTotals;
begin
 with qryPrepackingWorker do
  begin
  if not (State in [dsEdit, dsInsert]) then Edit;
  FieldByName('ItemsNo_int').AsInteger           := stp_Totals.FieldByName('CountOfPrepackingItem_ID').AsInteger;
  FieldByName('TotalCost_mon').AsCurrency        := stp_Totals.FieldByName('SumOfExtendedCost_mon').AsCurrency;
  FieldByName('ResultCost_mon').AsFloat          := NewSumPrice();
  //Post;
  end;
end;


procedure TPrepackingDM.atnSaveCloseExecute(Sender: TObject);
begin
//if not lockedByUser then
 if (not qryPrepackingWorker.FieldByName('Posted_bol').AsBoolean) and (IsLockedBySameUser) then
 begin
 LoadPrepackingTotals;
 UpdatePrepackingSubTotals;
 with qryPrepackingWorker do
  begin
  if not (State in [dsEdit, dsInsert]) then
    Edit;
  FieldByName('LastEditedBy_str').AsString      := FUserName;
  FieldByName('LastEditedBy_ID').AsInteger      := FUserID;
  FieldByName('LastUpdate_dat').AsDateTime      := Now;
  FieldByName('CheckedOut_bol').AsBoolean       := False;
  FieldByName('CheckedOutName_str').AsString    := '';
  FieldByName('CheckedOutBy_ID').AsInteger      := 0;
//  FieldByName('CheckedOut_dat').AsDateTime      := NullDate;
  Post;
  end;
 end;

 CloseAllTables;
 PrepackingItemsFrm.Close;
 RefreshPrepackingList;
end;

//RELOAD PREPACKING LIST
procedure TPrepackingDM.RefreshPrepackingList;
begin
//
 with qryPrepacking do
  begin
  Close;
  Open;
  Locate('Prepacking_ID', vCurrentRecord, []); 
  end;
end;

//ADD AND EDIT PREPACKING TRANSACTION
procedure TPrepackingDM.AddPrepacking;
var
 vFetchSuccess : boolean;             
begin

 qryPrepacking.Append;
 qryPrepacking.FieldByName('PrepackingRefNo_str').AsString   := MainDm.GetNextVoucherNumber(vFetchSuccess, 1, MODULE_PREPACKING);
 qryPrepacking.FieldByName('CheckedOut_bol').AsBoolean       := True;
 qryPrepacking.FieldByName('CheckedOutName_str').AsString    := FUserName;
 qryPrepacking.FieldByName('CheckedOut_dat').AsDateTime      := Now;
 qryPrepacking.FieldByName('CheckedOutBy_ID').AsInteger      := FUserID;
 qryPrepacking.FieldByName('SystemStore_ID').Value           := MainDm.tblMainSystem.fieldByName('SystemStore_ID').AsInteger;
 qryPrepacking.FieldByName('ResultCost_mon').AsInteger       := 0;
 qryPrepacking.FieldByName('Charges_mon').AsInteger          := 0;

 qryPrepacking.Post;
 vCurrentRecord := qryPrepacking.FieldByName('Prepacking_ID').AsInteger;
 EditPrepacking;

end;

procedure TPrepackingDM.AddPrepackingItem(pReqID, pProductID: double);
begin
//Send data to stored procedure to add new item to current item list
 with AdoAddSingleItem do
  begin
 // Prepared := False;
  Parameters.ParamByName('@PrepackingID').Value := pReqID;
  Parameters.ParamByName('@ProductCodeID').Value:= pProductID;
  Execute;
  end;
end;

procedure TPrepackingDM.atnAddSingleItemExecute(Sender: TObject);
var
  vProductSelector  : TProductSelector;
  vRetID            : integer;
  vProductID        : cIDArray;
  vProductCost      : cCostArray;
  i                 : integer;
begin
// Use same table as curently being edited
// Get current ID's for Req items
with qryPrepackingWorker do
 vRetID := FieldByName('Prepacking_ID').AsInteger;

 vProductSelector := TProductSelector.Create;
 with qryPrepackingItems, vProductSelector do
  if Active then
   try
   if Product_SelectItems( vProductCost, vProductID) then
    for i := low(vProductID) to high(vProductID) do
     try
     if not Locate('ProductCode_ID;Prepacking_ID', VarArrayOf([vProductID[i], vRetID]), []) then
      begin
      AddPrepackingItem(vCurrentRecord, vProductID[i]);
      end;

    with qryPrepackingItems do
     begin
     Close;
     Open;
     end;

     LoadPrepackingTotals;              //Refresh totals
     UpdatePrepackingSubTotals;         //Update header totals
     AddEditHistory(HST_ADD, 'Adding product(s)', ADD_RET);
     //Added by SM; move cursor to last added item
     Locate('ProductCode_ID;Prepacking_ID', VarArrayOf([vProductID[i], vRetID]), []);
     except
     end;
   finally
    Free;
    end;
end;

//OPEN AND EDIT THE PREPACKING TRANSACTION
procedure TPrepackingDM.EditPrepacking;
begin
//
 with qryPrepackingWorker do
 begin
 Close;
 Parameters.ParamByName('prepacking_ID').Value := vCurrentRecord;
 Open;
 if not (FieldByName('CheckedOut_bol').AsBoolean or FieldByName('Posted_bol').AsBoolean) then
  begin
  Edit;
  FieldByName('CheckedOut_bol').AsBoolean       := True;
  FieldByName('CheckedOutName_str').AsString    := FUserName;
  FieldByName('CheckedOut_dat').AsDateTime      := Now;
  FieldByName('CheckedOutBy_ID').AsInteger      := FUserID;
  FieldByName('SystemStore_ID').Value           := MainDm.tblMainSystem.fieldByName('SystemStore_ID').AsInteger;
  Post;
  end;
 end;

 LoadItems;
 LoadEditHistory;
 LoadUsers;
 LoadDemanders;
 LoadProductItems;

 //Load Custom Reports if available
 LoadCustomReports;

end;


procedure TPrepackingDM.qryPrepackingItemsBeforePost(DataSet: TDataSet);
var
 vsStatus, vsProduct, vsIss, vsOrd,  vsDescription, s :string;
 vUsed: Integer;
 vsProductID: integer;
 
begin

 with qryPrepackingItems do
  begin

  if (FieldByName('QtyUsed_dbl').AsInteger > FieldByName('Available').AsInteger) AND (not FieldByName('NotFromBulk_bol').AsBoolean) then
   begin
   MessageDlg('You cannot issue more then available stock', mtWarning, [mbOk], 0);
   Abort;
   end;

  if FieldByName('QtyUsed_dbl').AsInteger > 0 then

  // MC old Calculation - changed 17/09/2010

  (* FieldByName('RemainingSKUCalc_dbl').AsInteger :=  (PackSizeofItem(FieldByName('ProductCode_ID').AsInteger) * (FieldByName('QtyUsed_dbl').AsInteger))
    - ((qryPrepackingWorker.FieldByName('ExpectedYield_int').asinteger) * PackSizeofItem(qryPrepackingWorker.FieldByName('ProductCode_ID').asinteger));    *)

    //If remainder is < 0 then make it 0
  
  (*  if  FieldByName('RemainingSKUCalc_dbl').AsInteger < 0 then
    FieldByName('RemainingSKUCalc_dbl').AsInteger := 0;  *)

    //MC Bug 103 - New calculation - Ernst Confirmed this calculation   16/09/2010

   FieldByName('RemainingSKUCalc_dbl').AsInteger := Abs(((qryPrepackingWorker.FieldByName('ExpectedYield_int').asinteger) * (FieldByName('SourcePortion_dbl').asinteger)) - (PackSizeofItem(FieldByName('ProductCode_ID').AsInteger) * (FieldByName('QtyUsed_dbl').AsInteger)));

  //Force user to select the batch
  //Bug Issue 2443 SM
  //Bug Issue 2444 SM Updated and removed Check on batch management mode
  if {(FUsesBatchManagement) AND} (FieldByName('ProductBatch_ID').Value = NULL) AND (FieldByName('QtyUsed_dbl').AsInteger > 0) AND (not FieldByName('NotFromBulk_bol').AsBoolean) then
   begin
   MessageDlg('Batch has not been selected. Please select one for use.',mtWarning, [mbOK],0);
   FieldByName('QtyUsed_dbl').AsInteger := 0;
   Abort;
   end;

  //************* Force user to capture Source Portion (SKU/Pack)
  //************* SM - 11/07/2012
  //************* SM 05 Feb 2015
  //************* Updated the system to accept fractions
  if ((FieldByName('QtyUsed_dbl').AsInteger > 0) AND (not (FieldByName('SourcePortion_dbl').AsFloat > 0))) then
   begin
   MessageDlg('Please enter a valid "SKU/Pack"', mtWarning, [mbOk], 0);
   Abort;
   end;

  //*********** EDIT HISTORY
  vsProductID   := FieldByName('ProductCode_ID').Asinteger;
  vUsed         := FieldByName('QtyUsed_dbl').AsInteger;
  vsStatus      := HST_EDT;
  vsProduct     := FieldByName('Description_str').AsString;
  vsIss         := 'Use ('+ IntToStr(vUsed) + ')';
  vsDescription := '';
  s             := ': ';

  FieldByName('ExtendedCost_mon').AsFloat := FieldByName('QtyUsed_dbl').AsInteger * FieldByName('PackCost_mon').AsFloat;
  if FieldByName('QtyUsed_dbl').OldValue <> FieldByName('QtyUsed_dbl').NewValue then
   AddEditHistory(vsStatus, vsProduct + s + vsIss + s + vsDescription, ADD_ITEM);        
  end;
end;

procedure TPrepackingDM.atnDeleteItemExecute(Sender: TObject);
var
 itemDescrip : string;
begin
 with qryPrepackingItems do
  begin
  if recordCount > 0 then
   if MessageDlg('Are you sure you want to remove the item from the list?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
    itemDescrip := FieldByName('Description_str').AsString;
    AddEditHistory(HST_DEL, 'Item '+ itemDescrip + ' removed from prepacking items', ADD_ITEM);
    Delete;
    end;
  end;
 LoadPrepackingTotals;
 UpdatePrepackingSubTotals;
end;

//Add any changes to the history table
procedure TPrepackingDM.AddEditHistory(const pType, pStr :string; pAddType: integer );
var
  vRetID, vRetItemID  :double;
begin
  vRetID      := 0;
  vRetItemID  := 0;
 // Get current ID's for Return items
  vRetID := vCurrentRecord;

  with qryPrepackingItems do
    if Active then
      if RecordCount > 0 then
        vRetItemID := FieldByName('PrepackingItem_ID').AsFloat;

  //Open the correct history records
  LoadEditHistory;
  with qryItemEditHisory do
  begin
  //Add new edit history entry
  Append;
  FieldByname('Prepacking_ID').AsFloat    := vRetID;
  FieldByName('Description_str').AsString := pStr;
  FieldByName('UserName_str').AsString    := FUserName;
  FieldByName('User_ID').AsFloat          := FUserID;
  FieldByName('Date_dat').AsDateTime      := Now;
  FieldByName('Type_str').AsString        := pType;
  FieldByName('PrepackingItem_ID').AsFloat          := vRetItemID;
  case pAddType of
   ADD_ITEM :
    begin
    FieldByName('ProductCode_ID').AsFloat   := qryPrepackingItems.FieldByName('Productcode_ID').AsFloat;
    end;
   ADD_RET :
    begin
    FieldByName('ProductCode_ID').AsFloat   := 0;
    end;
   end;

  Post;
  Close;
  Open;
  end;              
end;

procedure TPrepackingDM.LoadBatches;
var
 vProductBatchID, vItemID, vReqID, vReqItemID : integer;
 vcount         : integer;
 vBatchNumber   : string;
 vExpiry        : TDateTime;
 vPrice         : Currency;
 vQtyOrdered    : integer;
 vBatchExist    : boolean;
 vDescription : string;
begin
 //
 vReqID         := qryPrepackingItems.FieldByName('Prepacking_ID').Value;
 vReqItemID     := qryPrepackingItems.FieldByName('PrepackingItem_ID').Value;
 //vQtyOrdered    := qryPrepackingItems.FieldByName('QtyOrdered_int').Value;
 vcount         := 0;

 with qryProductBatch do
  begin
  //
  Close;
  Parameters.ParamByName('ProductCode_ID').Value := qryPrepackingItems.FieldByName('ProductCode_ID').Value;
  Open;
  First;


  While not Eof do
   begin
   vProductBatchID      := fieldByName('ProductBatch_ID').Value;
   vItemID              := fieldByName('ProductCode_ID').Value;
   vBatchNumber         := fieldByName('BatchNumber_str').AsString;
   vExpiry              := fieldByName('Expiry_dat').AsDateTime;
   vPrice               := fieldByName('Price_mon').AsCurrency;
   vDescription          := fieldByName('Description_str').AsString;
   vBatchExist := BatchExists(vReqID, vProductBatchID);

   if (vcount = 0) and (not vBatchExist) and (qryPrepackingItems.FieldByName('ProductBatch_ID').IsNull) then
    begin
    if not (qryPrepackingItems.State in [dsEdit]) then
     qryPrepackingItems.Edit;
    qryPrepackingItems.FieldByName('ProductBatch_ID').AsInteger := vProductBatchID;
    qryPrepackingItems.FieldByName('PackCost_mon').AsCurrency   := vPrice;
    qryPrepackingItems.FieldByName('Description_str').Asstring  := vDescription;
    if FUsesBatchManagement then
     begin
     qryPrepackingItems.FieldByName('Expiry_dat').AsDateTime    := vExpiry;
     qryPrepackingItems.FieldByName('BatchNumber_str').AsString := vBatchNumber;
     end;
     qryPrepackingItems.Post;
    end   
    else if (not vBatchExist) then
     AddBatchItemsToList(vReqID,vItemID, vProductBatchID);

   vcount := vcount + 1;
   Next;
   end;
  end;

end;

function TPrepackingDM.BatchExists(ReqID: integer; BatchID: integer): Boolean;
begin
 with qryFindBatch do
  begin
  Close;
  Parameters.ParamByName('PrepackingID').Value          := ReqID;
  Parameters.ParamByName('ProductBatchID').Value        := BatchID;
  Open;

  if FieldByName('Result').asinteger = 1 then
   Result := True
  else
   Result := False;
  end;
end;

procedure TPrepackingDM.AddBatchItemsToList(pReqID, pProductID: double; pBatchID :integer);

begin
//Use a stored Procedure to add all batches related to that Product
//Check that the original is kept
with stp_ADDProductBatches do
  begin
  Prepared := False;
  Parameters.ParamByName('@PrepackingID').Value        := pReqID;
  Parameters.ParamByName('@ProductCodeID').Value       := pProductID;
  Parameters.ParamByName('@BatchID').Value             := pBatchID;
  Execute;
  end;
end;

procedure TPrepackingDM.LoadTmpTable;
begin
 with tmpItems do
  begin
  Close;
  Parameters.ParamByName('PrepackingID').Value  := vCurrentRecord;
  Parameters.ParamByName('ProductCodeID').Value := qryPrepackingItems.FieldByName('ProductCode_ID').AsInteger;
  Open;
  end;
end;



procedure TPrepackingDM.atnSelectBatchExecute(Sender: TObject);
var
 vProductID: integer;
begin




 with qryPrepackingItems do
  begin
  
  //Cancel Operation if product list is empty
  if (RecordCount < 1) then Abort;
  
  vProductID    := FieldByName('ProductCode_ID').Value;

  if State in [dsEdit, dsInsert] then
   Post;
 //************* Force user to capture Source Portion (SKU/Pack)
 //************* SM - 11/07/2012
  if (FieldByName('SourcePortion_dbl').AsFloat < 1) then
   begin
   MessageDlg('Please enter a valid "SKU/Pack"', mtWarning, [mbOk], 0);
   Abort;
   end;

  end;


  //Check there is any stock to issue from
  if (qryPrepackingItems.FieldByName('QtyOnHand_int').AsInteger > 0) then
   begin
   LoadBatches;
   LoadTmpTable;
   RepackBatchSelectFrm.ShowModal;
  //Refresh and find last item added
   qryPrepackingItems.Close;
   qryPrepackingItems.Open;
   qryPrepackingItems.Locate('ProductCode_ID', vProductID, []);
   end
  else
   MessageDlg('This product does not have stock', mtInformation, [mbOk], 0);

end;

procedure TPrepackingDM.qryPrepackingWorkerAfterScroll(DataSet: TDataSet);
begin
 vCurrentRecord := qryPrepackingWorker.FieldByName('Prepacking_ID').AsInteger;
end;

procedure TPrepackingDM.qryPrepackingAfterScroll(DataSet: TDataSet);
begin
 vCurrentRecord := qryPrepacking.FieldByName('Prepacking_ID').AsInteger;
end;

procedure TPrepackingDM.qryPrepackingWorkerProductCode_IDChange(
  Sender: TField);
begin
 //Update Pack Size if Result ITem has been changed
 with qryPrepackingWorker do
  begin
  FieldByName('ICN_str').AsString := tblProducts.FieldByName('ICN_str').AsString;
  FieldByName('ResultantItem_str').AsString := tblProducts.FieldByName('Description_str').AsString;

  if tblProducts.FieldByName('PackSizeValue_dbl').AsInteger > 0 then
   FieldByName('ResultPackSize_int').AsInteger := tblProducts.FieldByName('PackSizeValue_dbl').AsInteger
  else
   FieldByName('ResultPackSize_int').AsInteger := 1;

  if FieldByName('ExpectedYield_int').AsInteger > 0 then
   FieldByName('ExpectedUnits_int').AsInteger := FieldByName('ResultPackSize_int').Asinteger * FieldByName('ExpectedYield_int').AsInteger;

   AddEditHistory(HST_CHG, 'Result product changed', ADD_ITEM);
  end;
end;

procedure TPrepackingDM.atnPrePostandCloseExecute(Sender: TObject);
var
 WMS : string;
begin
 WMS := 'WARNING' + #13 +'Once you PrePost this record, it can no longer be edited.' + #13 + #13 + 'Continue and PrePost?';
//Current document
if qryPrepackingItems.State in [dsEdit, dsInsert] then
 qryPrepackingItems.Post;

if MessageDlg(WMS, mtWarning, [mbYes, mbNo], 0) = mrYes then
 if ValidatePrePosting then
  if PrePostRecord then
   begin
   if not (qryPrepackingWorker.State in [dsEdit, dsInsert]) then qryPrepackingWorker.Edit;
   qryPrepackingWorker.FieldByName('CheckedOut_bol').AsBoolean           := False;
   qryPrepackingWorker.FieldByName('CheckedoutName_str').AsString        := '';
   qryPrepackingWorker.FieldByName('CheckedOutBy_ID').AsString           := '';
   qryPrepackingWorker.FieldByName('Preposted_bol').AsBoolean            := True;
   qryPrepackingWorker.FieldByName('Preposted_dat').AsDateTime           := Now();
   qryPrepackingWorker.Post;

   MessageDlg('Prepacking has been pre-posted!', mtInformation, [mbYes], 0);
   RefreshPrepackingList;
   PrepackingItemsFrm.Close;
   end;
end;

function TPrepackingDM.ValidatePosting: Boolean;
const
  EMSG = 'You may not post this record unless all of the following are completed!' +
          #13 + 'Result Product/Item' +
          #13 + 'Packed By && Date' +
          #13 + 'Checked By && Date' +
          #13 + 'Required Yield'+
          #13 + 'Actual Yield' +
          #13 + 'Selling Date';
begin
  Result := True;

  if qryPrepackingWorker.Active then
   begin
   with qryPrepackingWorker do
    begin
    if FieldByName('ProductCode_ID').IsNull then Result := False;
    if (FieldByName('PackedBy_str').IsNull) or (FieldByName('PackedBy_str').AsString = '') then Result := False;
    if FieldByName('Packed_dat').IsNull then Result := False;
    if (FieldByName('CheckedBy_str').IsNull) or (FieldByName('CheckedBy_str').AsString = '') then Result := False;
    if FieldByName('Checked_dat').IsNull then Result := False;
    if (FieldByName('ExpectedYield_int').IsNull) then Result := False;
    if (FieldByName('FinalYield_int').IsNull) or (FieldByName('FinalYield_int').AsInteger = 0) or (FieldByName('FinalYield_int').AsString = '') then Result := False;
    if FieldByName('ResultExpiry_dat').IsNull then Result := False;
    end;

   if not Result then
    MessageDlg(EMSG, mtWarning, [mbOK],0);
   end
  else
   Result := False;
end;

function TPrepackingDM.ValidatePrePosting: Boolean;
const
  EMSG = 'You may not post this record unless all of the following are completed!' +
          #13 + 'Required Yield';

begin
  Result := True;

  if qryPrepackingWorker.Active then
   begin
   with qryPrepackingWorker do
    begin
    if FieldByName('ProductCode_ID').IsNull then Result := False;
    //mc 08 sep 2010
    //if (FieldByName('FinalYield_int').IsNull) or (FieldByName('FinalYield_int').AsInteger = 0) or (FieldByName('FinalYield_int').AsString = '') then Result := False;
    if (FieldByName('ExpectedYield_int').IsNull) or (FieldByName('ExpectedYield_int').AsInteger = 0) or (FieldByName('ExpectedYield_int').AsString = '') then Result := False;
    end;

   if not Result then
    MessageDlg(EMSG, mtWarning, [mbOK],0);
   end
  else
   Result := False;
end;

//UPDATES THE STOCK QTY OF PREPACKING ITEMS
//SETS THE PREPACKING TRANSACTION TO PREPOSTED
function TPrepackingDM.PrePostRecord: Boolean;
var
  vProductBatchID : double;
  vProductID  :double;
  vProdDet    :RProductDetails;
  vType       :String;
  vNewQty     :integer;
  vOldQty     :integer;
  vTotalinStock : integer;
  vCost       :Currency;
  vExpiryDate :TDateTime;
  vDate       :TDateTime;
  vReason     :String;
  vAdjQty     :integer;
  vQtyUsed    :integer;
  vBatchQty   :integer;
  vBatchNumber : string;
  vShippingPack : integer;
  vPackCost  : double;
  prvPack    : integer;
  vBin          : string;

  Attempts        :Integer;
  SubmitVariance  :Boolean;
  vAuditData      :RProductAuditDetails;
  S :string;
  Save_Cursor:TCursor;
begin
// Save_Cursor := Screen.Cursor;
// Screen.Cursor := crHourGlass;
 try
 with qryPrepackingItems do
  begin
  First;
  While (not eof)  do
   begin
   if (FieldByName('QtyUsed_dbl').AsInteger > 0) and (not FieldByName('NotFromBulk_bol').AsBoolean) then
    begin
    vProductID   := FieldByName('ProductCode_ID').AsInteger;
    vProductBatchID := FieldByName('ProductBatch_ID').AsInteger;
    vBin        := FieldByName('Bin_str').AsString;

    vPackCost   := FieldByName('PackCost_mon').AsFloat;
    vCost       := FieldByName('PackCost_mon').AsCurrency * FieldByName('QtyUsed_dbl').AsInteger;
    vExpiryDate := FieldByName('Expiry_dat').AsDateTime;
    vBatchNumber:= FieldByName('BatchNumber_str').AsString;
    vDate       := Now();
    vQtyUsed    := FieldByName('QtyUsed_dbl').AsInteger;
    vNewQty     := 0;
    vOldQty     := 0;

     qryProductBatchQty.Close;
     qryProductBatchQty.Parameters.ParamByName('ProductCode_ID').Value := vProductID;
     qryProductBatchQty.Open;
     //locate the right batch then edit
     if qryProductBatchQty.Locate('ProductBatch_ID', vProductBatchID, []) then
      begin
      qryProductBatchQty.Edit;
      qryProductBatchQty.FieldByName('QtyOnHand_int').AsInteger := qryProductBatchQty.FieldByName('QtyOnHand_int').AsInteger - vQtyUsed;
      qryProductBatchQty.Post;
      if qryProductBatchQty.FieldByName('QtyOnHand_int').AsInteger < 1 then
       qryProductBatchQty.Delete;
      end;

     //vNewQty
     with qryTotalQtyonHand do
      begin
      Close;
      Parameters.ParamByName('ProductCode_ID').Value := vProductID;
      Open;
      if recordCount > 0 then
       vNewQty := fieldByName('QtyOnHand_int').AsInteger
      else
       vNewQty := 0;
      Close;
      end;

     vAuditData.Quantity_int     := vQtyUsed;  //Enter as a negative transaction in audit trail
     vAuditData.ProductCode_ID   := vProductID;
     vAuditData.Item_ID          := 0; // should be id of variance
     vAuditData.Value_mon        := vCost;
     vAuditData.SystemStore_ID   := MainDm.tblMainSystem.FieldByName('SystemStore_ID').AsInteger; //SM  13/08/2007
     vAuditData.Demander_ID      := 0;
     vAuditData.Supplier_ID      := 0;
     vAuditData.Type_str         := 'I';
     vAuditData.Reference_str    := Trim(qryPrepackingWorker.FieldByName('PrepackingRefNo_str').AsString); //FloatToStr(vProductID) + '_' + DateToStr(Date);
     vAuditData.DemanderSupplier_str := 'V';
     vAuditData.ProductCode_str  := FieldByName('ProductCode_Str').AsString;
     vAuditData.VoucherNo_str    := ' ';
     vAuditData.Date_dat         := Now;
     vAuditData.QuantityOnHand_int := vNewQty;
     vAuditData.User_str         := FUserName;
     vAuditData.NSN_Str          := FieldByName('NSN_str').AsString;
     vAuditData.ECN_str          := FieldByName('ECN_str').AsString;
     vAuditData.ICN_str          := FieldByName('ICN_str').AsString;
     vAuditData.BatchNumber_str  := vBatchNumber;
     vAuditData.ExpiryDate_dat   := vExpiryDate;
     MainDM.WriteAuditData(vAuditData);
     end;     //end of if Returned Qty > 0
     
    qryPrepackingItems.Next;
    end;  //end of While
   end;
  except
   adoPrepacking.RollbackTrans;
  end;
// Screen.Cursor := Save_Cursor;
 LoadPrepackingTotals;
 AddEditHistory(HST_EDT,'Pre-Posted', ADD_RET);
 Result := True;
end;

procedure TPrepackingDM.tmpItemsAfterPost(DataSet: TDataSet);
begin
 if RepackBatchSelectFrm.Active then
  RepackBatchSelectFrm.UpdateTotals;

  with qryPrepackingWorker do
  begin
  if not (State in [DsEdit, dsInsert]) then Edit;
  FieldByName('ResultCost_mon').AsFloat := NewSumPrice();
  end;

end;

procedure TPrepackingDM.tmpItemsBeforePost(DataSet: TDataSet);
var
 vsStatus, vsProduct, vsIss, vsOrd,  vsDescription, s :string;
 vUsed: Integer;
 vsProductID: integer;
 
begin
 with tmpItems do
  begin

  //Check Qty to use against Qty Available
  if (FieldByName('QtyUsed_dbl').AsInteger > RepackBatchSelectFrm.Available) then
   begin
   MessageDlg('You cannot issue more stock then available.', mtWarning, [mbOk], 0);
   FieldByName('QtyUsed_dbl').AsInteger := RepackBatchSelectFrm.Available;
   end;

  //************* Force user to capture Source Portion (SKU/Pack)
  //************* SM - 06 Feb 2013
  if ((FieldByName('QtyUsed_dbl').AsInteger > 0) AND (FieldByName('SourcePortion_dbl').AsFloat < 1)) then
   begin
   MessageDlg('Please enter a valid "SKU/Pack"', mtWarning, [mbOk], 0);
   Abort;
   end;
  {
  //Calc SKU
  if FieldByName('QtyUsed_dbl').AsInteger > 0 then
   if IsGenericSameAsResult then
    FieldByName('RemainingSKUCalc_dbl').AsInteger :=
    (qryPrepackingWorker.FieldByName('ExpectedYield_int').asinteger * PackSizeofItem(qryPrepackingWorker.FieldByName('ProductCode_ID').asinteger)) mod
    (FieldByName('QtyUsed_dbl').AsInteger * PackSizeofItem(FieldByName('ProductCode_ID').AsInteger)) ;//need to calculate if same generic
  }
  if FieldByName('QtyUsed_dbl').AsInteger > 0 then
   FieldByName('RemainingSKUCalc_dbl').AsInteger :=  (PackSizeofItem(FieldByName('ProductCode_ID').AsInteger) * (FieldByName('QtyUsed_dbl').AsInteger))
    - ((qryPrepackingWorker.FieldByName('ExpectedYield_int').asinteger) * PackSizeofItem(qryPrepackingWorker.FieldByName('ProductCode_ID').asinteger));

  //If remainder is < 0 then make it 0
  if  FieldByName('RemainingSKUCalc_dbl').AsInteger < 0 then
    FieldByName('RemainingSKUCalc_dbl').AsInteger := 0;


  //edit history
  vsProductID := FieldByName('ProductCode_ID').Asinteger;
  vUsed := FieldByName('QtyUsed_dbl').AsInteger;
  vsStatus      := HST_EDT;
  vsProduct     :=  FieldByName('Description_str').AsString;
  vsIss         := 'Use ('+ IntToStr(vUsed) + ')';
  vsDescription := '';
  s             := ': ';

  // Check if the generic is the same as Result
  if IsGenericSameAsResult then
   begin
   if not (qryPrepackingWorker.State in [dsEdit, dsInsert]) then qryPrepackingWorker.Edit;
   qryPrepackingWorker.FieldByName('CalcYield_int').AsInteger := FieldByName('QtyUsed_dbl').AsInteger * PackSizeofItem(FieldByName('ProductCode_ID').AsInteger);

   end;

  //qryPrepackingWorker.FieldByName('ResultCost_mon').AsFloat := NewSumPrice();

  FieldByName('ExtendedCost_mon').AsFloat := FieldByName('QtyUsed_dbl').AsInteger * FieldByName('PackCost_mon').AsFloat;
  if FieldByName('QtyUsed_dbl').OldValue <> FieldByName('QtyUsed_dbl').NewValue then
   AddEditHistory(vsStatus, vsProduct + s + vsIss + s + vsDescription, ADD_ITEM);
  end;

end;

procedure TPrepackingDM.tmpItemsAfterScroll(DataSet: TDataSet);
begin
 if RepackBatchSelectFrm.Active then
  RepackBatchSelectFrm.UpdateTotals;
end;

function TPrepackingDM.TotalOnHoldBatch: integer;
begin
//
 with qryBatchOnHoldTotal do
  begin
  Close;
  Parameters.ParamByName('ProductBatch_ID').Value := tmpItemsProductBatch_ID.Value;
  Open;

  if recordCount > 0 then
   Result := FieldByName('SumQtyOrdered_int').AsInteger
  else
   Result := 0;
  end;
end;

procedure TPrepackingDM.SetActionsDisplay;
begin
 //
end;

//THIS FUNCTION CHECK WHETHER PREPACKING ITEM IS THE SAME AS RESULT ITEM
//RETURNS TRUE IF PREPACKING ITEM IS THE SAME AS RESULT ITEM
function TPrepackingDM.IsGenericSameAsResult: Boolean; 
var
 GenericName, ResultGeneric :string;    
begin

 GenericName    := '';
 ResultGeneric  := '';

 with qryGeneric_1 do
  begin
  Close;
  Parameters.ParamByName('ProductCodeID').Value := qryPrepackingItems.FieldByName('ProductCode_ID').AsInteger;
  Open;
  if recordCount > 0 then
   GenericName := Trim(FieldByName('GenericName_str').AsString);
  Close;
  end;
  
 ResultGeneric := Trim(tblProducts.FieldByName('GenericName_str').Asstring);

 if ResultGeneric = GenericName then
  Result := True
 else
  Result := False;
 
end;

//THIS FUNCTION RETURNS THE INTEGER VALUE OF ANY PRODUCT ITEM
function TPrepackingDM.PackSizeofItem(Product: integer): integer;
var
 vPacksize: integer;
begin

 vPacksize := 1;
 with qryGeneric_1 do
  begin
  Close;
  Parameters.ParamByName('ProductCodeID').Value := Product;
  Open;
  if recordCount > 0 then
   vPacksize := FieldByName('PackSizeValue_dbl').AsInteger;
  Close;
  end;

 if vPacksize < 1 then
  begin
  vPacksize := 1;
  MainDm.CorrectProductPackSizes;
  end;

 Result  := vPacksize;
end;

//UPDATE THE STOCK QTY OF THE RESULT/PREPACKING ITEM
procedure TPrepackingDM.UpdateProductBatch(item_id: double; bin_str: string; batchnumber_str: string;
  expiry: TDateTime; qtyrec: integer; price_mon: Double; shippingPack: integer);
begin

with tblProductBatch do
 begin
 Close;
//Open table with all items.
 Open;
//First Items
 First;
//Locate the right one
 if Locate('ProductCode_ID;BatchNumber_Str;bin_str',VarArrayOf([item_id, batchnumber_str, bin_str]), []) then
  begin
  Edit;
  FieldByName('QtyOnHand_int').AsInteger := FieldByName('QtyOnHand_int').AsInteger + qtyrec;
  end
//If not locate then Add to List;
 else
  begin
  Append;
  FieldByName('QtyOnHand_int').AsInteger := qtyrec;
  end;
//Assign values
 FieldByName('Bin_str').ASString                := bin_str;
 FieldByName('BatchNumber_str').AsString        := batchnumber_str;
 FieldByName('Expiry_dat').AsDateTime           := expiry;

 FieldByName('ProductCode_ID').AsFloat          := item_id;
 FieldByName('Price_mon').AsFloat               := price_mon;
 FieldByName('ShippingPack_int').AsInteger      := shippingPack;
 FieldByName('LastUpdate_dat').AsDateTime       := Now;
//Post
 Post;
//Close table
 Close;
 end;//end of with    
end;

//THIS FUNCTION FINALISES THE PREPACKING TRANSACTION.
//SETS THE PREPACKING TRANACTION AS POSTED
//CALLS THE FUNCTION TO UPDATE THE RESULT ITEM STOCK QUANTITY
function TPrepackingDM.PostRecord: Boolean;
var
  vResultProductID, vProductCodeID : double;
  vResultExpiry, vExpiry : TDateTime;
  vResultBatchnumber, vResultICN, vResultECN, vResultNSN, vResultProductCodeStr, vProductCodeStr, vProductStringID, vRef, vBatchNumber : string;
  vResultYield, vNewQty : integer;
  vPackCost, vValueCost : double;
  vAuditData      :RProductAuditDetails;
  vDemander: string;
  vBin, vICN, vECN, vNSN: string;
begin
   try
   if not (qryPrepackingWorker.State in [dsEdit, dsInsert]) then qryPrepackingWorker.Edit;
   qryPrepackingWorker.FieldByName('CheckedOut_bol').AsBoolean           := False;
   qryPrepackingWorker.FieldByName('CheckedoutName_str').AsString        := '';
   qryPrepackingWorker.FieldByName('CheckedOutBy_ID').AsString           := '';
   qryPrepackingWorker.FieldByName('Posted_bol').AsBoolean            := True;
   qryPrepackingWorker.FieldByName('Posted_dat').AsDateTime           := Now();
   qryPrepackingWorker.Post;

  vResultProductID      := qryPrepackingWorker.FieldByName('ProductCode_ID').Asinteger;
  vResultExpiry         := qryPrepackingWorker.FieldByName('ResultExpiry_dat').AsDateTime;
  vDemander             := qryPrepackingWorker.FieldByName('RemainderDemander_str').AsString;
  vRef                  := Trim(qryPrepackingWorker.FieldByName('PrepackingRefNo_str').AsString);
  //IF result batch is empty then use the prepack reference number
  if qryPrepackingWorker.FieldByName('ResultBatchNumber_str').AsString <> '' then
   vResultBatchnumber    := Trim(qryPrepackingWorker.FieldByName('ResultBatchNumber_str').AsString)
  else
   vResultBatchnumber    := Trim(qryPrepackingWorker.FieldByName('PrepackingRefNo_str').AsString);

  vResultYield          := qryPrepackingWorker.FieldByName('FinalYield_int').Asinteger;
  vBin                  := tblProducts.FieldByName('Bin_str').AsString;
  vPackCost             := qryPrepackingWorker.FieldByName('ResultCost_mon').AsCurrency;// * qryPrepackingWorker.FieldByName('ResultPackSize_int').Asinteger;
  vResultICN            := tblProducts.FieldByName('ICN_str').AsString;
  vResultECN            := tblProducts.FieldByName('ECN_str').AsString;
  vResultNSN            := tblProducts.FieldByName('NSN_str').AsString;
  vResultProductCodeStr := tblProducts.FieldByName('ProductCode_str').AsString;
  vValueCost            := qryPrepackingWorker.FieldByName('ResultCost_mon').AsCurrency; //* vResultYield;
  //Now update the Result Item
  UpdateProductBatch(vResultProductID, vBin, vResultBatchnumber, vResultExpiry, vResultYield, vPackCost, 1);
  //vNewQty
  with qryTotalQtyonHand do
      begin
      Close;
      Parameters.ParamByName('ProductCode_ID').Value := vResultProductID;
      Open;
      if recordCount > 0 then
       vNewQty := fieldByName('QtyOnHand_int').AsInteger
      else
       vNewQty := 0;
      Close;
      end;

  (*
    //THIS FEATURE HAS BEEN DISABLED
    //Run through the ingredient items and update remainder stock
  with qryPrepackingITems do
   begin
   First;
   while not eof do
    begin
    if (FieldByName('QtyUsed_dbl').asInteger > 0) AND (FieldByName('RemainingSKUActual_dbl').asInteger > 0) then
     begin
     vProductCodeID     := FieldByName('ProductCode_ID').AsFloat;
     vExpiry            := FieldByName('Expiry_dat').AsDateTime;
     vBatchNumber       := FieldByName('BatchNumber_str').AsString;
     //Fetch Product Details from tblproductPackSize
     qryProductPack.Close;
     qryProductPack.Parameters.ParamByName('ProductCodeID').Value := vProductCodeID;
     qryProductPack.Open;
     vProductCodeStr := qryProductPack.FieldByName('ProductCode_str').AsString;
     vNSN := qryProductPack.FieldByName('NSN_str').AsString;
     vECN := qryProductPack.FieldByName('ECN_str').AsString;
     vICN := qryProductPack.FieldByName('ICN_str').AsString;
     vProductStringID:= qryProductPack.FieldByName('productPackSize_ID').AsString;
     qryProductPack.Close;
     //Transfer the remainder to the Remainder Demander
//THIS FEATURE HAS BEEN DISABLED
//     StockItemTransfer(vDemander, qryPrepackingITems.FieldByName('RemainingSKUActual_dbl').asInteger,'Left over stock', 0, vProductStringID, vExpiry, vBatchnumber, vRef);
     end;
    Next;
    end;
   end;
   *)

   vAuditData.Quantity_int     := vResultYield;
   vAuditData.ProductCode_ID   := vResultProductID;
   vAuditData.Item_ID          := 0; // should be id of variance
   vAuditData.Value_mon        := vValueCost; //vPackCost;
   vAuditData.SystemStore_ID   := MainDm.tblMainSystem.FieldByName('SystemStore_ID').AsInteger;
   vAuditData.Demander_ID      := 0;
   vAuditData.Supplier_ID      := 0;
   vAuditData.Type_str         := 'R';
   vAuditData.Reference_str    := Trim(qryPrepackingWorker.FieldByName('PrepackingRefNo_str').AsString);
   vAuditData.DemanderSupplier_str := 'V';
   vAuditData.ProductCode_str  := vResultProductCodeStr;
   vAuditData.VoucherNo_str    := ' ';
   vAuditData.Date_dat         := Now;
   vAuditData.QuantityOnHand_int := vNewQty;
   vAuditData.User_str         := FUserName;
   vAuditData.NSN_Str          := vResultNSN;
   vAuditData.ECN_str          := vResultECN;
   vAuditData.ICN_str          := vResultICN;
   vAuditData.BatchNumber_str  := vResultBatchnumber;
   vAuditData.ExpiryDate_dat   := vResultExpiry;
   MainDM.WriteAuditData(vAuditData);                      

   Result := True;
  except
  Result := False;
  end;

end;

function TPrepackingDM.IsLockedBySameUser;
begin
 if FUserID = qryPrepackingWorker.FieldByName('CheckedOutBy_ID').AsVariant then
  Result := True
 else
  Result := False;   
end;

procedure TPrepackingDM.atnPostandCloseExecute(Sender: TObject);
var
 WMS : string;
 EMSG : string;
begin
WMS := 'WARNING' + #13 +'Once you post this record, it can no longer be edited.' + #13 + #13 + 'Continue and Post?';
//Current document

if MessageDlg(WMS, mtWarning, [mbYes, mbNo], 0) = mrYes then
 begin
 if ValidatePosting then
  if PostRecord then
   begin
   MessageDlg('Posted', mtInformation, [mbOk], 0);
   RefreshPrepackingList;
   PrepackingItemsFrm.Close;
   end
 else
   MEssageDlg('An error has occured, please try again.', mtError, [mbOk], 0);
 end;
end;

procedure TPrepackingDM.atnDeleteAllItemsExecute(Sender: TObject);
begin

 with stp_DeleteAllItems do
  begin
  Parameters.ParamByName('PrepackingID').Value := vCurrentRecord;
  ExecSQL;
  end;

 AddEditHistory(HST_DEL, 'Deleted all products', ADD_RET);
 LoadItems;
 LoadPrepackingTotals;
 UpdatePrepackingSubTotals;

end;

(*// Procedure No longer needed
procedure TPrepackingDM.StockItemTransfer(prmDemander: string; prmSKU: Double;
    prmReason: string; prmPackQty : Double; vProductStringID: string; vexpiry: TDateTime; vBatchNumber: string; vRef: string);
var
  prvPack : double;
  prvF, prvT  : string;
begin
 try
  with stpStockDemanderMoveStock do
    begin
    prvPack := PackSizeofItem(qryPrepackingItems.FieldByName('ProductCode_ID').AsInteger);
    prvF    := prmDemander;
    Parameters.ParamByName('@ProductID').Value := vProductStringID;
    Parameters.ParamByName('@DemanderFromUniqueID').Value := tblDemanders.FieldByName('DemanderUnique_ID').Value;
    Parameters.ParamByName('@Quantity').Value := Round( prmSKU / prvPack );
    Parameters.ParamByName('@QtyUnits').Value := prmSKU;
    Parameters.ParamByName('@Reference').Value := vRef;
    Parameters.ParamByName('@User').Value := FUserName;
    Parameters.ParamByName('@VoucherNo').Value := 'Remainder Stock';
    Parameters.ParamByName('@expiry').Value := vexpiry;
    Parameters.ParamByName('@batchnumber').Value :=  vBatchNumber;
    ExecProc;
    end;
  except ShowMessage('Error moving stock to Demander');
  end;
end;
*)

procedure TPrepackingDM.qryPrepackingWorkerExpectedYield_intChange(
  Sender: TField);
begin

 with qryPrepackingWorker do
  begin
  FieldByName('ExpectedUnits_int').AsInteger := FieldByName('ResultPackSize_int').Asinteger * FieldByName('ExpectedYield_int').AsInteger;
  end;
  
end;

procedure TPrepackingDM.qryPrepackingWorkerBeforePost(DataSet: TDataSet);
begin
 //
 with qryPrepackingWorker do
  begin
  if not(FieldByName('ResultExpiry_dat').IsNull) then
   FieldByName('ResultExpiry_dat').AsDateTime := UpdateLastDayMon(FieldByName('ResultExpiry_dat').AsDateTime);
  FieldByName('ResultCost_mon').AsFloat := NewSumPrice();

  //Log change in Result Expected Yield 08 July 2015
  if (FieldByName('ExpectedYield_int').OldValue) <> (FieldByName('ExpectedYield_int').NewValue) then
   begin
   AddEditHistory(HST_EDT, 'Result Yield changed from ' + IntTostr(FieldByName('ExpectedYield_int').OldValue) + ' to ' + IntTostr(FieldByName('ExpectedYield_int').NewValue) ,ADD_ITEM);
   end

  end;
  
end;

function TPrepackingDM.CalculateCalcYield: Double;
var
 vYield: Double;
begin

 vYield := 0;
 with qryPrepackingItems do
  begin
  vYield := FieldByName('QtyUsed_dbl').AsInteger * PackSizeofItem(FieldByName('ProductCode_ID').AsInteger);
  end;
 Result := vYield;  
end;

function TPrepackingDM.NewSumPrice: Double;
var
 vFinalPrice, vExtraCharges: Double;
 vSourcePortion: double;
 vCost: currency;
 vPackSize: double;
begin

 vFinalPrice    := 0;
 vExtraCharges  := 0;
 vExtraCharges  := qryPrepackingWorker.fieldByName('AdditionalCost_mon').AsFloat;

 with qryItemPrices do
  begin
  Close;
  Parameters.ParamByName('Prepacking_ID').Value := vCurrentRecord;
  Open;
  First;
  while not Eof do
   begin
   if FieldByName('QtyUsed_dbl').AsInteger > 0 then
    begin
    vSourcePortion      := FieldByName('SourcePortion_dbl').AsFloat;
    vCost               := FieldByname('Packcost_mon').AsFloat;
    vPackSize           := PackSizeofItem(FieldByname('ProductCode_ID').AsInteger);
    if vSourcePortion > 0 then
     vFinalPrice := vFinalPrice + (vCost/vPackSize)*vSourcePortion;
    end;
   Next;
   end;
  Close; 
  end;

 //********** ADD EXTRA CHARGES
 if vExtraCharges > 0 then
  vFinalPrice := vFinalPrice + vExtraCharges;

 Result := vFinalPrice;
 
end;

procedure TPrepackingDM.PrintReportMain;
begin
 with qryPrepackingWorker do
  begin
  if Active then
   begin
   LoadPrepackingTotals;
   UpdatePrepackingSubTotals;
   if State in [dsEdit, dsInsert] then
    Post;
   end;
  end; 

 with qryReportMain do
  begin
  Close;
  Parameters.ParamByName('@PrepackingID').Value := vCurrentRecord;
  Open;

  ppReportMain.Print;
  if ((qryPrepackingWorker.Active) and (qryPrepackingWorker.RecordCount > 0)) then
   AddEditHistory(HST_PRN, 'Report printed by: '+ FUserName, ADD_RET);
  Close;
  end;

end;   

procedure TPrepackingDM.atnPrintMainReportExecute(Sender: TObject);
begin
 PrintReportMain;
end;

procedure TPrepackingDM.qryPrepackingWorkerCharges_monChange(
  Sender: TField);
begin
 with qryPrepackingWorker do
  begin
  if not (State in [DsEdit, dsInsert]) then Edit;
  FieldByName('ResultCost_mon').AsFloat := NewSumPrice();
  end;
end;

procedure TPrepackingDM.qryPrepackingItemsAfterPost(DataSet: TDataSet);
begin
 with qryPrepackingWorker do
  begin
  if not (State in [DsEdit, dsInsert]) then Edit;
  FieldByName('ResultCost_mon').AsFloat := NewSumPrice();
  end;
end;

function TPrepackingDM.IsRecordLocked: Boolean;
begin

 with qryIsRecordLocked do
  begin
  Close;
  Parameters.ParamByName('Prepacking_ID').Value := vCurrentRecord;
  Open;

  if FieldByName('CheckedOut_bol').AsBoolean then
   Result := True
  else
   Result := False;
  end;
end;

procedure TPrepackingDM.UnLockRecord;
begin
 with qryPrepackingWorker do
  begin
  if not (State in [dsEdit, dsInsert]) then
    Edit;
  FieldByName('CheckedOut_bol').AsBoolean       := False;
  FieldByName('CheckedOutName_str').AsString    := '';
  FieldByName('CheckedOutBy_ID').AsInteger      := 0;
  Post;
  end;
end;

procedure TPrepackingDM.UnLockRecordMain;
begin
 with qryPrepacking do
  begin
  if not (State in [dsEdit, dsInsert]) then
    Edit;
  FieldByName('CheckedOut_bol').AsBoolean       := False;
  FieldByName('CheckedOutName_str').AsString    := '';
  FieldByName('CheckedOutBy_ID').AsInteger      := 0;
  Post;
  Refresh;
  end;
end;

procedure TPrepackingDM.atnPrintReportExecute(Sender: TObject);
begin
 PrintReportMain;
end;

procedure TPrepackingDM.qryPrepackingWorkerFinalYield_intChange(
  Sender: TField);
begin
 // check this quantity against the ingredients used
 CheckFinalYield;
end;  

procedure TPrepackingDM.CheckFinalYield;
var
 MSG: string;
 vCalculatedSKU: double;
 vFinalYield: double;
 vPackSizeofIngredient: double;
 vIngredient: integer;
 vFinalSKU : double;
begin
 
 MSG := 'The Actual yield and the calculated quantities from the ingredients are different. Please check the quantities.';

 with qryPrepackingWorker do
  begin
  if (not VarIsNull(FieldByName('ProductCode_ID').Value)) then
   begin
   vCalculatedSKU        := FieldByName('CalcYield_int').AsFloat;
   vFinalYield           := FieldByName('FinalYield_int').AsFloat;

   vFinalSKU := vFinalYield * PackSizeofItem(FieldByname('ProductCode_ID').AsInteger);

   //showmessage('Final: ' + FloatToStr(vFinalSKU) + #13 + 'Calc: '+FloatToStr(vCalculatedSKU));

   vIngredient           := FindMainIngredient;
   vPackSizeofIngredient := PackSizeofItem(vIngredient);

   //******* SM 19 Jan 2015
   //******* Compare calculated SKU from the Result Pack VS the Final Yield X Pack Size of Result.
   //******* Warn the user if these quantities are different.
   if vCalculatedSKU <> (vFinalYield * PackSizeofItem(FieldByname('ProductCode_ID').AsInteger)) then
    MessageDlg(MSG, mtWarning, [mbOk], 0);
   //ShowMessage(FloatToStr( vFinalYield * PackSizeofItem(FieldByname('ProductCode_ID').AsInteger)) + #13 + #13 + FloatToStr(vCalculatedSKU));
   end;
  end;

end;

//THIS FUNCTION CHECK WHETHER PREPACKING ITEM IS THE SAME AS RESULT ITEM
//RETURNS TRUE IF PREPACKING ITEM IS THE SAME AS RESULT ITEM
function TPrepackingDM.IsGenericSameAsResult(vProductCode: integer): Boolean; 
var
 GenericName, ResultGeneric :string;
begin

 GenericName    := '';
 ResultGeneric  := '';

 with qryGeneric_1 do
  begin
  Close;
  Parameters.ParamByName('ProductCodeID').Value := vProductCode;
  Open;
  if recordCount > 0 then
   GenericName := Trim(FieldByName('GenericName_str').AsString);
  Close;
  end;
  
 ResultGeneric := Trim(tblProducts.FieldByName('GenericName_str').Asstring);

 if ResultGeneric = GenericName then
  Result := True
 else
  Result := False;
 
end;

function TPrepackingDM.FindMainIngredient: Integer;
var
 GenericName, ResultGeneric :string;
 vCurrentRecord : integer;
begin

 GenericName    := '';
 ResultGeneric  := '';

 vCurrentRecord := qryPrepackingWorker.FieldByName('Prepacking_ID').AsInteger;

 with qryGeneric_1 do
  begin
  Close;
  Parameters.ParamByName('ProductCodeID').Value := qryPrepackingWorker.FieldByName('ProductCode_ID').AsInteger;
  Open;
  if recordCount > 0 then
   GenericName := Trim(FieldByName('GenericName_str').AsString);
  Close;
  end;

 // showmessage(Genericname);

 with qryFindMainIngredient do
  begin
  Close;
  Parameters.ParamByName('PrepackingID').Value  := vCurrentRecord;
  Parameters.ParamByName('Generic').Value       := GenericName;
  Open;

  if RecordCount > 0 then
   Result := FieldByName('ProductCode_ID').AsInteger
  else
   Result := 0;

  Close;
  end;     

end;

procedure TPrepackingDM.PrintLabels;
begin

 //Print Result Labels
 with qryPrepackingWorker do
  begin
  if Active  then
   begin
   if (State in [dsEdit])  then Post;
   if (not VarIsNull(FieldByName('ProductCode_ID').Value)) then
     begin
    // ppReportLabels.PrinterSetup.Copies := FieldByName('FinalYield_int').AsInteger;
     ppReportLabels.Print;

     AddEditHistory(HST_PRN, 'Label printed', ADD_ITEM);
     end;
   end;
  end;

end;   

procedure TPrepackingDM.atnPrintLabelsExecute(Sender: TObject);
begin
 PrintLabels;
end;

procedure TPrepackingDM.LoadCustomReports;
begin

  CustomReportPATH := Application.GetNamePath(); 
  //Load Path if Label found
  if (FileExists(CustomReportPATH + 'labels\rx_prepacking_label.rtm')) then
     begin
     ppReportLabels.Template.FileName := CustomReportPATH + 'labels\rx_prepacking_label.rtm';
     ppReportLabels.Template.LoadFromFile;
     end;

end;

procedure TPrepackingDM.EditCustomLabels(vReport: TppReport);
begin

 //Reload custom report label for editing
 LoadCustomReports;
 try
  with ppDesigner1 do
   begin
   Report := vReport;
   Show;
   AddEditHistory(HST_LBL, 'Label Updated', ADD_RET);      
   end;
 except
  on E:Exception do MessageDlg(e.Message, mtError, [mbOK], 0);
 end;

end;

procedure TPrepackingDM.atnEditLabelExecute(Sender: TObject);
begin
 EditCustomLabels(ppReportLabels);
end;

end.
