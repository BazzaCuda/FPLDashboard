unit FPL_League;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLeagueStanding = class
  private
    Frank: integer;
    Frank_sort: integer;
    Fentry_name: string;
    Ftotal: integer;
    Fid: integer;
    Fplayer_name: string;
    Fentry: integer;
    Fevent_total: integer;
    Flast_rank: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property entry_name:                              string        read Fentry_name;
    property event_total:                             integer       read Fevent_total;
    property player_name:                             string        read Fplayer_name;
    property last_rank:                               integer       read Flast_rank;
    property rank_sort:                               integer       read Frank_sort;
    property id:                                      integer       read Fid;
    property entry:                                   integer       read Fentry;
    property total:                                   integer       read Ftotal;
    property rank:                                    integer       read Frank;
  end;

  TFPLLeague = class
  private
    Fname: string;
    Fmax_entries: integer;
    Fclosed: boolean;
    Frank: integer;
    Fcup_league: string;
    Fcode_privacy: string;
    Fscoring: string;
    Fadmin_entry: integer;
    Fid: integer;
    Fcreated: TDateTime;
    Fhas_cup: boolean;
    Fstart_event: integer;
    Fleague_type: string;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property has_cup:                                 boolean       read Fhas_cup;
    property start_event:                             integer       read Fstart_event;
    property scoring:                                 string        read Fscoring;
    property created:                                 TDateTime     read Fcreated;
    property cup_league:                              string        read Fcup_league;
    property id:                                      integer       read Fid;
    property code_privacy:                            string        read Fcode_privacy;
    property max_entries:                             integer       read Fmax_entries;
    property admin_entry:                             integer       read Fadmin_entry;
    property rank:                                    integer       read Frank;
    property name:                                    string        read Fname;
    property closed:                                  boolean       read Fclosed;
    property league_type:                             string        read Fleague_type;
  end;

  IFPLLeagues = interface
    function build(aSO: ISuperObject):  boolean;
    function getLeagues:                IReadOnlyList<TFPLLeague>;
    function getLeagueStandings:        IReadOnlyList<TFPLeagueStanding>;
    property leagues:                   IReadOnlyList<TFPLLeague>        read getLeagues;
    property leagueStandings:           IReadOnlyList<TFPLeagueStanding> read getLeagueStandings;
  end;

function FPLLeagues: IFPLLeagues;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLLeagues = class(TInterfacedObject, IFPLLeagues)
  strict private
    FLeagues:                           IList<TFPLLeague>;
    FLeagueStandings:                   IList<TFPLeagueStanding>;
  private
    function getLeagues:                IReadOnlyList<TFPLLeague>;
    function getLeagueStandings:        IReadOnlyList<TFPLeagueStanding>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property leagues:                   IReadOnlyList<TFPLLeague>         read getLeagues;
    property leagueStandings:           IReadOnlyList<TFPLeagueStanding>  read getLeagueStandings;
  end;

var gInstance: IFPLLeagues;

function FPLLeagues: IFPLLeagues;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLLeagues.Create; end;
  result := gInstance;
end;

{ TFPLPicks }

function TFPLLeagues.build(aSO: ISuperObject): boolean;
var
  rec:          TFPLLeague;
  recStanding:  TFPLeagueStanding;
  so:           ISuperObject;
begin
  FLeagues.Clear;

  so := aSO['league'];

  rec               := TFPLLeague.Create('OK');
  rec.Fname         := so.S['name'];
  rec.Fmax_entries  := so.I['max_entries'];
  rec.Fclosed       := so.B['closed'];
  rec.Frank         := so.I['rank'];
  rec.Fcup_league   := so.S['cup_league'];
  rec.Fcode_privacy := so.S['code_privacy'];
  rec.Fscoring      := so.S['scoring'];
  rec.Fadmin_entry  := so.I['admin_entry'];
  rec.Fid           := so.I['id'];
  rec.Fcreated      := XMLTimeToDateTime(so.S['created']);
  rec.Fhas_cup      := so.b['has_cup'];
  rec.Fstart_event  := so.I['start_event'];
  rec.Fleague_type  := so.s['league_type'];
  FLeagues.Add(rec);

  for var standing in aSO['standings.results'] do begin
    recStanding               := TFPLeagueStanding.Create('OK');
    recStanding.Frank         := standing.I['rank'];
    recStanding.Frank_sort    := standing.I['rank_sort'];
    recStanding.Fentry_name   := standing.S['entry_name'];
    recStanding.Ftotal        := standing.I['total'];
    recStanding.Fid           := standing.I['id'];
    recStanding.Fplayer_name  := standing.S['player_name'];
    recStanding.Fentry        := standing.I['entry'];
    recStanding.Fevent_total  := standing.I['event_total'];
    recStanding.Flast_rank    := standing.I['last_rank'];
    FLeagueStandings.Add(recStanding);
  end;

end;

constructor TFPLLeagues.Create;
begin
  inherited Create;
  FLeagues          := TCollections.CreateObjectList<TFPLLeague>(TRUE);
  FLeagueStandings  := TCollections.CreateObjectList<TFPLeagueStanding>(TRUE);
end;

destructor TFPLLeagues.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLLeagues.getLeagues: IReadOnlyList<TFPLLeague>;
begin
  result := FLeagues.AsReadOnlyList;
end;

function TFPLLeagues.getLeagueStandings: IReadOnlyList<TFPLeagueStanding>;
begin
  result := FLeagueStandings.AsReadOnlyList;
end;

{ TFPLLeague }

constructor TFPLLeague.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLLeague.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

{ TFPLeagueStanding }

constructor TFPLeagueStanding.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLeagueStanding.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
