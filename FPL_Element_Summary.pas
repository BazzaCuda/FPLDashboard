unit FPL_Element_Summary;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLHistoryPast = class
  private
    Fgoals_scored: integer;
    Fcreativity: double;
    Fsaves: integer;
    Fbonus: integer;
    Fseason_name: string;
    Fpenalties_missed: integer;
    Fclean_sheets: integer;
    Fstart_cost: integer;
    Fassists: integer;
    Fthreat: double;
    Fpenalties_saved: integer;
    Fyellow_cards: integer;
    Fict_index: double;
    Fminutes: integer;
    Fown_goals: integer;
    Felement_code: integer;
    Fend_cost: integer;
    Fred_cards: integer;
    Ftotal_points: integer;
    Fbps: integer;
    Fgoals_conceded: integer;
    Finfluence: double;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property season_name:                             string        read Fseason_name;
    property goals_conceded:                          integer       read Fgoals_conceded;
    property bps:                                     integer       read Fbps;
    property minutes:                                 integer       read Fminutes;
    property ict_index:                               double        read Fict_index;
    property start_cost:                              integer       read Fstart_cost;
    property penalties_saved:                         integer       read Fpenalties_saved;
    property total_points:                            integer       read Ftotal_points;
    property creativity:                              double        read Fcreativity;
    property yellow_cards:                            integer       read Fyellow_cards;
    property element_code:                            integer       read Felement_code;
    property influence:                               double        read Finfluence;
    property own_goals:                               integer       read Fown_goals;
    property clean_sheets:                            integer       read Fclean_sheets;
    property threat:                                  double        read Fthreat;
    property end_cost:                                integer       read Fend_cost;
    property red_cards:                               integer       read Fred_cards;
    property saves:                                   integer       read Fsaves;
    property goals_scored:                            integer       read Fgoals_scored;
    property penalties_missed:                        integer       read Fpenalties_missed;
    property bonus:                                   integer       read Fbonus;
    property assists:                                 integer       read Fassists;
  end;

  TFPLHistory = class
  private
    Fgoals_scored: integer;
    Fcreativity: double;
    Fsaves: integer;
    Fbonus: integer;
    Fpenalties_missed: integer;
    Fclean_sheets: integer;
    Fassists: integer;
    Fround: integer;
    Fthreat: double;
    Fpenalties_saved: integer;
    Fwas_home: boolean;
    Fkickoff_time: TDateTime;
    Fyellow_cards: integer;
    Fict_index: double;
    Fminutes: integer;
    Fteam_h_score: integer;
    Ftransfers_balance: integer;
    Fown_goals: integer;
    Fred_cards: integer;
    Ftransfers_out: integer;
    Felement: integer;
    Fteam_a_score: integer;
    Fvalue: integer;
    Ftotal_points: integer;
    Fbps: integer;
    Fgoals_conceded: integer;
    Fselected: integer;
    Fopponent_team: integer;
    Finfluence: double;
    Ftransfers_in: integer;
    Ffixture: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property team_h_score:                            integer       read Fteam_h_score;
    property goals_conceded:                          integer       read Fgoals_conceded;
    property bps:                                     integer       read Fbps;
    property fixture:                                 integer       read Ffixture;
    property minutes:                                 integer       read Fminutes;
    property transfers_in:                            integer       read Ftransfers_in;
    property ict_index:                               double        read Fict_index;
    property kickoff_time:                            TDateTime     read Fkickoff_time;
    property penalties_saved:                         integer       read Fpenalties_saved;
    property element:                                 integer       read Felement;
    property total_points:                            integer       read Ftotal_points;
    property creativity:                              double        read Fcreativity;
    property yellow_cards:                            integer       read Fyellow_cards;
    property influence:                               double        read Finfluence;
    property selected:                                integer       read Fselected;
    property transfers_out:                           integer       read Ftransfers_out;
    property own_goals:                               integer       read Fown_goals;
    property was_home:                                boolean       read Fwas_home;
    property value:                                   integer       read Fvalue;
    property team_a_score:                            integer       read Fteam_a_score;
    property clean_sheets:                            integer       read Fclean_sheets;
    property threat:                                  double        read Fthreat;
    property red_cards:                               integer       read Fred_cards;
    property transfers_balance:                       integer       read Ftransfers_balance;
    property saves:                                   integer       read Fsaves;
    property opponent_team:                           integer       read Fopponent_team;
    property goals_scored:                            integer       read Fgoals_scored;
    property penalties_missed:                        integer       read Fpenalties_missed;
    property round:                                   integer       read Fround;
    property bonus:                                   integer       read Fbonus;
    property assists:                                 integer       read Fassists;
  end;

  TFPLFixture = class
  private
    Fdifficulty: integer;
    Ffinished: boolean;
    Fcode: integer;
    Fis_home: boolean;
    Fkickoff_time: TDateTime;
    Fevent_name: string;
    Fminutes: integer;
    Fteam_h_score: integer;
    Fid: integer;
    Fprovisional_start_time: boolean;
    Fteam_h: integer;
    Fteam_a_score: integer;
    Fevent: integer;
    Fteam_a: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property team_h_score:                            integer       read Fteam_h_score;
    property minutes:                                 integer       read Fminutes;
    property event_name:                              string        read Fevent_name;
    property kickoff_time:                            TDateTime     read Fkickoff_time;
    property finished:                                boolean       read Ffinished;
    property provisional_start_time:                  boolean       read Fprovisional_start_time;
    property team_a_score:                            integer       read Fteam_a_score;
    property id:                                      integer       read Fid;
    property is_home:                                 boolean       read Fis_home;
    property event:                                   integer       read Fevent;
    property code:                                    integer       read Fcode;
    property team_h:                                  integer       read Fteam_h;
    property team_a:                                  integer       read Fteam_a;
    property difficulty:                              integer       read Fdifficulty;
  end;

  IFPLElementSummary = interface
    function build(aSO: ISuperObject):  boolean;
    function getFixtures:                  IReadOnlyList<TFPLFixture>;
    function getHistoryPasts:              IReadOnlyList<TFPLHistoryPast>;
    function getHistorys:                  IReadOnlyList<TFPLHistory>;
    property fixtures:                     IReadOnlyList<TFPLFixture>        read getFixtures;
    property historyPasts:                 IReadOnlyList<TFPLHistoryPast>    read getHistoryPasts;
    property historys:                     IReadOnlyList<TFPLHistory>        read getHistorys;
  end;

