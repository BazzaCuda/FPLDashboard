unit FPL_Static_Elements;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLStaticElement = class
  private
    Fgoals_scored: integer;
    Fevent_points: integer;
    Fthreat_rank: integer;
    Fcreativity: double;
    Fcost_change_event_fall: integer;
    Fsaves: integer;
    Fbonus: integer;
    Fcorners_and_indirect_freekicks_text: string;
    Fict_index_rank: integer;
    Fcreativity_rank_type: integer;
    Fpenalties_missed: integer;
    Fnews: string;
    Ftransfers_in_event: integer;
    Fclean_sheets: integer;
    Fweb_name: string;
    Fcode: integer;
    Fpoints_per_game: double;
    Fassists: integer;
    Fthreat: double;
    Fpenalties_saved: integer;
    Fpenalties_text: string;
    Fform: double;
    Fthreat_rank_type: integer;
    Fyellow_cards: integer;
    Fcost_change_start: integer;
    Fict_index: double;
    Fminutes: integer;
    Fict_index_rank_type: integer;
    FSquad_number: integer;
    Fdirect_freekicks_order: integer;
    Fown_goals: integer;
    Fselected_by_percent: double;
    Ffirst_name: string;
    Fid: integer;
    Fcost_change_event: integer;
    Finfluence_rank: integer;
    Fstatus: string;
    Fep_this: double;
    Fred_cards: integer;
    Ftransfers_out: integer;
    Fvalue_form: double;
    Fteam_code: integer;
    Fin_dreamteam: boolean;
    FChance_of_playing_this_round: integer;
    Fsecond_name: string;
    Fnews_added: TDateTime;
    Fnow_cost: integer;
    Fcorners_and_indirect_freekicks_order: integer;
    Fspecial: boolean;
    Ftotal_points: integer;
    Fbps: integer;
    Fgoals_conceded: integer;
    Fvalue_season: double;
    Fep_next: double;
    Finfluence: double;
    Fcreativity_rank: integer;
    Ftransfers_in: integer;
    Fdirect_freekicks_text: string;
    Fteam: integer;
    Fdreamteam_count: integer;
    Finfluence_rank_type: integer;
    Fchance_of_playing_next_round: integer;
    Fphoto: string;
    Ftransfers_out_event: integer;
    Fpenalties_order: integer;
    Felement_type: integer;
    Fcost_change_start_fall: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property chance_of_playing_next_round:  integer read Fchance_of_playing_next_round;
    property cost_change_start_fall:        integer read Fcost_change_start_fall;
    property goals_conceded:                integer read Fgoals_conceded;
    property bps:                           integer read Fbps;
    property minutes:                       integer read Fminutes;
    property creativity_rank_type:          integer read Fcreativity_rank_type;
    property direct_freekicks_text:         string  read Fdirect_freekicks_text;
    property first_name:                    string  read Ffirst_name;
    property second_name:                   string  read Fsecond_name;
    property cost_change_event:             integer read Fcost_change_event;
    property transfers_in:                  integer read Ftransfers_in;
    property web_name:                      string  read Fweb_name;
    property creativity_rank:               integer read Fcreativity_rank;
    property ict_index:                     double  read Fict_index;                      // ICT: Influence, Creativity, Threat
    property cost_change_start:             integer read Fcost_change_start;
    property in_dreamteam:                  boolean read Fin_dreamteam;
    property status:                        string  read Fstatus;
    property penalties_saved:               integer read Fpenalties_saved;
    property influence_rank_type:           integer read Finfluence_rank_type;
    property total_points:                  integer read Ftotal_points;
    property chance_of_playing_this_round:  integer read FChance_of_playing_this_round;
    property element_type:                  integer read Felement_type;
    property creativity:                    double  read Fcreativity;
    property yellow_cards:                  integer read Fyellow_cards;
    property influence:                     double  read Finfluence;
    property ict_index_rank:                integer read Fict_index_rank;
    property ep_this:                       double  read Fep_this;
    property ep_next:                       double  read Fep_next;
    property threat_rank_type:              integer read Fthreat_rank_type;
    property threat_rank:                   integer read Fthreat_rank;
    property event_points:                  integer read Fevent_points;
    property transfers_out:                 integer read Ftransfers_out;
    property selected_by_percent:           double  read Fselected_by_percent;
    property penalties_order:               integer read Fpenalties_order;
    property own_goals:                     integer read Fown_goals;
    property direct_freekicks_order:        integer read Fdirect_freekicks_order;
    property team_code:                     integer read Fteam_code;
    property squad_number:                  integer read FSquad_number;
    property transfers_out_event:           integer read Ftransfers_out_event;
    property id:                            integer read Fid;
    property clean_sheets:                  integer read Fclean_sheets;
    property threat:                        double  read Fthreat;
    property red_cards:                     integer read Fred_cards;
    property transfers_in_event:            integer read Ftransfers_in_event;
    property penalties_text:                string  read Fpenalties_text;
    property dreamteam_count:               integer read Fdreamteam_count;
    property special:                       boolean read Fspecial;
    property corners_and_indirect_freekicks_order: integer read Fcorners_and_indirect_freekicks_order;
    property points_per_game:               double  read Fpoints_per_game;
    property saves:                         integer read Fsaves;
    property value_form:                    double  read Fvalue_form;
    property ict_index_rank_type:           integer read Fict_index_rank_type;
    property team:                          integer read Fteam;
    property news:                          string  read Fnews;
    property form:                          double  read Fform;
    property code:                          integer read Fcode;
    property goals_scored:                  integer read Fgoals_scored;
    property corners_and_indirect_freekicks_text: string read Fcorners_and_indirect_freekicks_text;
    property penalties_missed:              integer read Fpenalties_missed;
    property value_season:                  double  read Fvalue_season;
    property influence_rank:                integer read Finfluence_rank;
    property bonus:                         integer read Fbonus;
    property now_cost:                      integer read Fnow_cost;
    property news_added:                    TDateTime read Fnews_added;
    property assists:                       integer read Fassists;
    property photo:                         string  read Fphoto;
    property cost_change_event_fall:        integer read Fcost_change_event_fall;
  end;

  IFPLStaticElements = interface
    function build(aSO: ISuperObject):                    boolean;
    function getStaticElements:                           IReadOnlyList<TFPLStaticElement>;
    function getPlayerName(ix: integer):                  string;
    function getPlayerPhotoID(ix: integer):               integer;
    property Elements:                                    IReadOnlyList<TFPLStaticElement> read getStaticElements;
    property PlayerName[ix: integer]:                     string read getPlayerName; default;
    property PlayerPhotoID[ix: integer]:                  integer read getPlayerPhotoID;
  end;

