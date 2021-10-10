unit FPL_Static_Events;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLChipPlay = class
  private
    Fchip_name:   string;
    Fnum_played:  integer;   // the number of players who played this chip
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property chip_name:   string  read Fchip_name;
    property num_played:  integer read Fnum_played;
  end;

  TFPLStaticEvent = class
  private
    FChipPlays: IList<TFPLChipPlay>;
  private
    Fid: integer;
    Fname: string;
    Faverage_entry_score: integer;
    Fdeadline_time_game_offset: integer;
    Fdata_checked: boolean;
    Fmost_captained: integer;
    Fmost_selected: integer;
    Ftransfers_made: integer;
    Ffinished: boolean;
    Ftop_element: integer;
    Fhighest_score: integer;
    Fdeadline_time_epoch: integer;
    Fmost_vice_captained: integer;
    Fdeadline_time: TDateTime;
    Fis_next: boolean;
    Ftop_element_info_ID: integer;
    Ftop_element_info_Points: integer;
    Fmost_transferred_in: integer;
    Fis_current: boolean;
    Fhighest_scoring_entry: integer;
    Fis_previous: boolean;
    function getChipPlays: IReadOnlyList<TFPLChipPlay>;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property id:                        integer read Fid;
    property name:                      string  read Fname;
    property average_entry_score:       integer read Faverage_entry_score;
    property deadline_time_game_offset: integer read Fdeadline_time_game_offset;
    property data_checked:              boolean read Fdata_checked;
    property most_captained:            integer read Fmost_captained;
    property most_selected:             integer read Fmost_selected;
    property transfers_made:            integer read Ftransfers_made;
    property finished:                  boolean read Ffinished;
    property top_element:               integer read Ftop_element;
    property chip_plays:                IReadOnlyList<TFPLChipPlay> read getChipPlays;
    property highest_score:             integer read Fhighest_score;
    property deadline_time_epoch:       integer read Fdeadline_time_epoch;
    property most_vice_captained:       integer read Fmost_vice_captained;
    property deadline_time:             TDateTime read Fdeadline_time;
    property is_next:                   boolean read Fis_next;
    property top_element_info_ID:       integer read Ftop_element_info_ID;
    property top_element_info_Points:   integer read Ftop_element_info_Points;
    property most_transferred_in:       integer read Fmost_transferred_in;
    property is_current:                boolean read Fis_current;
    property highest_scoring_entry:     integer read Fhighest_scoring_entry;
    property is_previous:               boolean read Fis_previous;
  end;

  IFPLStaticEvents = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticEvents: IReadOnlyList<TFPLStaticEvent>;
    property Events:          IReadOnlyList<TFPLStaticEvent> read getStaticEvents;
  end;

function FPLStaticEvents: IFPLStaticEvents;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLStaticEvents = class(TInterfacedObject, IFPLStaticEvents)
  strict private
    FStaticEvents: IList<TFPLStaticEvent>;
  private
    function getStaticEvents:           IReadOnlyList<TFPLStaticEvent>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Events:                    IReadOnlyList<TFPLStaticEvent> read getStaticEvents;
  end;

var gInstance: IFPLStaticEvents;

function FPLStaticEvents: IFPLStaticEvents;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticEvents.Create; end;
  result := gInstance;
end;

{ TFPLStaticEvents }

function TFPLStaticEvents.build(aSO: ISuperObject): boolean;
var
  so:       ISuperObject;
  rec:      TFPLStaticEvent;
  chip:     ISuperObject;
  chipPlay: TFPLChipPlay;
  item:     TSuperAvlEntry;
begin
  FStaticEvents.Clear;

  for so in aSO do begin
    rec := TFPLStaticEvent.Create('OK');

    rec.FID                         := so.I['id'];
    rec.Fname                       := so.S['name'];
    rec.Faverage_entry_score        := so.I['average_entry_score'];
    rec.Fdeadline_time_game_offset  := so.I['deadline_time_game_offset'];
    rec.Fdata_checked               := so.B['data_checked'];
    rec.Fmost_captained             := so.I['most_captained'];
    rec.Fmost_selected              := so.I['most_selected'];
    rec.Ftransfers_made             := so.I['transfers_made'];
    rec.Ffinished                   := so.B['finished'];
    rec.Ftop_element                := so.I['top_element'];

    // e.g. "chip_plays":[{"chip_name":"bboost","num_played":112843},{"chip_name":"3xc","num_played":225426}]
    for chip in so.O['chip_plays'] do begin
      chipPlay := TFPLChipPlay.Create('OK');
      for item in chip.AsObject do begin
        case item.Name = 'chip_name' of  TRUE: chipPlay.Fchip_name  := item.Value.AsString;
                                        FALSE: chipPlay.Fnum_played := item.Value.AsInteger; end;
      end;
      rec.FChipPlays.Add(chipPlay);
    end;

    rec.Fhighest_score            := so.I['highest_score'];
    rec.Fdeadline_time_epoch      := so.I['deadline_time_epoch'];
    rec.Fmost_vice_captained      := so.I['most_vice_captained'];

    rec.Fdeadline_time := XMLTimeToDateTime(so.S['deadline_time'], FALSE); // 2020-10-23T17:30:00Z

    rec.Fis_next                  := so.B['is_next'];

    // e.g. {"points":20,"id":254}
    rec.Ftop_element_info_ID      := so.I['top_element_info.id'];
    rec.Ftop_element_info_Points  := so.I['top_element_info.points'];

    rec.Fmost_transferred_in      := so.I['most_transferred_in'];
    rec.Fis_current               := so.B['is_current'];
    rec.Fhighest_scoring_entry    := so.I['highest_scoring_entry'];
    rec.Fis_previous              := so.B['is_previous'];

    FStaticEvents.Add(rec);
  end;
end;

constructor TFPLStaticEvents.Create;
begin
  inherited;
  FStaticEvents := TCollections.CreateObjectList<TFPLStaticEvent>(TRUE);
end;

destructor TFPLStaticEvents.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLStaticEvents.getStaticEvents: IReadOnlyList<TFPLStaticEvent>;
begin
  result := FStaticEvents.AsReadOnlyList;
end;

{ TFPLStaticEvent }

constructor TFPLStaticEvent.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

function TFPLStaticEvent.getChipPlays: IReadOnlyList<TFPLChipPlay>;
begin
  result := FChipPlays.AsReadOnlyList;
end;

constructor TFPLStaticEvent.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
  FChipPlays := TCollections.CreateObjectList<TFPLChipPlay>(TRUE)
end;

{ TFPLChipPlay }

constructor TFPLChipPlay.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLChipPlay.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
