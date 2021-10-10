unit FPL_Static_Game_Settings;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLStaticGameSetting = class
  private
    Ftransfers_cap: integer;
    Fcup_qualifying_method: string;
    Fleague_points_h2h_win: integer;
    Fleague_max_size_public_h2h: integer;
    Fleague_prefix_public: string;
    Fleague_join_public_max: integer;
    Fstats_form_days: integer;
    Fcup_type: string;
    Fsys_vice_captain_enabled: boolean;
    Fleague_points_h2h_draw: integer;
    Fsquad_total_spend: integer;
    Fleague_points_h2h_lose: integer;
    Fcup_stop_event_id: integer;
    Fui_currency_multiplier: integer;
    Fcup_start_event_id: integer;
    Fsquad_team_limit: integer;
    Ftimezone: string;
    Fleague_max_size_private_h2h: integer;
    Fsquad_squadsize: integer;
    Fleague_max_ko_rounds_private_h2h: integer;
    Ftransfers_sell_on_fee: double;
    Fleague_max_size_public_classic: integer;
    Fleague_join_private_max: integer;
    Fsquad_squadplay: integer;
    Fleague_ko_first_instead_of_random: boolean;
    Fui_use_special_shirts: boolean;
    Fui_special_shirt_exclusions: string;
    Fleague_h2h_tiebreak_stats: string;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property timezone: string  read Ftimezone;
//    property league_h2h_tiebreak_stats read Fleague_h2h_tiebreak_stats;
    property league_max_size_public_classic:    integer read Fleague_max_size_public_classic;
    property league_prefix_public:              string  read Fleague_prefix_public;
    property league_max_size_private_h2h:       integer read Fleague_max_size_private_h2h;
    property ui_use_special_shirts:             boolean read Fui_use_special_shirts;
    property cup_qualifying_method:             string  read Fcup_qualifying_method;
    property cup_start_event_id:                integer read Fcup_start_event_id;
    property league_points_h2h_win:             integer read Fleague_points_h2h_win;
    property transfers_sell_on_fee:             double  read Ftransfers_sell_on_fee;
    property cup_stop_event_id:                 integer read Fcup_stop_event_id;
    property squad_squadsize:                   integer read Fsquad_squadsize;
    property squad_squadplay:                   integer read Fsquad_squadplay;
    property transfers_cap:                     integer read Ftransfers_cap;
    property league_max_size_public_h2h:        integer read Fleague_max_size_public_h2h;
    property squad_team_limit:                  integer read Fsquad_team_limit;
    property cup_type:                          string  read Fcup_type;
    property league_max_ko_rounds_private_h2h:  integer read Fleague_max_ko_rounds_private_h2h;
    property ui_special_shirt_exclusions:       string  read Fui_special_shirt_exclusions;
    property stats_form_days:                   integer read Fstats_form_days;
    property squad_total_spend:                 integer read Fsquad_total_spend;
    property ui_currency_multiplier:            integer read Fui_currency_multiplier;
    property league_join_public_max:            integer read Fleague_join_public_max;
    property league_ko_first_instead_of_random: boolean read Fleague_ko_first_instead_of_random;
    property league_points_h2h_lose:            integer read Fleague_points_h2h_lose;
    property league_join_private_max:           integer read Fleague_join_private_max;
    property league_points_h2h_draw:            integer read Fleague_points_h2h_draw;
    property sys_vice_captain_enabled:          boolean read Fsys_vice_captain_enabled;
    property league_h2h_tiebreak_stats:         string  read Fleague_h2h_tiebreak_stats;
  end;

  IFPLStaticGameSettings = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticGameSetting:      TFPLStaticGameSetting;
    property GameSettings:              TFPLStaticGameSetting read getStaticGameSetting;
  end;

function FPLStaticGameSettings: IFPLStaticGameSettings;

implementation

uses
  System.SysUtils;

type
  TFPLStaticGameSettings = class(TInterfacedObject, IFPLStaticGameSettings)
  strict private
    FStaticGameSetting:                TFPLStaticGameSetting;
  private
    function getStaticGameSetting:     TFPLStaticGameSetting;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property GameSettings:              TFPLStaticGameSetting read getStaticGameSetting;
  end;

var gInstance: IFPLStaticGameSettings;

function FPLStaticGameSettings: IFPLStaticGameSettings;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticGameSettings.Create; end;
  result := gInstance;
end;

{ TFPLStaticGameSettings }

function TFPLStaticGameSettings.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLStaticGameSetting;
begin
  so := aSO;
  rec := TFPLStaticGameSetting.Create('OK');

  rec.Ftimezone :=                           so.S['timezone'];
  rec.Fleague_max_size_public_classic :=     so.I['league_max_size_public_classic'];
  rec.Fleague_prefix_public :=               so.S['league_prefix_public'];
  rec.Fleague_max_size_private_h2h :=        so.I['league_max_size_private_h2h'];
  rec.Fui_use_special_shirts :=              so.B['ui_use_special_shirts'];
  rec.Fcup_qualifying_method :=              so.S['cup_qualifying_method'];
  rec.Fcup_start_event_id :=                 so.I['cup_start_event_id'];
  rec.Fleague_points_h2h_win :=              so.I['league_points_h2h_win'];
  rec.Ftransfers_sell_on_fee :=              so.D['transfers_sell_on_fee'];
  rec.Fcup_stop_event_id :=                  so.I['cup_stop_event_id'];
  rec.Fsquad_squadsize :=                    so.I['squad_squadsize'];
  rec.Fsquad_squadplay :=                    so.I['squad_squadplay'];
  rec.Ftransfers_cap :=                      so.I['transfers_cap'];
  rec.Fleague_max_size_public_h2h :=         so.I['league_max_size_public_h2h'];
  rec.Fsquad_team_limit :=                   so.I['squad_team_limit'];
  rec.Fcup_type :=                           so.S['cup_type'];
  rec.Fleague_max_ko_rounds_private_h2h :=   so.I['league_max_ko_rounds_private_h2h'];
  rec.Fui_special_shirt_exclusions :=        so.S['ui_special_shirt_exclusions'];
  rec.Fstats_form_days :=                    so.I['stats_form_days'];
  rec.Fsquad_total_spend :=                  so.I['squad_total_spend'];
  rec.Fui_currency_multiplier :=             so.I['ui_currency_multiplier'];
  rec.Fleague_join_public_max :=             so.I['league_join_public_max'];
  rec.Fleague_ko_first_instead_of_random :=  so.B['league_ko_first_instead_of_random'];
  rec.Fleague_points_h2h_lose :=             so.I['league_points_h2h_lose'];
  rec.Fleague_join_private_max :=            so.I['league_join_private_max'];
  rec.Fleague_points_h2h_draw :=             so.I['league_points_h2h_draw'];
  rec.Fsys_vice_captain_enabled :=           so.B['sys_vice_captain_enabled'];
  rec.Fleague_h2h_tiebreak_stats :=          so.S['league_h2h_tiebreak_stats'];

  FStaticGameSetting := rec;
end;

constructor TFPLStaticGameSettings.Create;
begin
  inherited;
end;

destructor TFPLStaticGameSettings.Destroy;
begin
  case FStaticGameSetting <> NIL of TRUE: FStaticGameSetting.Free; end;
  inherited;
end;

function TFPLStaticGameSettings.getStaticGameSetting: TFPLStaticGameSetting;
begin
  result := FStaticGameSetting;
end;

{ TFPLStaticGameSetting }

constructor TFPLStaticGameSetting.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLStaticGameSetting.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
