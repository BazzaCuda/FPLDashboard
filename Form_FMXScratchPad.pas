unit Form_FMXScratchPad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  SuperObject, FMX.StdCtrls;

type
  TFormFMXScratchPad = class(TForm)
    Memo: TMemo;
    Image: TImage;
    procedure FormActivate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
  strict private
    json: ISuperObject;
    procedure log(const aString: string = ''; beginUpdate: boolean = FALSE);
    procedure logTop;

    procedure Report_Element_Summary;
    procedure Report_Fixtures;
    procedure Report_Gameweek;
    procedure Report_History;
    procedure Report_League;
    procedure Report_Picks;
    procedure Report_MyTeam;
    procedure Report_Static_Game_Settings;
    procedure Report_Static_Element_Types;
    procedure Report_Static_Elements;
    procedure Report_Static_Element_Stats;
    procedure Report_Static_Events;
    procedure Report_Static_Phases;
    procedure Report_Static_Total_Players;
    procedure Report_Static_Teams;
    procedure Report_TID_Entry;
    procedure Report_Transfers;

    procedure Report_Static_Element;

    procedure processJSON;
    procedure ProcessObject(const aAsObject: TSuperTableString; const aPrefix: string = ''; aPrefixFilter: string = ''; aNameFilter: string = ''; propertyDef: boolean = FALSE);
  private
  public
  end;

var
  FormFMXScratchPad: TFormFMXScratchPad;

implementation

uses
  FPL_JSON, FPL_Internet, FPL_Static_Element_Types, FPL_Static_Events, FPL_Static_Elements, FPL_Static_Teams, FPL_Static_Game_Settings,
  FPL_Static_Total_Players, FPL_Static_Phases, FPL_TID_Entry, FPL_Gameweek, FPL_Fixtures, FPL_History, FPL_Transfers, FPL_Picks, FPL_League,
  FPL_Element_Summary, FPL_Images, bzFMXUtils;