function FPLStaticElements: IFPLStaticElements;

implementation

uses
  System.SysUtils, XSBuiltIns, Spring, bzFMXUtils;

type
  TFPLStaticElements = class(TInterfacedObject, IFPLStaticElements)
  strict private
    FStaticElements:                IList<TFPLStaticElement>;
  private
    function getElementByID(aID: integer):        TFPLStaticElement;
    function getStaticElements:                   IReadOnlyList<TFPLStaticElement>;
    function getPlayerName(ix: integer):          string;
    function GetPlayerPhotoID(ix: integer):       integer;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):                    boolean;
    property Elements:                                    IReadOnlyList<TFPLStaticElement> read getStaticElements;
    property PlayerName[ix: integer]:                     string read getPlayerName;
    property PlayerPhotoID[ix: integer]:                  integer read GetPlayerPhotoID;
  end;

var gInstance: IFPLStaticElements;

function FPLStaticElements: IFPLStaticElements;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticElements.Create; end;
  result := gInstance;
end;

{ TFPLStaticElements }

function TFPLStaticElements.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLStaticElement;
begin
  FStaticElements.Clear;

  for so in aSO do begin
    rec := TFPLStaticElement.Create('OK');

    rec.Fchance_of_playing_next_round :=   so.I['chance_of_playing_next_round'];
    rec.Fcost_change_start_fall :=         so.I['cost_change_start_fall'];
    rec.Fgoals_conceded :=                 so.I['goals_conceded'];
    rec.Fbps :=                            so.I['bps'];
    rec.Fminutes :=                        so.I['minutes'];
    rec.Fcreativity_rank_type :=           so.I['creativity_rank_type'];
    rec.Fdirect_freekicks_text :=          so.S['direct_freekicks_text'];
    rec.Ffirst_name :=                     so.S['first_name'];
    rec.Fsecond_name :=                    so.S['second_name'];
    rec.Fcost_change_event :=              so.I['cost_change_event'];
    rec.Ftransfers_in :=                   so.I['transfers_in'];
    rec.Fweb_name :=                       so.S['web_name'];
    rec.Fcreativity_rank :=                so.I['creativity_rank'];
    rec.Fict_index :=                      so.D['ict_index'];
    rec.Fcost_change_start :=              so.I['cost_change_start'];
    rec.Fin_dreamteam :=                   so.B['in_dreamteam'];
    rec.Fstatus :=                         so.S['status'];
    rec.Fpenalties_saved :=                so.I['penalties_saved'];
    rec.Finfluence_rank_type :=            so.I['influence_rank_type'];
    rec.Ftotal_points :=                   so.I['total_points'];
    rec.Fchance_of_playing_this_round :=   so.I['Chance_of_playing_this_round'];
    rec.Felement_type :=                   so.I['element_type'];
    rec.Fcreativity :=                     so.D['creativity'];
    rec.Fyellow_cards :=                   so.I['yellow_cards'];
    rec.Finfluence :=                      so.D['influence'];
    rec.Fict_index_rank :=                 so.I['ict_index_rank'];
    rec.Fep_this :=                        so.D['ep_this'];
    rec.Fep_next :=                        so.D['ep_next'];
    rec.Fthreat_rank_type :=               so.I['threat_rank_type'];
    rec.Fthreat_rank :=                    so.I['threat_rank'];
    rec.Fevent_points :=                   so.I['event_points'];
    rec.Ftransfers_out :=                  so.I['transfers_out'];
    rec.Fselected_by_percent :=            so.D['selected_by_percent'];
    rec.Fpenalties_order :=                so.I['penalties_order'];
    rec.Fown_goals :=                      so.I['own_goals'];
    rec.Fdirect_freekicks_order :=         so.I['direct_freekicks_order'];
    rec.Fteam_code :=                      so.I['team_code'];
    rec.Fsquad_number :=                   so.I['Squad_number'];
    rec.Ftransfers_out_event :=            so.I['transfers_out_event'];
    rec.Fid :=                             so.I['id'];
    rec.Fclean_sheets :=                   so.I['clean_sheets'];
    rec.Fthreat :=                         so.D['threat'];
    rec.Fred_cards :=                      so.I['red_cards'];
    rec.Ftransfers_in_event :=             so.I['transfers_in_event'];
    rec.Fpenalties_text :=                 so.S['penalties_text'];
    rec.Fdreamteam_count :=                so.I['dreamteam_count'];
    rec.Fspecial :=                        so.B['special'];
    rec.Fcorners_and_indirect_freekicks_order :=  so.I['corners_and_indirect_freekicks_order'];
    rec.Fpoints_per_game :=                so.D['points_per_game'];
    rec.Fsaves :=                          so.I['saves'];
    rec.Fvalue_form :=                     so.D['value_form'];
    rec.Fict_index_rank_type :=            so.I['ict_index_rank_type'];
    rec.Fteam :=                           so.I['team'];
    rec.Fnews :=                           so.S['news'];
    rec.Fform :=                           so.D['form'];
    rec.Fcode :=                           so.I['code'];
    rec.Fgoals_scored :=                   so.I['goals_scored'];
    rec.Fcorners_and_indirect_freekicks_text :=  so.S['corners_and_indirect_freekicks_text'];
    rec.Fpenalties_missed :=               so.I['penalties_missed'];
    rec.Fvalue_season :=                   so.D['value_season'];
    rec.Finfluence_rank :=                 so.I['influence_rank'];
    rec.Fbonus :=                          so.I['bonus'];
    rec.Fnow_cost :=                       so.I['now_cost'];
    rec.Fnews_added :=                     XMLTimeToDateTime(so.S['news_added'], FALSE);
    rec.Fassists :=                        so.I['assists'];
    rec.Fphoto :=                          so.S['photo'];
    rec.Fcost_change_event_fall :=         so.I['cost_change_event_fall'];

    FStaticElements.Add(rec);
  end;
