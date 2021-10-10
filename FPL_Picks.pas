unit FPL_Picks;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLSub = class
  private
    Felement_out: integer;
    Felement_in:  integer;
    Fevent:       integer;
    Fentry:       integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property entry:       integer read Fentry;
    property event:       integer read Fevent;
    property element_out: integer read Felement_out;
    property element_in:  integer read Felement_in;
  end;

  TFPLPick = class
  private
    Felement: integer;
    Fposition: integer;
    Fmultiplier: integer;
    Fis_captain: boolean;
    Fis_vice_captain: boolean;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property element:         integer read Felement;
    property position:        integer read Fposition;
    property multiplier:      integer read Fmultiplier;
    property is_captain:      boolean read Fis_captain;
    property is_vice_captain: boolean read Fis_vice_captain;
  end;

  TFPLEntry = class
  private
    Fevent_transfers_cost:  integer;
    Frank:                  integer;
    Fpoints_on_bench:       integer;
    Frank_sort:             integer;
    Fevent_transfers:       integer;
    Foverall_rank:          integer;
    Fbank:                  integer;
    Fvalue:                 integer;
    Fevent:                 integer;
    Fpoints:                integer;
    Ftotal_points:          integer;
    Factive_chip:           string;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property active_chip:           string  read Factive_chip;
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

  IFPLPicks = interface
    function build(aSO: ISuperObject):  boolean;
    function getEntry:                  IReadOnlyList<TFPLEntry>;
    function getSubs:                   IReadOnlyList<TFPLSub>;
    function getPicks:                  IReadOnlyList<TFPLPick>;
    property entry:                     IReadOnlyList<TFPLEntry>  read getEntry;
    property subs:                      IReadOnlyList<TFPLSub>    read getSubs;
    property picks:                     IReadOnlyList<TFPLPick>   read getPicks;
  end;

function FPLPicks: IFPLPicks;

implementation

uses
  System.SysUtils;

type
  TFPLPicks = class(TInterfacedObject, IFPLPicks)
  strict private
    Fentry:    IList<TFPLEntry>;
    Fsubs:     IList<TFPLSub>;
    Fpicks:    IList<TFPLPick>;
  private
    function getEntry:      IReadOnlyList<TFPLEntry>;
    function getSubs:       IReadOnlyList<TFPLSub>;
    function getPicks:      IReadOnlyList<TFPLPick>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property entry:                     IReadOnlyList<TFPLEntry>   read getEntry;
    property subs:                      IReadOnlyList<TFPLSub>     read getSubs;
    property picks:                     IReadOnlyList<TFPLPick>    read getPicks;
  end;

var gInstance: IFPLPicks;

function FPLPicks: IFPLPicks;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLPicks.Create; end;
  result := gInstance;
end;

{ TFPLPicks }

function TFPLPicks.build(aSO: ISuperObject): boolean;
var
  rec:     TFPLEntry;
  recSub:  TFPLSub;
  recPick: TFPLPick;
begin
  FEntry.Clear;
  Fsubs.Clear;
  Fpicks.Clear;

  rec                       := TFPLEntry.Create('OK');
  rec.Factive_chip          := aSO.S['active_chip'];
  rec.Fevent_transfers_cost := aSO.I['entry_history.event_transfers_cost'];
  rec.Frank                 := aSO.I['entry_history.rank'];
  rec.Fpoints_on_bench      := aSO.I['entry_history.points_on_bench'];
  rec.Frank_sort            := aSO.I['entry_history.rank_sort'];
  rec.Fevent_transfers      := aSO.I['entry_history.event_transfers'];
  rec.Foverall_rank         := aSO.I['entry_history.overall_rank'];
  rec.Fbank                 := aSO.I['entry_history.bank'];
  rec.Fvalue                := aSO.I['entry_history.value'];
  rec.Fevent                := aSO.I['entry_history.event'];
  rec.Fpoints               := aSO.I['entry_history.points'];
  rec.Ftotal_points         := aSO.I['entry_history.total_points'];
  Fentry.Add(rec);

  for var sub in aSO['automatic_subs'] do begin
    recSub                := TFPLSub.Create('OK');
    recSub.Fentry         := sub.I['entry'];
    recSub.Fevent         := sub.I['event'];
    recSub.Felement_in    := sub.I['element_in'];
    recSub.Felement_out   := sub.I['element_out'];
    Fsubs.Add(recSub);
  end;

  for var pick in aSo['picks'] do begin
    recPick                   := TFPLPick.Create('OK');
    recPick.Felement          := pick.I['element'];
    recPick.Fposition         := pick.I['position'];
    recPick.Fmultiplier       := pick.I['multiplier'];
    recPick.Fis_captain       := pick.B['is_captain'];
    recPick.Fis_vice_captain  := pick.B['is_vice_captain'];
    Fpicks.Add(recPick);
  end;

end;

constructor TFPLPicks.Create;
begin
  inherited Create;
  Fentry  := TCollections.CreateObjectList<TFPLEntry>(TRUE);
  Fsubs   := TCollections.CreateObjectList<TFPLSub>(TRUE);
  Fpicks  := TCollections.CreateObjectList<TFPLPick>(TRUE);
end;

destructor TFPLPicks.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLPicks.getSubs: IReadOnlyList<TFPLSub>;
begin
  result := Fsubs.AsReadOnlyList;
end;

function TFPLPicks.getEntry: IReadOnlyList<TFPLEntry>;
begin
  result := Fentry.AsReadOnlyList;
end;

function TFPLPicks.getPicks: IReadOnlyList<TFPLPick>;
begin
  result := Fpicks.AsReadOnlyList;
end;

{ TFPLSub }

constructor TFPLSub.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

constructor TFPLSub.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

{ TFPLPick }

constructor TFPLPick.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLPick.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

{ TFPLEntry }

constructor TFPLEntry.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLEntry.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
