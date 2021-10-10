unit FPL_Transfers;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLTransfer = class
  private
    Felement_in_cost: integer;
    Felement_out: integer;
    Felement_in: integer;
    Ftime: TDateTime;
    Fevent: integer;
    Fentry: integer;
    Felement_out_cost: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property entry:             integer   read Fentry;
    property event:             integer   read Fevent;
    property time:              TDateTime read Ftime;
    property element_out:       integer   read Felement_out;
    property element_out_cost:  integer   read Felement_out_cost;
    property element_in:        integer   read Felement_in;
    property element_in_cost:   integer   read Felement_in_cost;
  end;

  IFPLTransfers = interface
    function build(aSO: ISuperObject):  boolean;
    function getTransfers:     IReadOnlyList<TFPLTransfer>;
    property Transfers:              IReadOnlyList<TFPLTransfer> read getTransfers;
  end;

function FPLTransfers: IFPLTransfers;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLTransfers = class(TInterfacedObject, IFPLTransfers)
  strict private
    FTransfers:                IList<TFPLTransfer>;
  private
    function getTransfers:     IReadOnlyList<TFPLTransfer>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Transfers:              IReadOnlyList<TFPLTransfer> read getTransfers;
  end;

var gInstance: IFPLTransfers;

function FPLTransfers: IFPLTransfers;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLTransfers.Create; end;
  result := gInstance;
end;

{ TFPLTransfers }

function TFPLTransfers.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLTransfer;
begin
  FTransfers.Clear;

  for so in aSO['transfers'] do begin
    rec := TFPLTransfer.Create('OK');

    rec.Felement_in_cost  := so.I['element_in_cost'];
    rec.Felement_out      := so.I['element_out'];
    rec.Felement_in       := so.I['element_in'];
    rec.Ftime             := XMLTimeToDateTime(so.S['time']);
    rec.Fevent            := so.I['event'];
    rec.Fentry            := so.I['entry'];
    rec.Felement_out_cost := so.I['element_out_ocst'];

    FTransfers.Add(rec);
  end;
end;

constructor TFPLTransfers.Create;
begin
  inherited;
  FTransfers := TCollections.CreateObjectList<TFPLTransfer>(TRUE);
end;

destructor TFPLTransfers.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLTransfers.getTransfers: IReadOnlyList<TFPLTransfer>;
begin
  result := FTransfers.AsReadOnlyList;
end;

{ TFPLStaticElementType }

constructor TFPLTransfer.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLTransfer.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