end;

constructor TFPLStaticElements.Create;
begin
  inherited;
  FStaticElements := TCollections.CreateObjectList<TFPLStaticElement>(TRUE);
end;

destructor TFPLStaticElements.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLStaticElements.getElementByID(aID: integer): TFPLStaticElement;
var
  pred: TPredicate<TFPLStaticElement>;
begin
  pred := function(const aFPL: TFPLStaticElement): boolean  begin
                                                              result := aFPL.id = aID;
                                                            end;
  result := FStaticElements.Where(pred).First;
end;

function TFPLStaticElements.GetPlayerPhotoID(ix: integer): integer;
var
  vPhoto: string;
begin
  vPhoto    := getElementByID(ix).photo;
  result    := getFilenameWithoutExt(vPhoto).ToInteger; // "photo":"78830.jpg" - the JSON says .jpg, but all the URLs have .png
end;

function TFPLStaticElements.getPlayerName(ix: integer): string;
begin
  var vFPL := getElementByID(ix);
  result := vFPL.first_name + ' ' + vFPL.second_name;
end;

function TFPLStaticElements.getStaticElements: IReadOnlyList<TFPLStaticElement>;
begin
  result := FStaticElements.AsReadOnlyList;
end;

{ TFPLStaticElement }

constructor TFPLStaticElement.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLStaticElement.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
