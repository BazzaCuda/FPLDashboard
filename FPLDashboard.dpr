program FPLDashboard;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_FMXScratchPad in 'Form_FMXScratchPad.pas' {FormFMXScratchPad},
  bzFMXUtils in '..\..\bzLib\bzFMXUtils.pas',
  FPL_Element_Summary in 'FPL_Element_Summary.pas',
  FPL_Fixtures in 'FPL_Fixtures.pas',
  FPL_Gameweek in 'FPL_Gameweek.pas',
  FPL_History in 'FPL_History.pas',
  FPL_Images in 'FPL_Images.pas',
  FPL_Internet in 'FPL_Internet.pas',
  FPL_JSON in 'FPL_JSON.pas',
  FPL_League in 'FPL_League.pas',
  FPL_MyTeam in 'FPL_MyTeam.pas',
  FPL_Picks in 'FPL_Picks.pas',
  FPL_Static_Element_Types in 'FPL_Static_Element_Types.pas',
  FPL_Static_Elements in 'FPL_Static_Elements.pas',
  FPL_Static_Events in 'FPL_Static_Events.pas',
  FPL_Static_Game_Settings in 'FPL_Static_Game_Settings.pas',
  FPL_Static_Phases in 'FPL_Static_Phases.pas',
  FPL_Static_Teams in 'FPL_Static_Teams.pas',
  FPL_Static_Total_Players in 'FPL_Static_Total_Players.pas',
  FPL_TID_Entry in 'FPL_TID_Entry.pas',
  FPL_Transfers in 'FPL_Transfers.pas';

{$R *.res}

var
  vApp:       TApplication;
  vMainForm:  TFormFMXScratchPad;

begin
  ReportMemoryLeaksOnShutdown := TRUE;
  vApp                        := application;
  vApp.Initialize;
//  vApp.MainFormOnTaskbar      := True;
  vApp.CreateForm(TFormFMXScratchPad, vMainForm);
  vApp.Run;
end.
