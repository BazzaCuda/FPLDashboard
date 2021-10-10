program FPL;

uses
  Vcl.Forms,
  FormScratchPadClass in 'FormScratchPadClass.pas' {FormScratchPad},
  FPL_Internet in 'FPL_Internet.pas',
  FPL_Static_Events in 'FPL_Static_Events.pas',
  bzUtils in '..\..\bzLib\bzUtils.pas',
  FPL_Static_Elements in 'FPL_Static_Elements.pas',
  FPL_Static_Element_Types in 'FPL_Static_Element_Types.pas',
  FPL_Static_Teams in 'FPL_Static_Teams.pas',
  FPL_Static_Game_Settings in 'FPL_Static_Game_Settings.pas',
  FPL_JSON in 'FPL_JSON.pas',
  FPL_Static_Total_Players in 'FPL_Static_Total_Players.pas',
  FPL_Static_Phases in 'FPL_Static_Phases.pas',
  FPL_TID_Entry in 'FPL_TID_Entry.pas',
  FPL_Gameweek in 'FPL_Gameweek.pas',
  FPL_Fixtures in 'FPL_Fixtures.pas',
  FPL_History in 'FPL_History.pas',
  FPL_Transfers in 'FPL_Transfers.pas',
  FPL_Picks in 'FPL_Picks.pas',
  FPL_League in 'FPL_League.pas',
  FPL_Element_Summary in 'FPL_Element_Summary.pas',
  FPL_MyTeam in 'FPL_MyTeam.pas',
  FPL_Images in 'FPL_Images.pas';

{$R *.res}

//  vApp.CreateForm(TFormScratchPad, vMainForm);

var
  vApp:       TApplication;
  vMainForm:  TFormScratchPad;

begin
  ReportMemoryLeaksOnShutdown := TRUE;
  vApp                        := application;
  vApp.Initialize;
  vApp.MainFormOnTaskbar      := True;
  vApp.CreateForm(TFormScratchPad, vMainForm);
  vApp.Run;
end.
