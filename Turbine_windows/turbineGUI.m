function varargout = turbineGUI(varargin)
% TURBINEGUI MATLAB code for turbineGUI.fig
%      TURBINEGUI, by itself, creates a new TURBINEGUI or raises the existing
%      singleton*.
%
%      H = TURBINEGUI returns the handle to a new TURBINEGUI or the handle to
%      the existing singleton*.
%
%      TURBINEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TURBINEGUI.M with the given input arguments.
%
%      TURBINEGUI('Property','Value',...) creates a new TURBINEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before turbineGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to turbineGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help turbineGUI

% Last Modified by GUIDE v2.5 05-Mar-2017 18:46:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @turbineGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @turbineGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before turbineGUI is made visible.
function turbineGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to turbineGUI (see VARARGIN)

% Choose default command line output for turbineGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes turbineGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
updateGUI(hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = turbineGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;







function updateGUI(hObject, eventdata, handles)
sliderValueFC = get(handles.slider_FC,'Value');  set(handles.edit_FC,'String', num2str(sliderValueFC));
sliderValueLF = get(handles.slider_LF,'Value');  set(handles.edit_LF,'String', num2str(sliderValueLF));
sliderValueDR = get(handles.slider_DR,'Value');  set(handles.edit_DR,'String', num2str(sliderValueDR));

pitchStat = get(handles.pitchStat,'Value');  set(handles.editPitchStat,'String', num2str(pitchStat));
pitchRot  = get(handles.pitchRot,'Value');   set(handles.editPitchRot,'String', num2str(pitchRot));

showVelTriang = get(handles.checkboxShowVelTriang,'Value')

guidata(hObject, handles);

axes(handles.axes1)

[sta,rot,X,U] = turbine(sliderValueFC, sliderValueLF, sliderValueDR);


dd = 0.05;
% stackS = 2.5;      % number of profiles fir each 
% stackR = 2.5;      % number of profiles fir each 



% plot profiles
hold off
% plot(stator(:,1), stator(:,2),'ro-'); hold on; 
% plot(bezSta(:,1), bezSta(:,2),'r--','LineWidth', 1);
% plot(rotor(:,1), rotor(:,2),'bo-'); 
% plot(bezRot(:,1), bezRot(:,2),'b--','LineWidth', 1);

if showVelTriang == 1; offsetY = 0; else offsetY = 0.5; end
for i=-10:10
  plot(sta(:,1)+i*pitchStat, sta(:,2)+0.25-offsetY, 'r','LineWidth', 3); hold on
%   plot(bezStaSS(:,1)+i*stackS+dd, bezStaSS(:,2), 'r','LineWidth', 3);
  plot(rot(:,1)+(i-1)*pitchRot, rot(:,2)-0.25+offsetY, 'b','LineWidth', 3);
%   plot(bezRotSS(:,1)+(i-1)*stackR+dd, bezRotSS(:,2), 'b','LineWidth', 3);
end


if showVelTriang == 1
    offset = 0;
    % draw velocity profiles
    % stator inlet
    drawArrow([offset 1.5], [offset-X(2)-U 0.5], 'something','r')  %C1

    offset = 0;
    % stator outlet / rotot inlet
    drawArrow([offset        -2], [offset-X(1)     -3], 'something','r') % C2
    drawArrow([offset        -2], [offset-X(1)+U   -3], 'something','b') % W2
    drawArrow([offset-X(1)+U -3], [offset-X(1)     -3], 'something','b') % U

    offset = 0;
    % rotor outlet
    drawArrow([offset      -5.5], [offset-X(2)-U  -6.5], 'something','r') % C3
    drawArrow([offset      -5.5], [offset-X(2)    -6.5], 'something','b') % W3
    drawArrow([offset-X(2) -6.5], [offset-X(2)-U  -6.5], 'something','b') % U
end

hold off



set(handles.axes1,'XLim',[-10 10])
set(handles.axes1,'YLim',[-7 2])










function slider_DR_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)
function slider_DR_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_LF_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)
function slider_LF_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_FC_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)
function slider_FC_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function pitchStat_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)
function pitchStat_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function pitchRot_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)
function pitchRot_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end







function edit_DR_Callback(hObject, eventdata, handles)
function edit_DR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_LF_Callback(hObject, eventdata, handles)
function edit_LF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_FC_Callback(hObject, eventdata, handles)
function edit_FC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editPitchStat_Callback(hObject, eventdata, handles)
function editPitchStat_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editPitchRot_Callback(hObject, eventdata, handles)
function editPitchRot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function checkboxShowVelTriang_Callback(hObject, eventdata, handles)
updateGUI(hObject, eventdata, handles)

function checkboxShowVelTriang_CreateFcn(hObject, eventdata, handles)
