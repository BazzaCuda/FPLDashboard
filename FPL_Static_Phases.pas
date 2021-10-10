unit FPL_Static_Phases;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLStaticPhase = class
  private
    Fid:          integer;
    Fname:        string;
    Fstart_event: integer;
    Fstop_event:  integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property id:          integer read Fid;
    property name:        string  read Fname;
    property start_event: integer read Fstart_event;
    property stop_event:  integer read Fstop_event;
  end;

  IFPLStaticPhases = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticPhases:           IReadOnlyList<TFPLStaticPhase>;
    property Phases:                    IReadOnlyList<TFPLStaticPhase> read getStaticPhases;
  end;

function FPLStaticPhases: IFPLStaticPhases;

implementation

uses
  System.SysUtils;

type
  TFPLStaticPhases = class(TInterfacedObject, IFPLStaticPhases)
  strict private
    FStaticPhases:                IList<TFPLStaticPhase>;
  private
    function getStaticPhases:     IReadOnlyList<TFPLStaticPhase>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Phases:              IReadOnlyList<TFPLStaticPhase> read getStaticPhases;
  end;

var gInstance: IFPLStaticPhases;

function FPLStaticPhases: IFPLStaticPhases;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticPhases.Create; end;
  result := gInstance;
end;

{ TFPLStaticPhases }

function TFPLStaticPhases.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLStaticPhase;
begin
  FStaticPhases.Clear;

  for so in aSO do begin
    rec := TFPLStaticPhase.Create('OK');

    rec.FID               := so.I['id'];
    rec.Fname             := so.S['name'];
    rec.Fstart_event      := so.I['start_event'];
    rec.Fstop_event       := so.I['stop_event'];

    FStaticPhases.Add(rec);
  end;
end;

constructor TFPLStaticPhases.Create;
begin
  inherited;
  FStaticPhases := TCollections.CreateObjectList<TFPLStaticPhase>(TRUE);
end;

destructor TFPLStaticPhases.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLStaticPhases.getStaticPhases: IReadOnlyList<TFPLStaticPhase>;
begin
  result := FStaticPhases.AsReadOnlyList;
end;

{ TFPLStaticPhase }

constructor TFPLStaticPhase.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLStaticPhase.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