{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

{ TFormFMXScratchPad }

procedure TFormFMXScratchPad.FormActivate(Sender: TObject);
begin
  processJSON;
end;

procedure TFormFMXScratchPad.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
//  caption := format('X: %d, Y: %d', [left, top]);
end;

procedure TFormFMXScratchPad.log(const aString: string = ''; beginUpdate: boolean = FALSE);
begin
  case beginUpdate of TRUE: memo.lines.BeginUpdate; end;
  memo.Lines.Add(aString);
end;

procedure TFormFMXScratchPad.logTop;
begin
  memo.Lines.EndUpdate;
  Memo.SelStart := 0;
//  SendMessage(Memo.Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TFormFMXScratchPad.processJSON;
label
  SKIP;
begin
  log('', TRUE);
  try
//    json := FPLJson.fetchFPLStatic;
//    FPLJson.fetchFPLStaticToFile(getExePath + 'json\');
    json := FPLJSON.fetchFPLJsonFromFile(getExePath + 'json\FPLStatic.json');

    FPLStaticElementTypes.build(FPLJson.FPLStaticElementTypes(json));
    Report_Static_Element_Types;

    FPLStaticEvents.build(FPLJson.FPLStaticEvents(json));
    Report_Static_Events;

    FPLStaticElements.build(FPLJson.FPLStaticElements(json));
    Report_Static_Elements;
    Report_Static_Element;

    FPLStaticTeams.build(FPLJson.FPLStaticTeams(json));
    Report_Static_Teams;

    Report_Static_Element_Stats; // redundant;

    FPLStaticGameSettings.build(FPLJson.FPLStaticGameSettings(json));
    Report_Static_Game_Settings;

    FPLStaticTotalPlayers.build(FPLJson.FPLStaticTotalPlayers(json));
    Report_Static_Total_Players;

    FPLStaticPhases.build(FPLJson.FPLStaticPhases(json));
    Report_Static_Phases;

//    FPLJson.fetchFPLTIDEntryToFile(622325, getExePath + 'json\');
//    json := FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLEntry622325.json');
//    FPLTIDEntry.build(json);
//    FPLTIDEntry.build(FPLJson.fetchFPLTIDEntry(622325));
//    json := FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLEntry622325.json');
    FPLTIDEntry.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLEntry622325.json'));
    Report_TID_Entry;

//    FPLJson.fetchFPLGameweekToFile(i, getExePath + 'json\');
//    FPLGameweek.build(FPLJson.fetchFPLGameweek(32));
//    processObject(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLgameweek31.json').AsObject, '', '', 'identifier', FALSE);
//    for var i := 1 to 33 do begin
//    FPLGameweek.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLgameweek' + i.ToString + '.json'));
    Report_GameWeek;

//    FPLFixtures.build(FPLJson.fetchFPLFixtures(32));
//    FPLJson.fetchFPLFixturesToFile(getExePath + 'json\', i);
    FPLFixtures.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLFixtures-Gameweek2.json'));
    Report_Fixtures;

//    json := TSuperObject.ParseFile(getExePath + 'json\FPLHistoryMarshy.json', TRUE);
//    json := FPLJson.fetchFPLHistory(622325);
//    FPLJson.fetchFPLHistoryToFile(622325, getExePath + 'json\');
//    FPLHistory.build(FPLJson.fetchFPLHistory(622325));
    FPLHistory.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLHistoryMarshy.json'));
    Report_History;

//    FPLJson.fetchFPLTransfersToFile(4206643, getExePath + 'json\');
//    json := FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLtransfers-4206643.json');
//    FPLTransfers.build(json);
//    FPLTransfers.build(FPLJson.fetchFPLTransfers(4206643));
    FPLTransfers.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLtransfers-4206643.json'));
    Report_Transfers;

//    json := TSuperObject.ParseFile(getExePath + 'json\FPLpicks.json', TRUE);
//    FPLJson.fetchFPLPicksToFile(4206643, 30, getExePath + 'json\');
//    json := FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLPicks.json'); // no subs
//    FPLPicks.build(FPLJson.fetchFPLPicks(4206643, 32));
    FPLPicks.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLPicks-4206643-30.json')); // with subs
    Report_Picks;

//    FPLJson.fetchFPLLeagueToFile(135442, getExePath + 'json\');
//    FPLLeagues.build(FPLJson.fetchFPLLeague(314));
    FPLLeagues.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLLeague-135442.json'));
    Report_League;

//    FPLjson.fetchFPLElementSummaryToFile(388, 'B:\Win64_Dev\Programs\FPLDashboard\');
    FPLElementSummary.build(FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLElementSummary-388.json'));
    Report_Element_Summary;

//    FPLJson.fetchFPLMyTeamToFile(4206643, getExePath + 'json\');
//    json := FPLJson.fetchFPLJsonFromFile(getExePath + 'json\FPLMyTeam-4206643-chrome.json');
//    log(FPLHttp.login);
//      RestRequest;
//    Report_MyTeam;

  //  ProcessObject(json.AsObject);
  //  ProcessObject(json.AsObject, '', TRUE, 'game_settings');
  finally
    logtop;
  end;
end;

procedure TFormFMXScratchPad.Report_TID_Entry;
// https://fantasy.premierleague.com/api/entry/4206643/
// add {"entry":[  and ]}
begin
  EXIT;
  log('ENTRY'#13#10);

  for var en in FPLTIDEntry.Entrys do begin
    log('id: '                            + en.id.ToString);
    log('name: '                          + en.name);
    log('player_first_name: '             + en.player_first_name);
    log('player_last_name: '              + en.player_last_name);
    log('player_region_iso_code_short: '  + en.player_region_iso_code_short);
    log('summary_event_points: '          + en.summary_event_points.ToString);
    log('current_event: '                 + en.current_event.ToString);
    log('started_event: '                 + en.started_event.ToString);
    log('summary_overall_rank: '          + en.summary_overall_rank.ToString);
    log('last_deadline_bank: '            + en.last_deadline_bank.ToString);
    log('player_region_name: '            + en.player_region_name);
    log('last_deadline_total_transfers: ' + en.last_deadline_total_transfers.ToString);
    log('player_region_id: '              + en.player_region_iso_code_short);
    log('favourite_team: '                + en.favourite_team);
    log('summary_overall_points: '        + en.summary_event_points.ToString);
    log('player_region_iso_code_long: '   + en.player_region_iso_code_short);
    log('last_deadline_value: '           + en.last_deadline_value.ToString);
    log('summary_event_rank: '            + en.summary_event_rank.ToString);
    log('joined_time: '                   + DateTimeToStr(en.joined_time));

    log('kit_socks_type: '                 + en.kit_socks_type);
    log('kit_socks_base: '                 + en.kit_socks_base);
    log('kit_shirt_sleeves: '              + en.kit_shirt_sleeves);
    log('kit_socks_secondary: '            + en.kit_socks_secondary);
    log('kit_shirt_type: '                 + en.kit_socks_secondary);
    log('kit_shirt_logo: '                 + en.kit_socks_secondary);
    log('kit_shirt_base: '                 + en.kit_shirt_base);
    log('kit_shorts: '                     + en.kit_shorts);
    log('kit_shirt_secondary: '            + en.kit_shirt_secondary);
    log;
  end;

  for var en in FPLTIDEntry.Entrys do
    for var le in en.leagues_h2h do begin
      log('H2H:');
      log('entry_rank: '          + le.entry_rank.ToString);
      log('has_cup: '             + YesOrNo(le.has_cup));
      log('entry_can_invite: '    + YesOrNo(le.entry_can_invite));
      log('start_event: '         + le.start_event.ToString);
      log('short_name: '          + le.short_name);
      log('cup_qualified: '       + YesOrNo(le.cup_qualified));
      log('scoring: '             + le.scoring);
      log('created: '             + DateTimeToStr(le.created));
      log('cup_league: '          + le.cup_league.ToString);
      log('id: '                  + le.id.ToString);
      log('entry_can_admin: '     + YesOrNo(le.entry_can_admin));
      log('max_entries: '         + le.max_entries.ToString);
      log('admin_entry: '         + le.admin_entry.ToString);
      log('entry_last_rank: '     + le.entry_last_rank.ToString);
      log('rank: '                + le.rank.ToString);
      log('name: '                + le.name);
      log('closed: '              + YesOrNo(le.closed));
      log('league_type: '         + le.league_type);
      log('entry_can_leave: '     + YesOrNo(le.entry_can_leave));
      log;
    end;

  for var en in FPLTIDEntry.Entrys do
    for var le in en.leagues_classic do begin
      log('CLASSIC:');
      log('entry_rank: '          + le.entry_rank.ToString);
      log('has_cup: '             + YesOrNo(le.has_cup));
      log('entry_can_invite: '    + YesOrNo(le.entry_can_invite));
      log('start_event: '         + le.start_event.ToString);
      log('short_name: '          + le.short_name);
      log('cup_qualified: '       + YesOrNo(le.cup_qualified));
      log('scoring: '             + le.scoring);
      log('created: '             + DateTimeToStr(le.created));
      log('cup_league: '          + le.cup_league.ToString);
      log('id: '                  + le.id.ToString);
      log('entry_can_admin: '     + YesOrNo(le.entry_can_admin));
      log('max_entries: '         + le.max_entries.ToString);
      log('admin_entry: '         + le.admin_entry.ToString);
      log('entry_last_rank: '     + le.entry_last_rank.ToString);
      log('rank: '                + le.rank.ToString);
      log('name: '                + le.name);
      log('closed: '              + YesOrNo(le.closed));
      log('league_type: '         + le.league_type);
      log('entry_can_leave: '     + YesOrNo(le.entry_can_leave));
      log;
    end;

  for var en in FPLTIDEntry.Entrys do
    for var le in en.leagues_cup_matches do begin
      log('CUPMATCH:');
      log('entry_1_entry: '             + le.entry_1_entry.ToString);
      log('entry_1_player_name: '       + le.entry_1_player_name);
      log('entry_1_name: '              + le.entry_1_name);
      log('entry_1_win: '               + le.entry_1_win.ToString);
      log('entry_1_total: '             + le.entry_1_total.ToString);
      log('entry_1_loss: '              + le.entry_1_loss.ToString);
      log('entry_1_draw: '              + le.entry_1_draw.ToString);
      log('entry_1_points: '            + le.entry_1_points.ToString);
      log('entry_2_entry: '             + le.entry_2_entry.ToString);
      log('entry_2_player_name: '       + le.entry_2_player_name);
      log('entry_2_name: '              + le.entry_2_name);
      log('entry_2_win: '               + le.entry_2_win.ToString);
      log('entry_2_total: '             + le.entry_2_total.ToString);
      log('entry_2_loss: '              + le.entry_2_loss.ToString);
      log('entry_2_draw: '              + le.entry_2_draw.ToString);
      log('entry_2_points: '            + le.entry_2_points.ToString);
      log('id: '                        + le.id.ToString);
      log('event: '                     + le.event.ToString);
      log('winner: '                    + le.winner.ToString);
      log('is_knockout: '               + YesOrNo(le.is_knockout));
      log('tiebreak: '                  + le.tiebreak);
      log('seed_value: '                + le.seed_value);
      log;
    end;

  log('ENTRY');
end;

procedure TFormFMXScratchPad.Report_Transfers;
// https://fantasy.premierleague.com/api/entry/TID/transfers/
begin
  EXIT;
  log('TRANSFERS'#13#10);

  for var transfer in FPLTransfers.Transfers do begin
    log('transfer:');
    log('entry: '             + transfer.entry.ToString);
    log('event: '             + transfer.event.ToString);
    log('time: '              + DateTimeToStr(transfer.time));
    log('element_out: '       + transfer.element_out.ToString);
    log('element_out_cost: '  + transfer.element_out_cost.ToString);
    log('element_in: '        + transfer.element_in.ToString);
    log('element_in_cost: '   + transfer.element_in_cost.ToString);
    log;
  end;

  log('TRANSFERS');
end;

procedure TFormFMXScratchPad.Report_Static_Element;
begin
//  EXIT;
  log('ELEMENT'#13#10);

  log(FPLStaticElements.PlayerName[388]);
  var vPhotoID := FPLStaticElements.PlayerPhotoID[388];
  FPLImages.fetch250x250Photo(vPhotoID, image.Bitmap);
  log;

  log ('ELEMENT');
end;

procedure TFormFMXScratchPad.Report_Static_Elements;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('ELEMENTS'#13#10);

  for var element in FPLStaticElements.Elements do begin
    log('element:');
//      case element.id = 388 of FALSE: CONTINUE; end;
    log('id: ' + element.id.ToString);
    log('chance_of_playing_next_round: ' + element.chance_of_playing_next_round.ToString);
    log('cost_change_start_fall: ' + element.cost_change_start_fall.ToString);
    log('goals_conceded: ' + element.goals_conceded.ToString);
    log('bps: ' + element.bps.ToString);
    log('minutes: ' + element.minutes.ToString);
    log('creativity_rank_type: ' + element.creativity_rank_type.ToString);
    log('direct_freekicks_text: ' + element.direct_freekicks_text);
    log('first_name: ' + element.first_name);
    log('second_name: ' + element.second_name);
    log('cost_change_event: ' + element.cost_change_event.ToString);
    log('transfers_in: ' + element.transfers_in.ToString);
    log('web_name: ' + element.web_name);
    log('creativity_rank: ' + element.creativity_rank.ToString);
    log('ict_index: ' + format('%.1f', [element.ict_index]));
    log('cost_change_start: ' + element.cost_change_start.ToString);
    log('in_dreamteam: ' + YesOrNo(element.in_dreamteam));
    log('status: ' + element.status);
    log('penalties_saved: ' + element.penalties_saved.ToString);
    log('influence_rank_type: ' + element.influence_rank_type.ToString);
    log('total_points: ' + element.total_points.ToString);
    log('chance_of_playing_this_round: ' + element.chance_of_playing_this_round.ToString);
    log('element_type: ' + element.element_type.ToString);
    log('creativity: ' + format('%.1f', [element.creativity]));
    log('yellow_cards: ' + element.yellow_cards.ToString);
    log('influence: ' + format('%.1f', [element.influence]));
    log('ict_index_rank: ' + element.ict_index_rank.ToString);
    log('ep_this: ' + format('%.1f', [element.ep_this]));
    log('ep_next: ' + format('%.1f', [element.ep_next]));
    log('threat_rank_type: ' + element.threat_rank_type.ToString);
    log('threat_rank: ' + element.threat_rank.ToString);
    log('event_points: ' + element.event_points.ToString);
    log('transfers_out: ' + element.transfers_out.ToString);
    log('selected_by_percent: ' + format('%.1f', [element.selected_by_percent]));
    log('penalties_order: ' + element.penalties_order.ToString);
    log('own_goals: ' + element.own_goals.ToString);
    log('direct_freekicks_order: ' + element.direct_freekicks_order.ToString);
    log('team_code: ' + element.team_code.ToString);
    log('squad_number: ' + element.squad_number.ToString);
    log('transfers_out_event: ' + element.transfers_out_event.ToString);
    log('clean_sheets: ' + element.clean_sheets.ToString);
    log('threat: ' + format('%.1f', [element.threat]));
    log('red_cards: ' + element.red_cards.ToString);
    log('transfers_in_event: ' + element.transfers_in_event.ToString);
    log('penalties_text: ' + element.penalties_text);
    log('dreamteam_count: ' + element.dreamteam_count.ToString);
    log('special: ' + YesOrNo(element.special));
    log('corners_and_indirect_freekicks_order: ' + element.corners_and_indirect_freekicks_order.ToString);
    log('points_per_game: ' + element.points_per_game.ToString);
    log('saves: ' + element.saves.ToString);
    log('value_form: ' + format('%.1f', [element.value_form]));
    log('ict_index_rank_type: ' + element.ict_index_rank_type.ToString);
    log('team: ' + element.team.ToString);
    log('news: ' + element.news);
    log('form: ' + format('%.1f', [element.form]));
    log('code: ' + element.code.ToString);
    log('goals_scored: ' + element.goals_scored.ToString);
    log('corners_and_indirect_freekicks_text: ' + element.corners_and_indirect_freekicks_text);
    log('penalties_missed: ' + element.penalties_missed.ToString);
    log('value_season: ' + format('%.1f', [element.value_season]));
    log('influence_rank: ' + element.influence_rank.ToString);
    log('bonus: ' + element.bonus.ToString);
    log('now_cost: ' + element.now_cost.ToString);
    log('news_added: ' + DateTimeToStr(element.news_added));
    log('assists: ' + element.assists.ToString);
    log('photo: ' + element.photo);
    log('cost_change_event_fall: ' + element.cost_change_event_fall.ToString);
    log;
//    BREAK;
  end;

  log('ELEMENTS');
end;

procedure TFormFMXScratchPad.Report_Static_Element_Stats;
// https://fantasy.premierleague.com/api/bootstrap-static/
var
  oj: ISuperObject;
begin
  EXIT;
  log('ELEMENT_STATS'#13#10);

  for oj in json.O['element_stats'] do begin
    log(oj.AsString);
    log(oj['label'].AsString);
    log(oj['name'].AsString);
  end;

  log('ELEMENT_STATS');
end;

procedure TFormFMXScratchPad.Report_Static_Element_Types;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('ELEMENT_TYPES'#13#10);

  for var et in FPLStaticElementTypes.ElementTypes do begin
    log('ID: '                    + et.id.ToString);
    log('plural_name: '           + et.plural_name);
    log('plural_name_short: '     + et.plural_name_short);
    log('singular_name: '         + et.singular_name);
    log('singular_name_short: '   + et.singular_name_short);
    log('squad_select: '          + et.squad_select.ToString);
    log('squad_min_play: '        + et.squad_min_play.ToString);
    log('squad_max_play: '        + et.squad_max_play.ToString);
    log('ui_shirt_specific: '     + YesOrNo(et.ui_shirt_specific));
    log('sub_positions_locked: '  + et.sub_positions_locked);
    log('element_count: '         + et.element_count.ToString);
    log;
  end;

  log('ELEMENT_TYPES');
end;

procedure TFormFMXScratchPad.Report_Static_Events;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('EVENTS'#13#10);

  for var ev in FPLStaticEvents.Events do begin
//      if ev.id <> 1 then CONTINUE;
    log('event: ');
    log('ID: '                        + ev.id.ToString);
    log('name: '                      + ev.name);
    log('average_entry_score: '       + ev.average_entry_score.ToString);
    log('deadline_time_game_offset: ' + ev.deadline_time_game_offset.ToString);
    log('data_checked: '              + YesOrNo(ev.data_checked));
    log('most_captained: '            + ev.most_captained.ToString);
    log('most_selected: '             + ev.most_selected.ToString);
    log('transfers_made: '            + ev.transfers_made.ToString);
    log('finished: '                  + YesOrNo(ev.finished));
    log('top_element: '               + ev.top_element.ToString);

    log('No of chip types: ' + ev.chip_plays.Count.ToString);
    for var chipPlay in ev.chip_plays do begin
      log('chip_name: '               + chipPlay.chip_name);
      log('num_played: '              + chipPlay.num_played.ToString);
    end;

    log('highest_score: '             + ev.highest_score.ToString);
    log('deadline_time_epoch: '       + ev.deadline_time_epoch.ToString);
    log('most_vice_captained: '       + ev.most_vice_captained.ToString);
    log('deadline_time: '             + DateTimeToStr(ev.deadline_time));
    log('is_next: '                   + YesOrNo(ev.is_next));
    log('top_element ID: '            + ev.top_element_info_ID.ToString);
    log('top_element Points: '        + ev.top_element_info_Points.ToString);
    log('is_current: '                + YesOrNo(ev.is_current));
    log('highest_scoring_entry: '     + ev.highest_scoring_entry.ToString);
    log('is_previous: '               + YesOrNo(ev.is_previous));
    log;
  end;

  log('EVENTS');
end;

procedure TFormFMXScratchPad.Report_Static_Game_Settings;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('GAME_SETTINGS'#13#10);

  var gs := FPLStaticGameSettings.GameSettings;
  log('league_join_private_max: ' + gs.league_join_private_max.ToString);
  log('league_join_public_max: ' + gs.league_join_public_max.ToString);
  log('league_max_size_public_classic: ' + gs.league_max_size_public_classic.ToString);
  log('league_max_size_public_h2h: ' + gs.league_max_size_public_h2h.ToString);
  log('league_max_size_private_h2h: ' + gs.league_max_size_private_h2h.ToString);
  log('league_max_ko_rounds_private_h2h: ' + gs.league_max_ko_rounds_private_h2h.ToString);
  log('league_prefix_public: ' + gs.league_prefix_public);
  log('league_points_h2h_win: ' + gs.league_points_h2h_win.ToString);
  log('league_points_h2h_lose: ' + gs.league_points_h2h_lose.ToString);
  log('league_points_h2h_draw: ' + gs.league_points_h2h_draw.ToString);
  log('league_ko_first_instead_of_random: ' + YesOrNo(gs.league_ko_first_instead_of_random));
  log('cup_start_event_id: ' + gs.cup_start_event_id.ToString);
  log('cup_stop_event_id: ' + gs.cup_stop_event_id.ToString);
  log('cup_qualifying_method: ' + gs.cup_qualifying_method);
  log('cup_type: ' + gs.cup_type);
  log('squad_squadplay: ' + gs.squad_squadplay.ToString);
  log('squad_squadsize: ' + gs.squad_squadsize.ToString);
  log('squad_team_limit: ' + gs.squad_team_limit.ToString);
  log('squad_total_spend: ' + gs.squad_total_spend.ToString);
  log('ui_currency_multiplier: ' + gs.ui_currency_multiplier.ToString);
  log('ui_use_special_shirts: ' + YesOrNo(gs.ui_use_special_shirts));
  log('ui_special_shirt_exclusions: ' + gs.ui_special_shirt_exclusions);
  log('stats_form_days: ' + gs.stats_form_days.ToString);
  log('sys_vice_captain_enabled: ' + YesOrNo(gs.sys_vice_captain_enabled));
  log('transfers_cap: ' + gs.transfers_cap.ToString);
  log('transfers_sell_on_fee: ' + format('%.1f', [gs.transfers_sell_on_fee]));
  log('timezone: ' + gs.timezone);
  log('league_h2h_tiebreak_stats: ' + gs.league_h2h_tiebreak_stats);

  log('GAME_SETTINGS');
end;

procedure TFormFMXScratchPad.Report_Static_Phases;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('PHASES'#13#10);

//  processNode('phases', ['id', 'name', 'start_event', 'stop_event']);

  for var ph in FPLStaticPhases.Phases do begin
    log('id: '          + ph.id.ToString);
    log('name: '        + ph.name);
    log('start_event: ' + ph.start_event.ToString);
    log('stop_event: '  + ph.stop_event.ToString);
    log;
  end;

  log('PHASES');
end;

procedure TFormFMXScratchPad.Report_Static_Teams;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('TEAMS'#13#10);

  for var team in FPLStaticTeams.Teams do begin
    log('team:');
    log('id: '                    + team.id.ToString);
    log('name: '                  + team.name);
    log('pulse_id: '              + team.pulse_id.ToString);
    log('win: '                   + team.win.ToString);
    log('strength_attack_home: '  + team.strength_attack_home.ToString);
    log('strength_attack_away: '  + team.strength_attack_away.ToString);
    log('position: '              + team.position.ToString);
    log('short_name: '            + team.short_name);
    log('strength: '              + team.strength.ToString);
    log('strength_overall_home: ' + team.strength_overall_home.ToString);
    log('strength_overall_away: ' + team.strength_overall_away.ToString);
    log('points: '                + team.points.ToString);
    log('team_division: '         + team.team_division);
    log('strength_defence_home: ' + team.strength_defence_home.ToString);
    log('strength_defence_away: ' + team.strength_defence_away.ToString);
    log('played: '                + team.played.ToString);
    log('unavailable: '           + YesOrNo(team.unavailable));
    log('loss: '                  + team.loss.ToString);
    log('form: '                  + team.form);
    log('draw: '                  + team.draw.ToString);
    log('code: '                  + team.code.ToString);
    log;
  end;

  log('TEAMS');
end;

procedure TFormFMXScratchPad.Report_Static_Total_Players;
// https://fantasy.premierleague.com/api/bootstrap-static/
begin
  EXIT;
  log('TOTAL_PLAYERS');

  log(FPLStaticTotalPlayers.TotalPlayers.total_players.ToString);

  log('TOTAL_PLAYERS');
end;

procedure TFormFMXScratchPad.Report_Fixtures;
// https://fantasy.premierleague.com/api/fixtures/
begin
  EXIT;
  log('FIXTURES'#13#10);

//  processObject(json.AsObject, '', TRUE, 'fixtures'); EXIT;

  for var fixture in FPLFixtures.Fixtures do begin
    log('fixture:');
    log('id: '                      + fixture.id.ToString);
    log('pulse_id: '                + fixture.pulse_id.ToString);
    log('code: '                    + fixture.code.ToString);
    log('event: '                   + fixture.event.ToString);
    log('kickoff_time: '            + DateTimeToStr(fixture.kickoff_time));
    log('provisional_start_time: '  + YesOrNo(fixture.provisional_start_time));
    log('started: '                 + YesOrNo(fixture.started));
    log('minutes: '                 + fixture.minutes.ToString);
    log('finished_provisional: '    + YesOrNo(fixture.finished_provisional));
    log('finished: '                + YesOrNo(fixture.finished));
    log('team_h: '                  + fixture.team_h.ToString);
    log('team_h_score: '            + fixture.team_h_score.ToString);
    log('team_a: '                  + fixture.team_a.ToString);
    log('team_a_score: '            + fixture.team_a_score.ToString);
    log('team_h_difficulty: '       + fixture.team_h_difficulty.ToString);
    log('team_a_difficulty: '       + fixture.team_a_difficulty.ToString);
    log;

    log('STATS: ');
    log;

    for var vStat in fixture.goals_scored do begin
      log('GoalsScored');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.assists do begin
      log('Assists');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.own_goals do begin
      log('Own Goals');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.penalties_saved do begin
      log('PenaltiesSaved');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.penalties_missed do begin
      log('PenaltiesMissed');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.yellow_cards do begin
      log('YellowCards');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.red_cards do begin
      log('RecCards');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.saves do begin
      log('Saves');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.bonus do begin
      log('Bonus');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;
    for var vStat in fixture.bps do begin
      log('BPS');
      log('HomeAway: '  + vStat.HomeAway);
      log('element: '   + vStat.element.ToString);
      log('value: '     + vStat.value.ToString);
    end;

    log;
  end;

  log('FIXTURES');
end;

procedure TFormFMXScratchPad.Report_Gameweek;
// https://fantasy.premierleague.com/api/event/GW/live/
begin
  EXIT;
  log('GAMEWEEK'#13#10);

  for var element in FPLGameweek.Elements do begin
    log('id :' + element.id.ToString);
    log('goals_conceded: '   + element.goals_conceded.ToString);
    log('bps: '              + element.bps.ToString);
    log('minutes: '          + element.minutes.ToString);
    log('ict_index: '        + format('%.1f', [element.ict_index]));
    log('in_dreamteam: '     + YesOrNo(element.in_dreamteam));
    log('penalties_saved: '  + element.penalties_saved.ToString);
    log('total_points: '     + element.total_points.ToString);
    log('creativity: '       + format('%.1f', [element.creativity]));
    log('yellow_cards: '     + element.yellow_cards.ToString);
    log('influence: '        + format('%.1f', [element.influence]));
    log('own_goals: '        + element.own_goals.ToString);
    log('clean_sheets: '     + element.clean_sheets.ToString);
    log('threat: '           + format('%.1f', [element.threat]));
    log('red_cards: '        + element.red_cards.ToString);
    log('saves: '            + element.saves.ToString);
    log('goals_scored: '     + element.goals_scored.ToString);
    log('penalties_missed: ' + element.penalties_missed.ToString);
    log('bonus: '            + element.bonus.ToString);
    log('assists: '          + element.assists.ToString);
    log;

    for var stat in element.gameweekStats do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sassists do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sbonus do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sclean_sheets do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sgoals_conceded do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sgoals_scored do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sminutes do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sown_goals do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Sred_cards do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Ssaves do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Syellow_cards do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Spenalties_saved do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;

    for var stat in element.Spenalties_missed do begin
      log('fixture: '    + stat.fixture.ToString);
      log('identifier: ' + stat.identifier);
      log('points: '     + stat.points.ToString);
      log('value: '      + stat.value.ToString);
      log;
    end;
  end;

  log('GAMEWEEK');
end;

procedure TFormFMXScratchPad.Report_History;
// https://fantasy.premierleague.com/api/entry/TID/history/
begin
  EXIT;
  log('HISTORY'#13#10);

  log('CURRENT:');
  for var vCurrent in FPLHistory.current do begin
    log('event: '                 + vCurrent.event.ToString);
    log('event_transfers_cost: '  + vCurrent.event_transfers_cost.ToString);
    log('total_points: '          + vCurrent.total_points.ToString);
    log('points_on_bench: '       + vCurrent.points_on_bench.ToString);
    log('points: '                + vCurrent.points.ToString);
    log('rank_sort: '             + vCurrent.rank_sort.ToString);
    log('event_transfers: '       + vCurrent.event_transfers.ToString);
    log('value: '                 + vCurrent.value.ToString);
    log('overall_rank: '          + vCurrent.overall_rank.ToString);
    log('rank: '                  + vCurrent.rank.ToString);
    log('bank: '                  + vCurrent.bank.ToString);
    log;
  end;

  log('CHIPS');
  for var vChip in FPLHistory.chips do begin
    log('name: '          + vChip.name);
    log('event: '         + vChip.event.ToString);
    log('time: '          + DateTimeToStr(vChip.time));
    log;
  end;

  log('PAST');
  for var vPast in FPLHistory.past do begin
    log('season_name: '   + vPast.season_name);
    log('total_points: '  + vPast.total_points.ToString);
    log('rank: '          + vPast.rank.ToString);
    log;
  end;


  log('HISTORY');
end;

procedure TFormFMXScratchPad.Report_Picks;
// https://fantasy.premierleague.com/api/entry/TID/event/GW/picks/
begin
  EXIT;
  log('PICKS'#13#10);

  for var entry in FPLPicks.entry do begin
    log('active_chip: '           + entry.active_chip);
    log('event_transfers_cost: '  + entry.event_transfers_cost.ToString);
    log('rank: '                  + entry.rank.ToString);
    log('points_on_bench: '       + entry.points_on_bench.ToString);
    log('rank_sort: '             + entry.rank_sort.ToString);
    log('event_transfers: '       + entry.event_transfers.ToString);
    log('overall_rank: '          + entry.overall_rank.ToString);
    log('bank: '                  + entry.bank.ToString);
    log('value: '                 + entry.value.ToString);
    log('event: '                 + entry.event.ToString);
    log('points: '                + entry.points.ToString);
    log('total_points: '          + entry.total_points.ToString);
    log;
  end;

  for var sub in FPLPicks.subs do begin
    log('sub:');
    log('entry: '       + sub.entry.ToString);
    log('event: '       + sub.event.ToString);
    log('element_out: ' + sub.element_out.ToString);
    log('element_in: '  + sub.element_in.ToString);
    log;
  end;

  for var pick in FPLPicks.picks do begin
    log('pick:');
    log('element: '         + pick.element.ToString);
    log('position: '        + pick.position.ToString);
    log('multiplier: '      + pick.multiplier.ToString);
    log('is_captain: '      + YesOrNo(pick.is_captain));
    log('is_vice_captain: ' + YesOrNo(pick.is_vice_captain));
    log;
  end;

  log('PICKS');
end;

procedure TFormFMXScratchPad.Report_League;
// https://fantasy.premierleague.com/api/leagues-classic/LID/standings/
begin
  EXIT;
  log('LEAGUE'#13#10);

  // currently we ignore: the "new.entries" object and its "new.entries.results" array
  //                      standings.has_next = false : boolean
  //                      standings.page = 1         : integer
  // We'll be given the first 50 teams in each league; that's enough for now.

  for var league in FPLLeagues.leagues do begin
    log('league:');
    log('has_cup: '       + YesOrNo(league.has_cup));
    log('start_event: '   + league.start_event.ToString);
    log('scoring: '       + league.scoring);
    log('created: '       + DateTimeToStr(league.created));
    log('cup_league: '    + league.cup_league);
    log('id: '            + league.id.ToString);
    log('code_privacy: '  + league.code_privacy);
    log('max_entries: '   + league.max_entries.ToString);
    log('admin_entry: '   + league.admin_entry.ToString);
    log('rank: '          + league.rank.ToString);
    log('name: '          + league.name);
    log('closed: '        + YesOrNo(league.closed));
    log('league_type: '   + league.league_type);
    log;
  end;

  for var standing in FPLLeagues.leagueStandings do begin
    log('result:');
    log('entry_name: '  + standing.entry_name);
    log('event_total: ' + standing.event_total.ToString);
    log('player_name: ' + standing.player_name);
    log('last_rank: '   + standing.last_rank.ToString);
    log('rank_sort: '   + standing.rank_sort.ToString);
    log('id: '          + standing.id.ToString);
    log('entry: '       + standing.entry.ToString);
    log('total: '       + standing.total.ToString);
    log('rank: '        + standing.rank.ToString);
    log;
  end;

  log('LEAGUE');
end;

procedure TFormFMXScratchPad.Report_Element_Summary;
begin
  EXIT;
  log('PLAYER'#13#10);

//  processObject(json.AsObject);
//  ProcessObject(json.AsObject, '', TRUE, 'history_past');

  for var fixture in FPLElementSummary.fixtures do begin
    log('fixture:');
    log('team_h_score: '            + fixture.team_h_score.ToString);
    log('minutes: '                 + fixture.minutes.ToString);
    log('event_name: '              + fixture.event_name);
    log('kickoff_time: '            + DateTimeToStr(fixture.kickoff_time));
    log('finished: '                + YesOrNo(fixture.finished));
    log('provisional_start_time: '  + YesOrNo(fixture.provisional_start_time));
    log('team_a_score: '            + fixture.team_a_score.ToString);
    log('id: '                      + fixture.id.ToString);
    log('is_home: '                 + YesOrNo(fixture.is_home));
    log('event: '                   + fixture.event.ToString);
    log('code: '                    + fixture.code.ToString);
    log('team_h: '                  + fixture.team_h.ToString);
    log('team_a: '                  + fixture.team_a.ToString);
    log('difficulty: '              + fixture.difficulty.ToString);
    log;
  end;

  for var history in FPLElementSummary.historys do begin
    log('history:');
    log('team_h_score: '            + history.team_h_score.ToString);
    log('goals_conceded: '          + history.goals_conceded.ToString);
    log('bps: '                     + history.bps.ToString);
    log('fixture: '                 + history.fixture.ToString);
    log('minutes: '                 + history.minutes.ToString);
    log('transfers_in: '            + history.transfers_in.ToString);
    log('ict_index: '               + format('%.1f', [history.ict_index]));
    log('kickoff_time: '            + DateTimeToStr(history.kickoff_time));
    log('penalties_saved: '         + history.penalties_saved.ToString);
    log('element: '                 + history.element.ToString);
    log('total_points: '            + history.total_points.ToString);
    log('creativity: '              + format('%.1f', [history.creativity]));
    log('yellow_cards: '            + history.yellow_cards.ToString);
    log('influence: '               + format('%.1f', [history.influence]));
    log('selected: '                + history.selected.ToString);
    log('transfers_out: '           + history.transfers_out.ToString);
    log('own_goals: '               + history.own_goals.ToString);
    log('was_home: '                + YesOrNo(history.was_home));
    log('value: '                   + history.value.ToString);
    log('team_a_score: '            + history.team_a_score.ToString);
    log('clean_sheets: '            + history.clean_sheets.ToString);
    log('threat: '                  + format('%.1f', [history.threat]));
    log('red_cards: '               + history.red_cards.ToString);
    log('transfers_balance: '       + history.transfers_balance.ToString);
    log('saves: '                   + history.saves.ToString);
    log('opponent_team: '           + history.opponent_team.ToString);
    log('goals_scored: '            + history.goals_scored.ToString);
    log('penalties_missed: '        + history.penalties_missed.ToString);
    log('round: '                   + history.round.ToString);
    log('bonus: '                   + history.bonus.ToString);
    log('assists: '                 + history.assists.ToString);
    log;
  end;

  for var past in FPLElementSummary.historyPasts do begin
    log('history past:');
    log('season_name: '             + past.season_name);
    log('goals_conceded: '          + past.goals_conceded.ToString);
    log('bps: '                     + past.bps.ToString);
    log('minutes: '                 + past.minutes.ToString);
    log('ict_index: '               + format('%.1f', [past.ict_index]));
    log('start_cost: '              + past.start_cost.ToString);
    log('penalties_saved: '         + past.penalties_saved.ToString);
    log('total_points: '            + past.total_points.ToString);
    log('creativity: '              + format('%.1f', [past.creativity]));
    log('yellow_cards: '            + past.yellow_cards.ToString);
    log('element_code: '            + past.element_code.ToString);
    log('influence: '               + format('%.1f', [past.influence]));
    log('own_goals: '               + past.own_goals.ToString);
    log('clean_sheets: '            + past.clean_sheets.ToString);
    log('threat: '                  + format('%.1f', [past.threat]));
    log('end_cost: '                + past.end_cost.ToString);
    log('red_cards: '               + past.red_cards.ToString);
    log('saves: '                   + past.saves.ToString);
    log('goals_scored: '            + past.goals_scored.ToString);
    log('penalties_missed: '        + past.penalties_missed.ToString);
    log('bonus: '                   + past.bonus.ToString);
    log('assists: '                 + past.assists.ToString);
    log;
  end;

  log('PLAYER');
end;

procedure TFormFMXScratchPad.Report_MyTeam;
begin
  EXIT;
  log('MyTeam'#13#10);

  processObject(json.AsObject);
  processObject(json.AsObject, '', '', '', TRUE);

  log('MyTeam');
end;

// If you don't know the structure of the JSON you receive from somewhere,eg FPL, it is important to note that JSON is "simply" a
// composite pattern and you can traverse it like any other composite structure.
// The following example traverses the complete structure of JSON text and annotates the structure and each element's datatype.
// It can also be called to create a [read-only] Delphi property definition for each element.
var count: integer;
procedure TFormFMXScratchPad.ProcessObject(const aAsObject: TSuperTableString; const aPrefix: string = ''; aPrefixFilter: string = ''; aNameFilter: string = ''; propertyDef: boolean = FALSE);
var
  vNames:         ISuperObject;
  vName:          string;
  vItems:         ISuperObject;
  vItem:          ISuperObject;
  idx:            integer;
  vValue:         string;
  vArrayItem:     ISuperObject;
  vDelphiType:    string;
  isNumber:       boolean;
  isFloat:        boolean;
  cntDots:        integer;
  isXMLDateTime:  boolean;
  vColon:         string;

  procedure checkDigits;
  begin
    cntDots := 0;
    for var c in vValue do begin
      isNumber := charInSet(c , ['0'..'9', '.', '-', '+']);
      case isNumber of  FALSE: EXIT; end;
      case c = '.'  of   TRUE: inc(cntDots); end;
    end;
    isFloat := cntDots = 1;
  end;

  procedure checkXMLDateTime;
  // 2020-08-17T13:07:44.040688Z
  begin
    isXMLDateTime := vValue.Length > 19;      // 2020-08-17T13:07:44 + Z as minimum
    case isXMLDateTime of FALSE: EXIT; end;

    isXMLDateTime := vValue[11] = 'T';
    case isXMLDateTime of FALSE: EXIT; end;

    isXMLDateTime := vValue[length(vValue)] = 'Z';
    case isXMLDateTime of FALSE: EXIT; end;

    isXMLDateTime := (vValue[5] = '-') AND (vValue[8] = '-');
    case isXMLDateTime of FALSE: EXIT; end;

    isXMLDateTime := (vValue[14] = ':') AND (vValue[17] = ':');
    case isXMLDateTime of FALSE: EXIT; end;
  end;

  procedure setDelphiType;
  begin
    case vItem.DataType = stArray of TRUE: begin vDelphiType := 'IReadOnlyList'; EXIT; end;end;

    case vValue = '' of
       TRUE:  vDelphiType := 'string       ';             // 13-width, same as longest = IReadOnlyList
      FALSE:  case pos(vValue, 'truefalse') > 0 of
                 TRUE:  vDelphiType := 'boolean      ';
                FALSE:  begin
                          checkXMLDateTime;
                          case isXMLDateTime of
                             TRUE:  vDelphiType := 'TDateTime    ';
                            FALSE:  begin
                                      checkDigits;
                                      case isFloat of
                                         TRUE:  vDelphiType := 'double       ';
                                        FALSE:  case isNumber of
                                                   TRUE: vDelphiType := 'integer      ';
                                                  FALSE: vDelphiType := 'string       ';
                                                end;end;end;end;end;end;end;
  end;


begin
  if Assigned(aAsObject) then
  begin
    vNames := aAsObject.GetNames;
    vItems := aAsObject.GetValues;

    for idx := 0 to vItems.AsArray.Length - 1 do
    begin
      vName       := vNames.AsArray[idx].AsString;
      vItem       := vItems.AsArray[idx];
      vDelphiType := '';

      case vItem.DataType of
        stObject: vValue  := '<Object>';
        stArray:  vValue  := '<Array>';
      else  begin
                  vValue  := trim(vItem.AsString);
                  setDelphiType;
            end;
      end;

      case not propertyDef AND (vItem.DataType in [stObject, stArray]) of
         TRUE: vColon := '';
        FALSE: vColon := ': ';
      end;

      case (aNameFilter = '') OR (aNameFilter = vName) of TRUE:
        case propertyDef of
           TRUE:  case (not (vItem.DataType in [stObject, stArray])) AND ((aPrefixFilter = '') OR (aPrefix.StartsWith(aPrefixFilter + '.'))) of
                     TRUE: log(Format('    %-50s%s read F%s;', ['property ' + vName + vColon, vDelphiType, vName])); end;
          FALSE:  case (aPrefixFilter = '') OR (aPrefix.StartsWith(aPrefixFilter + '.')) of
                     TRUE:  log(Format('%s = %s%*s', [aPrefix + vName, vValue, 66 - 3 - aPrefix.Length - vName.Length - vValue.Length, vColon + vDelphiType])); end;
        end;
      end;

      case vItem.DataType of
        stArray:  for vArrayItem in vItem do
                    ProcessObject(vArrayItem.AsObject,  aPrefix + vName + '.', aPrefixFilter, aNameFilter, propertyDef);
        stObject:   ProcessObject(vItem.AsObject,       aPrefix + vName + '.', aPrefixFilter, aNameFilter, propertyDef);
      end;

    end;
  end;
end;

end.
