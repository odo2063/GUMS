function varargout = gen_adjust_amp(varargin)
% GEN_ADJUST_AMP MATLAB code for gen_adjust_amp.fig
%      GEN_ADJUST_AMP, by itself, creates a new GEN_ADJUST_AMP or raises the existing
%      singleton*.
%
%      H = GEN_ADJUST_AMP returns the handle to a new GEN_ADJUST_AMP or the handle to
%      the existing singleton*.
%
%      GEN_ADJUST_AMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEN_ADJUST_AMP.M with the given input arguments.
%
%      GEN_ADJUST_AMP('Property','Value',...) creates a new GEN_ADJUST_AMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gen_adjust_amp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gen_adjust_amp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gen_adjust_amp

% Last Modified by GUIDE v2.5 16-Mar-2015 10:24:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gen_adjust_amp_OpeningFcn, ...
                   'gui_OutputFcn',  @gen_adjust_amp_OutputFcn, ...
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


% --- Executes just before gen_adjust_amp is made visible.
function gen_adjust_amp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gen_adjust_amp (see VARARGIN)

% Choose default command line output for gen_adjust_amp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gen_adjust_amp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gen_adjust_amp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok_button.
function ok_button_Callback(hObject, eventdata, handles)
% hObject    handle to ok_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf) 
