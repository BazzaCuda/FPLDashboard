unit FPL_TID_Entry;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLCupMatchEntry = class
  private
    Fentry_2_draw: integer;
    Ftiebreak: string;
    Fentry_1_draw: integer;
    Fentry_2_total: integer;
    Fentry_1_total: integer;
    Fwinner: integer;
    Fseed_value: string;
    Fentry_2_points: integer;
    Fentry_1_player_name: string;
    Fentry_2_entry: integer;
    Fid: integer;
    Fentry_2_loss: integer;
    Fentry_1_points: integer;
    Fentry_1_entry: integer;
    Fentry_1_loss: integer;
    Fevent: integer;
    Fentry_2_name: string;
    Fentry_2_win: integer;
    Fentry_1_name: string;
    Fentry_1_win: integer;
    Fentry_2_player_name: string;
    Fis_knockout: boolean;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
  public
    property entry_1_entry:           integer read Fentry_1_entry;
    property entry_1_total:           integer read Fentry_1_total;
    property entry_2_win:             integer read Fentry_2_win;
    property entry_2_entry:           integer read Fentry_2_entry;
    property entry_2_total:           integer read Fentry_2_total;
    property entry_1_win:             integer read Fentry_1_win;
    property entry_2_player_name:     string  read Fentry_2_player_name;
    property entry_1_player_name:     string  read Fentry_1_player_name;
    property entry_2_name:            string  read Fentry_2_name;
    property entry_2_loss:            integer read Fentry_2_loss;
    property entry_2_draw:            integer read Fentry_2_draw;
    property entry_2_points:          integer read Fentry_2_points;
    property entry_1_name:            string  read Fentry_1_name;
    property entry_1_loss:            integer read Fentry_1_loss;
    property entry_1_draw:            integer read Fentry_1_draw;
    property id:                      integer read Fid;
    property event:                   integer read Fevent;
    property winner:                  integer read Fwinner;
    property entry_1_points:          integer read Fentry_1_points;
    property is_knockout:             boolean read Fis_knockout;
    property tiebreak:                string  read Ftiebreak;
    property seed_value:              string  read Fseed_value;
  end;

  TFPLLeagueEntry = class
  private
    Fname: string;
    Fentry_can_invite: boolean;
    Fmax_entries: integer;
    Fclosed: boolean;
    Frank: integer;
    Fcup_qualified: boolean;
    Fshort_name: string;
    Fentry_last_rank: integer;
    Fcup_league: integer;
    Fscoring: string;
    Fadmin_entry: integer;
    Fid: integer;
    Fcreated: TDateTime;
    Fentry_rank: integer;
    Fentry_can_admin: boolean;
    Fhas_cup: boolean;
    Fentry_can_leave: boolean;
    Fstart_event: integer;
    Fleague_type: string;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property entry_rank:        integer   read Fentry_rank;
    property has_cup:           boolean   read Fhas_cup;
    property entry_can_invite:  boolean   read Fentry_can_invite;
    property start_event:       integer   read Fstart_event;
    property short_name:        string    read Fshort_name;
    property cup_qualified:     boolean   read Fcup_qualified;
    property scoring:           string    read Fscoring;
    property created:           TDateTime read Fcreated;
    property cup_league:        integer   read Fcup_league;
    property id:                integer   read Fid;
    property entry_can_admin:   boolean   read Fentry_can_admin;
    property max_entries:       integer   read Fmax_entries;
    property admin_entry:       integer   read Fadmin_entry;
    property entry_last_rank:   integer   read Fentry_last_rank;
    property rank:              integer   read Frank;
    property name:              string    read Fname;
    property closed:            boolean   read Fclosed;
    property league_type:       string    read Fleague_type;
    property entry_can_leave:   boolean   read Fentry_can_leave;
  end;

  TFPLTIDEntry = class
  private
    FLeaguesClassic:    IList<TFPLLeagueEntry>;
    FLeaguesH2H:        IList<TFPLLeagueEntry>;
    FLeaguesCupMatches: IList<TFPLCupMatchEntry>;
  private
    Fname: string;
    Fplayer_first_name: string;
    Fplayer_region_name: string;
    Ffavourite_team: string;
    Fplayer_region_iso_code_long: string;
    Fjoined_time: TDateTime;
    Flast_deadline_bank: integer;
    Fsummary_event_points: integer;
    Flast_deadline_value: integer;
    Fsummary_overall_points: integer;
    Fplayer_last_name: string;
    Fcurrent_event: integer;
    Fid: integer;
    Fplayer_region_id: integer;
    Fsummary_event_rank: integer;
    Flast_deadline_total_transfers: integer;
    Fsummary_overall_rank: integer;
    Fstarted_event: integer;
    Fkit: string;
    Fplayer_region_iso_code_short: string;
    Fkit_shirt_secondary: string;
    Fkit_socks_secondary: string;
    Fkit_shirt_type: string;
    Fkit_shirt_logo: string;
    Fkit_shirt_base: string;
    Fkit_shirt_sleeves: string;
    Fkit_socks_type: string;
    Fkit_socks_base: string;
    Fkit_shorts: string;
    function getLeaguesClassic: IReadOnlyList<TFPLLeagueEntry>;
    function getLeaguesH2H: IReadOnlyList<TFPLLeagueEntry>;
    function getLeaguesCupMatches: IReadOnlyList<TFPLCupMatchEntry>;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property player_region_iso_code_short:  string    read Fplayer_region_iso_code_short;
    property kit:                           string    read Fkit;
    property summary_event_points:          integer   read Fsummary_event_points;
    property current_event:                 integer   read Fcurrent_event;
    property player_first_name:             string    read Fplayer_first_name;
    property started_event:                 integer   read Fstarted_event;
    property player_last_name:              string    read Fplayer_last_name;
    property summary_overall_rank:          integer   read Fsummary_overall_rank;
    property last_deadline_bank:            integer   read Flast_deadline_bank;
    property id:                            integer   read Fid;
    property player_region_name:            string    read Fplayer_region_name;
    property last_deadline_total_transfers: integer   read Flast_deadline_total_transfers;
    property player_region_id:              integer   read Fplayer_region_id;
    property favourite_team:                string    read Ffavourite_team;
    property name:                          string    read Fname;
    property summary_overall_points:        integer   read Fsummary_overall_points;
    property player_region_iso_code_long:   string    read Fplayer_region_iso_code_long;
    property last_deadline_value:           integer   read Flast_deadline_value;
    property summary_event_rank:            integer   read Fsummary_event_rank;
    property joined_time:                   TDateTime read Fjoined_time;
    property kit_socks_type:                string    read Fkit_socks_type;
    property kit_socks_base:                string    read Fkit_socks_base;
    property kit_shirt_sleeves:             string    read Fkit_shirt_sleeves;
    property kit_socks_secondary:           string    read Fkit_socks_secondary;
    property kit_shirt_type:                string    read Fkit_shirt_type;
    property kit_shirt_logo:                string    read Fkit_shirt_logo;
    property kit_shirt_base:                string    read Fkit_shirt_base;
    property kit_shorts:                    string    read Fkit_shorts;
    property kit_shirt_secondary:           string    read Fkit_shirt_secondary;
    property leagues_classic:               IReadOnlyList<TFPLLeagueEntry>    read getLeaguesClassic;
    property leagues_h2h:                   IReadOnlyList<TFPLLeagueEntry>    read getLeaguesH2H;
    property leagues_cup_matches:           IReadOnlyList<TFPLCupMatchEntry>  read getLeaguesCupMatches;
  end;

  IFPLTIDEntrys = interface
    function build(aSO: ISuperObject):  boolean;
    function getTIDEntrys:              IReadOnlyList<TFPLTIDEntry>;
    property Entrys:                    IReadOnlyList<TFPLTIDEntry> read getTIDEntrys;
  end;

