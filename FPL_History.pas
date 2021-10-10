unit FPL_History;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLPast = class
  private
    Frank:          integer;
    Fseason_name:   string;
    Ftotal_points:  integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property season_name:   string  read Fseason_name;
    property total_points:  integer read Ftotal_points;
    property rank:          integer read Frank;
  end;

  TFPLChip = class
  private
    Fname:    string;
    Fevent:   integer;
    Ftime:    TDateTime;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property name:   string  read Fname;
    property event:  integer read Fevent;
    property time:   TDateTime read Ftime;
  end;

  TFPLCurrent = class
  private
    Fevent_transfers_cost: integer;
    Frank: integer;
    Fpoints_on_bench: integer;
    Frank_sort: integer;
    Fevent_transfers: integer;
    Foverall_rank: integer;
    Fbank: integer;
    Fvalue: integer;
    Fevent: integer;
    Fpoints: integer;
    Ftotal_points: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property event_transfers_cost:  integer read Fevent_transfers_cost;
    property total_points:          integer read Ftotal_points;
    property points_on_bench:       integer read Fpoints_on_bench;
    property points:                integer read Fpoints;
    property rank_sort:             integer read Frank_sort;
    property event_transfers:       integer read Fevent_transfers;
    property value:                 integer read Fvalue;
    property overall_rank:          integer read Foverall_rank;
    property event:                 integer read Fevent;
    property rank:                  integer read Frank;
    property bank:                  integer read Fbank;
  end;

  IFPLHistory = interface
    function build(aSO: ISuperObject):  boolean;
    function getCurrents:               IReadOnlyList<TFPLCurrent>;
    function getPasts:                  IReadOnlyList<TFPLPast>;
    function getChips:                  IReadOnlyList<TFPLChip>;
    property current:                   IReadOnlyList<TFPLCurrent> read getCurrents;
    property past:                      IReadOnlyList<TFPLPast>    read getPasts;
    property chips:                     IReadOnlyList<TFPLChip>    read getChips;
  end;

function FPLHistory: IFPLHistory;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLHistory = class(TInterfacedObject, IFPLHistory)
  strict private
    FCurrents:  IList<TFPLCurrent>;
    Fpasts:     IList<TFPLPast>;
    Fchips:     IList<TFPLChip>;
  private
    function getCurrents: IReadOnlyList<TFPLCurrent>;
    function getPasts:    IReadOnlyList<TFPLPast>;
    function getChips:    IReadOnlyList<TFPLChip>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property current:                   IReadOnlyList<TFPLCurrent>  read getCurrents;
    property past:                      IReadOnlyList<TFPLPast>     read getPasts;
    property chips:                     IReadOnlyList<TFPLChip>     read getChips;
  end;

var gInstance: IFPLHistory;

function FPLHistory: IFPLHistory;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLHistory.Create; end;
  result := gInstance;
end;

{ TFPLHistory }

function TFPLHistory.build(aSO: ISuperObject): boolean;
var
  rec:      TFPLCurrent;
  recPast:  TFPLPast;
  recChip:  TFPLChip;
begin
  FCurrents.Clear;
  FPasts.Clear;
  Fchips.Clear;

  for var current in aSO['current'] do begin
    rec := TFPLCurrent.Create('OK');

    rec.Fevent                := current.I['event'];
    rec.Fevent_transfers_cost := current.I['event_transfers_cost'];
    rec.Ftotal_points         := current.I['total_points'];
    rec.Fpoints_on_bench      := current.I['points_on_bench'];
    rec.Fpoints               := current.I['points'];
    rec.Frank_sort            := current.I['rank_sort'];
    rec.Fevent_transfers      := current.I['event_transfers'];
    rec.Fvalue                := current.I['value'];
    rec.Foverall_rank         := current.I['overall_rank'];
    rec.Frank                 := current.I['rank'];
    rec.Fbank                 := current.I['bank'];

    FCurrents.Add(rec);
  end;

  for var past in aSO['past'] do begin
    recPast := TFPLPast.Create('OK');

    recPast.Fseason_name      := past.S['season_name'];
    recPast.Ftotal_points     := past.I['total_points'];
    recPast.Frank             := past.I['rank'];

    Fpasts.Add(recPast);
  end;

  for var chip in aSO['chips'] do begin
    recChip := TFPLChip.Create('OK');

    recChip.Fname             := chip.S['name'];
    recChip.Fevent            := chip.I['event'];
    recChip.Ftime             := XMLTimeToDateTime(chip.S['time']);

    Fchips.Add(recChip);
  end;


end;

constructor TFPLHistory.Create;
begin
  inherited Create;
  Fcurrents := TCollections.CreateObjectList<TFPLCurrent>(TRUE);
  Fpasts    := TCollections.CreateObjectList<TFPLPast>(TRUE);
  Fchips    := TCollections.CreateObjectList<TFPLChip>(TRUE);
end;

destructor TFPLHistory.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLHistory.getChips: IReadOnlyList<TFPLChip>;
begin
  result := Fchips.AsReadOnlyList;
end;

function TFPLHistory.getCurrents: IReadOnlyList<TFPLCurrent>;
begin
  result := FCurrents.AsReadOnlyList;
end;

function TFPLHistory.getPasts: IReadOnlyList<TFPLPast>;
begin
  result := Fpasts.AsReadOnlyList;
end;

{ TFPLPast }

constructor TFPLPast.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

constructor TFPLPast.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

{ TFPLChip }

constructor TFPLChip.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLChip.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

{ TFPLCurrent }

constructor TFPLCurrent.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLCurrent.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
