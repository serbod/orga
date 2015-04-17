unit VideoPhoneFrame;

interface

uses
  SysUtils, Classes, Forms,
  Dialogs, ComCtrls, ExtCtrls, ToolWin, DSUtil, DSPack, DirectShow9, Menus,
  Controls, StdCtrls;

type
  TFrameVideoPhone = class(TFrame)
    toolbarVideoPhone: TToolBar;
    tbtnSelectCamera: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    TreeView1: TTreeView;
    FilterGraph: TFilterGraph;
    Filter: TFilter;
    SampleGrabber: TSampleGrabber;
    pmCameraSelect: TPopupMenu;
    VideoWindow: TVideoWindow;
    gbVideo: TGroupBox;
    Splitter2: TSplitter;
    gbInfo: TGroupBox;
  private
    { Private declarations }
    SysDev: TSysDevEnum;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure OnSelectDevice(sender: TObject);
    procedure SampleGrabberBuffer(sender: TObject; SampleTime: Double;
      pBuffer: Pointer; BufferLen: Integer);
  end;

implementation
uses Main;
{$R *.dfm}

constructor TFrameVideoPhone.Create(AOwner: TComponent);
var
  i: integer;
  Device: TMenuItem;
begin
  inherited Create(AOwner);

  SysDev:=TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  if SysDev.CountFilters > 0 then
  begin
    for i := 0 to SysDev.CountFilters - 1 do
    begin
      Device := TMenuItem.Create(pmCameraSelect);
      Device.Caption := SysDev.Filters[i].FriendlyName;
      Device.Tag := i;
      Device.OnClick := OnSelectDevice;
      pmCameraSelect.Items.Add(Device);
    end;
  end;

  //tbVideoPhone.Images:=frmMain.ImageList24;

end;

destructor TFrameVideoPhone.Destroy();
begin
  SysDev.Free();
  FilterGraph.ClearGraph();
  FilterGraph.Active := false;
  inherited Destroy();
end;

procedure TFrameVideoPhone.OnSelectDevice(sender: TObject);
begin
  FilterGraph.ClearGraph;
  FilterGraph.Active := false;
  Filter.BaseFilter.Moniker := SysDev.GetMoniker(TMenuItem(Sender).tag);
  FilterGraph.Active := true;
  with FilterGraph as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter as IBaseFilter, SampleGrabber as IBaseFilter, VideoWindow as IbaseFilter);
  FilterGraph.Play;
end;

procedure TFrameVideoPhone.SampleGrabberBuffer(sender: TObject;
  SampleTime: Double; pBuffer: Pointer; BufferLen: Integer);
begin
  {if CallBack.Checked then
  begin
    Image.Canvas.Lock;
    try
      SampleGrabber.GetBitmap(Image.Picture.Bitmap, pBuffer, BufferLen);
    finally
      Image.Canvas.Unlock;
    end;
  end; }
end;

end.