function FPLElementSummary: IFPLElementSummary;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLElementSummary = class(TInterfacedObject, IFPLElementSummary)
  strict private
    FFixtures:      IList<TFPLFixture>;
    FHistoryPasts:  IList<TFPLHistoryPast>;
    FHistorys:      IList<TFPLHistory>;
  private
    function getFixtures:      IReadOnlyList<TFPLFixture>;
    function getHistoryPasts:  IReadOnlyList<TFPLHistoryPast>;
    function getHistorys:      IReadOnlyList<TFPLHistory>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property entry:                     IReadOnlyList<TFPLFixture>      read getFixtures;
    property subs:                      IReadOnlyList<TFPLHistoryPast>  read getHistoryPasts;
    property picks:                     IReadOnlyList<TFPLHistory>      read getHistorys;
  end;

var gInstance: IFPLElementSummary;

function FPLElementSummary: IFPLElementSummary;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLElementSummary.Create; end;
  result := gInstance;
end;

{ TFPLPicks }

function TFPLElementSummary.build(aSO: ISuperObject): boolean;
var
  rec:   TFPLFixture;
  recH:  TFPLHistory;
  recHP: TFPLHistoryPast;
begin
  FHistoryPasts.Clear;
  FHistorys.Clear;
  FFixtures.Clear;

  for var fixture in aSO['fixtures'] do begin
    rec                         := TFPLFixture.Create('OK');
    rec.Fdifficulty             := fixture.I['difficulty'];
    rec.Ffinished               := fixture.B['finished'];
    rec.Fcode                   := fixture.I['code'];
    rec.Fis_home                := fixture.B['is_home'];
    rec.Fkickoff_time           := XMLTimeToDateTime(fixture.S['kickoff_time']);
    rec.Fevent_name             := fixture.S['event_name'];
    rec.Fminutes                := fixture.I['minutes'];
    rec.Fteam_h_score           := fixture.I['team_h_score'];
    rec.Fid                     := fixture.I['id'];
    rec.Fprovisional_start_time := fixture.B['provisional_start_time'];
    rec.Fteam_h                 := fixture.I['team_h'];
    rec.Fteam_a_score           := fixture.I['team_a_score'];
    rec.Fevent                  := fixture.I['event'];
    rec.Fteam_a                 := fixture.I['team_a'];
    FFixtures.Add(rec);
  end;

  for var history in aSO['history'] do begin
    recH                        := TFPLHistory.Create('OK');
    recH.Fgoals_scored            := history.I['goals_scored'];
    recH.Fcreativity              := history.D['creativity'];
    recH.Fsaves                   := history.I['saves'];
    recH.Fbonus                   := history.I['bonus'];
    recH.Fpenalties_missed        := history.I['penalties_missed'];
    recH.Fclean_sheets            := history.I['clean_sheets'];
    recH.Fassists                 := history.I['assists'];
    recH.Fround                   := history.I['round'];
    recH.Fthreat                  := history.D['threat'];
    recH.Fpenalties_saved         := history.I['penalties_saved'];
    recH.Fwas_home                := history.B['was_home'];
    recH.Fkickoff_time            := XMLTimeToDateTime(history.S['kickoff_time']);
    recH.Fyellow_cards            := history.I['yellow_cards'];
    recH.Fict_index               := history.D['ict_index'];
    recH.Fminutes                 := history.I['minutes'];
    recH.Fteam_h_score            := history.I['team_h_score'];
    recH.Ftransfers_balance       := history.I['transfers_balance'];
    recH.Fown_goals               := history.I['own_goals'];
    recH.Fred_cards               := history.I['red_cards'];
    recH.Ftransfers_out           := history.I['transfers_out'];
    recH.Felement                 := history.I['element'];
    recH.Fteam_a_score            := history.I['team_a_score'];
    recH.Fvalue                   := history.I['value'];
    recH.Ftotal_points            := history.I['total_points'];
    recH.Fbps                     := history.I['bps'];
    recH.Fgoals_conceded          := history.I['goals_conceded'];
    recH.Fselected                := history.I['selected'];
    recH.Fopponent_team           := history.I['opponent_team'];
    recH.Finfluence               := history.D['influence'];
    recH.Ftransfers_in            := history.I['transfers_in'];
    recH.Ffixture                 := history.I['fixture'];
    FHistorys.Add(recH);
  end;


  for var past in aSO['history_past'] do begin
    recHP                   := TFPLHistoryPast.Create('OK');
    recHP.Fseason_name      := past.S['season_name'];
    recHP.Fgoals_conceded   := past.I['goals_conceded'];
    recHP.Fbps              := past.I['bps'];
    recHP.Fminutes          := past.I['minutes'];
    recHP.Fict_index        := past.D['ict_index'];
    recHP.Fstart_cost       := past.I['start_cost'];
    recHP.Fpenalties_saved  := past.I['penalties_saved'];
    recHP.Ftotal_points     := past.I['total_points'];
    recHP.Fcreativity       := past.D['creativity'];
    recHP.Fyellow_cards     := past.I['yellow_cards'];
    recHP.Felement_code     := past.I['element_code'];
    recHP.Finfluence        := past.D['influence'];
    recHP.Fown_goals        := past.I['own_goals'];
    recHP.Fclean_sheets     := past.I['clean_sheets'];
    recHP.Fthreat           := past.D['threat'];
    recHP.Fend_cost         := past.I['end_cost'];
    recHP.Fred_cards        := past.I['red_cards'];
    recHP.Fsaves            := past.I['saves'];
    recHP.Fgoals_scored     := past.I['goals_scored'];
    recHP.Fpenalties_missed := past.I['penalties_missed'];
    recHP.Fbonus            := past.I['bonus'];
    recHP.Fassists          := past.I['assists'];
    FHistoryPasts.Add(recHP);
  end;
end;

constructor TFPLElementSummary.Create;
begin
  inherited Create;
  FFixtures     := TCollections.CreateObjectList<TFPLFixture>(TRUE);
  FHistorys     := TCollections.CreateObjectList<TFPLHistory>(TRUE);
  FHistoryPasts := TCollections.CreateObjectList<TFPLHistoryPast>(TRUE);
end;

destructor TFPLElementSummary.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLElementSummary.getFixtures: IReadOnlyList<TFPLFixture>;
begin
  result := FFixtures.AsReadOnlyList;
end;

function TFPLElementSummary.getHistoryPasts: IReadOnlyList<TFPLHistoryPast>;
begin
  result := FHistoryPasts.AsReadOnlyList;
end;

function TFPLElementSummary.getHistorys: IReadOnlyList<TFPLHistory>;
begin
  result := FHistorys.AsReadOnlyList;
end;

{ TFPLHistoryPast }

constructor TFPLHistoryPast.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

constructor TFPLHistoryPast.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

{ TFPLHistory }

constructor TFPLHistory.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLHistory.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

{ TFPLFixture }

constructor TFPLFixture.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLFixture.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