function FPLTIDEntry: IFPLTIDEntrys;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLTIDEntrys = class(TInterfacedObject, IFPLTIDEntrys)
  strict private
    FTIDEntrys:                IList<TFPLTIDEntry>;
  private
    function getTIDEntrys:     IReadOnlyList<TFPLTIDEntry>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property TIDEntrys:              IReadOnlyList<TFPLTIDEntry> read getTIDEntrys;
  end;

var gInstance: IFPLTIDEntrys;

function FPLTIDEntry: IFPLTIDEntrys;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLTIDEntrys.Create; end;
  result := gInstance;
end;

{ TFPLTIDEntrys }

function TFPLTIDEntrys.build(aSO: ISuperObject): boolean;
// kit_socks_type":"plain","kit_socks_base":"#000000","kit_shirt_sleeves":"#d0021b","kit_socks_secondary":"#E1E1E1",
// "kit_shirt_type":"plain","kit_shirt_logo":"none","kit_shirt_base":"#d0021b","kit_shorts":"#000000","kit_shirt_secondary":"#E1E1E1"}
var
  so:             ISuperObject;
  rec:            TFPLTIDEntry;
  leagueEntry:    TFPLLeagueEntry;
  cupMatchEntry:  TFPLCupMatchEntry;
begin
  FTIDEntrys.Clear;

  for so in aSO['entry'] do begin
    rec := TFPLTIDEntry.Create('OK');

    rec.Fplayer_region_iso_code_short :=  so.S['player_region_iso_code_short'];
    rec.Fkit :=                           so.S['kit'];
    rec.Fsummary_event_points :=          so.I['summary_event_points'];
    rec.Fcurrent_event :=                 so.I['current_event'];
    rec.Fplayer_first_name :=             so.S['player_first_name'];
    rec.Fstarted_event :=                 so.I['started_event'];
    rec.Fplayer_last_name :=              so.S['player_last_name'];
    rec.Fsummary_overall_rank :=          so.I['summary_overall_rank'];
    rec.Flast_deadline_bank :=            so.I['last_deadline_bank'];
    rec.Fid :=                            so.I['id'];
    rec.Fplayer_region_name :=            so.S['player_region_name'];
    rec.Flast_deadline_total_transfers := so.I['last_deadline_total_transfers'];
    rec.Fplayer_region_id :=              so.I['player_region_id'];
    rec.Ffavourite_team :=                so.S['favourite_team'];
    rec.Fname :=                          so.S['name'];
    rec.Fsummary_overall_points :=        so.I['summary_overall_points'];
    rec.Fplayer_region_iso_code_long :=   so.S['player_region_iso_code_long'];
    rec.Flast_deadline_value :=           so.I['last_deadline_value'];
    rec.Fsummary_event_rank :=            so.I['summary_event_rank'];
    rec.Fjoined_time :=                   XMLTimeToDateTime(so.S['joined_time']);

    rec.Fkit_socks_type :=                so.S['kit.kit_socks_type'];
    rec.Fkit_socks_base :=                so.S['kit.kit_socks_base'];
    rec.Fkit_shirt_sleeves :=             so.S['kit.kit_shirt_sleeves'];
    rec.Fkit_socks_secondary :=           so.S['kit.kit_socks_secondary'];
    rec.Fkit_shirt_type :=                so.S['kit.kit_socks_secondary'];
    rec.Fkit_shirt_logo :=                so.S['kit.kit_socks_secondary'];
    rec.Fkit_shirt_base :=                so.S['kit.kit_shirt_base'];
    rec.Fkit_shorts :=                    so.S['kit.kit_shorts'];
    rec.Fkit_shirt_secondary :=           so.S['kit.kit_shirt_secondary'];

    for var le in so['leagues.classic'] do begin
      leagueEntry := TFPLLeagueEntry.Create('OK');

      leagueEntry.Fentry_rank :=         le.I['entry_rank'];
      leagueEntry.Fhas_cup :=            le.B['has_cup'];
      leagueEntry.Fentry_can_invite :=   le.B['entry_can_invite'];
      leagueEntry.Fstart_event :=        le.I['start_event'];
      leagueEntry.Fshort_name :=         le.S['short_name'];
      leagueEntry.Fcup_qualified :=      le.B['cup_qualified'];
      leagueEntry.Fscoring :=            le.S['scoring'];
      leagueEntry.Fcreated :=            XMLTimeToDateTime(le.S['created']);
      leagueEntry.Fcup_league :=         le.I['cup_league'];
      leagueEntry.Fid :=                 le.I['id'];
      leagueEntry.Fentry_can_admin :=    le.B['entry_can_admin'];
      leagueEntry.Fmax_entries :=        le.I['max_entries'];
      leagueEntry.Fadmin_entry :=        le.I['admin_entry'];
      leagueEntry.Fentry_last_rank :=    le.I['entry_last_rank'];
      leagueEntry.Frank :=               le.I['rank'];
      leagueEntry.Fname :=               le.S['name'];
      leagueEntry.Fclosed :=             le.B['closed'];
      leagueEntry.Fleague_type :=        le.S['league_type'];
      leagueEntry.Fentry_can_leave :=    le.B['entry_can_leave'];

      rec.FLeaguesClassic.Add(leagueEntry);
    end;

    for var le in so['leagues.h2h'] do begin
      leagueEntry := TFPLLeagueEntry.Create('OK');

      leagueEntry.Fentry_rank :=         le.I['entry_rank'];
      leagueEntry.Fhas_cup :=            le.B['has_cup'];
      leagueEntry.Fentry_can_invite :=   le.B['entry_can_invite'];
      leagueEntry.Fstart_event :=        le.I['start_event'];
      leagueEntry.Fshort_name :=         le.S['short_name'];
      leagueEntry.Fcup_qualified :=      le.B['cup_qualified'];
      leagueEntry.Fscoring :=            le.S['scoring'];
      leagueEntry.Fcreated :=            XMLTimeToDateTime(le.S['created']);
      leagueEntry.Fcup_league :=         le.I['cup_league'];
      leagueEntry.Fid :=                 le.I['id'];
      leagueEntry.Fentry_can_admin :=    le.B['entry_can_admin'];
      leagueEntry.Fmax_entries :=        le.I['max_entries'];
      leagueEntry.Fadmin_entry :=        le.I['admin_entry'];
      leagueEntry.Fentry_last_rank :=    le.I['entry_last_rank'];
      leagueEntry.Frank :=               le.I['rank'];
      leagueEntry.Fname :=               le.S['name'];
      leagueEntry.Fclosed :=             le.B['closed'];
      leagueEntry.Fleague_type :=        le.S['league_type'];
      leagueEntry.Fentry_can_leave :=    le.B['entry_can_leave'];

      rec.FLeaguesH2H.Add(leagueEntry);
    end;

    for var cm in so['leagues.cup.matches'] do begin
      cupMatchEntry := TFPLCupMatchEntry.Create('OK');

      cupMatchEntry.Fentry_1_entry :=            cm.I['entry_1_entry'];
      cupMatchEntry.Fentry_1_total :=            cm.I['entry_1_total'];
      cupMatchEntry.Fentry_2_win :=              cm.I['entry_2_win'];
      cupMatchEntry.Fentry_2_entry :=            cm.I['entry_2_entry'];
      cupMatchEntry.Fentry_2_total :=            cm.I['entry_2_total'];
      cupMatchEntry.Fentry_1_win :=              cm.I['entry_1_win'];
      cupMatchEntry.Fentry_2_player_name :=      cm.S['entry_2_player_name'];
      cupMatchEntry.Fentry_1_player_name :=      cm.S['entry_1_player_name'];
      cupMatchEntry.Fentry_2_name :=             cm.S['entry_2_name'];
      cupMatchEntry.Fentry_2_loss :=             cm.I['entry_2_loss'];
      cupMatchEntry.Fentry_2_draw :=             cm.I['entry_2_draw'];
      cupMatchEntry.Fentry_2_points :=           cm.I['entry_2_points'];
      cupMatchEntry.Fentry_1_name :=             cm.S['entry_1_name'];
      cupMatchEntry.Fentry_1_loss :=             cm.I['entry_1_loss'];
      cupMatchEntry.Fentry_1_draw :=             cm.I['entry_1_draw'];
      cupMatchEntry.Fid :=                       cm.I['id'];
      cupMatchEntry.Fevent :=                    cm.I['event'];
      cupMatchEntry.Fwinner :=                   cm.I['winner'];
      cupMatchEntry.Fentry_1_points :=           cm.I['entry_1_points'];
      cupMatchEntry.Fis_knockout :=              cm.B['is_knockout'];
      cupMatchEntry.Ftiebreak :=                 cm.S['tiebreak'];
      cupMatchEntry.Fseed_value :=               cm.S['seed_value'];

      rec.FLeaguesCupMatches.Add(cupMatchEntry);
    end;

    FTIDEntrys.Add(rec);
  end;
end;

constructor TFPLTIDEntrys.Create;
begin
  inherited;
  FTIDEntrys := TCollections.CreateObjectList<TFPLTIDEntry>(TRUE);
end;

destructor TFPLTIDEntrys.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLTIDEntrys.getTIDEntrys: IReadOnlyList<TFPLTIDEntry>;
begin
  result := FTIDEntrys.AsReadOnlyList;
end;

{ TFPLStaticElementType }

constructor TFPLTIDEntry.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

function TFPLTIDEntry.getLeaguesClassic: IReadOnlyList<TFPLLeagueEntry>;
begin
  result := FLeaguesClassic.AsReadOnlyList;
end;

function TFPLTIDEntry.getLeaguesCupMatches: IReadOnlyList<TFPLCupMatchEntry>;
begin
  result := FLeaguesCupMatches.AsReadOnlyList;
end;

function TFPLTIDEntry.getLeaguesH2H: IReadOnlyList<TFPLLeagueEntry>;
begin
  result := FLeaguesH2H.AsReadOnlyList;
end;

constructor TFPLTIDEntry.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
  FLeaguesClassic     := TCollections.CreateObjectList<TFPLLeagueEntry>(TRUE);
  FLeaguesH2H         := TCollections.CreateObjectList<TFPLLeagueEntry>(TRUE);
  FLeaguesCupMatches  := TCollections.CreateObjectList<TFPLCupMatchEntry>(TRUE);
end;

{ TFPLLeagueEntry }

constructor TFPLLeagueEntry.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLLeagueEntry.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

{ TFPLCupMatchEntry }

constructor TFPLCupMatchEntry.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLCupMatchEntry.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
