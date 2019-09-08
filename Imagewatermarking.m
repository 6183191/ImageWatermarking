function varargout = Imagewatermarking(varargin)
% IMAGEWATERMARKING MATLAB code for Imagewatermarking.fig
%      IMAGEWATERMARKING, by itself, creates a new IMAGEWATERMARKING or raises the existing
%      singleton*.
%
%      H = IMAGEWATERMARKING returns the handle to a new IMAGEWATERMARKING or the handle to
%      the existing singleton*.
%
%      IMAGEWATERMARKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEWATERMARKING.M with the given input arguments.
%
%      IMAGEWATERMARKING('Property','Value',...) creates a new IMAGEWATERMARKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Imagewatermarking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Imagewatermarking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Imagewatermarking

% Last Modified by GUIDE v2.5 01-Sep-2019 21:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Imagewatermarking_OpeningFcn, ...
                   'gui_OutputFcn',  @Imagewatermarking_OutputFcn, ...
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


% --- Executes just before Imagewatermarking is made visible.
function Imagewatermarking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Imagewatermarking (see VARARGIN)

% Choose default command line output for Imagewatermarking
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Imagewatermarking wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Imagewatermarking_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnBrowseOriginal.
function btnBrowseOriginal_Callback(hObject, eventdata, handles)
axes(handles.axes1);
v_test = 1
[filename pathname] = uigetfile('*.jpg;*.png;*.bmp', 'Pick any file');
if isequal(filename,0)
    disp('User selected Cancel');
else
    p = imread([pathname, filename]);
    %p = imresize(p, [400, 400]);
    handles.originalImage = p;
    guidata(hObject, handles);
    OIm = p;
    watermark = 0;
    if isfield(handles, 'watermarkImage')
        watermark = handles.watermarkImage;
    end
    if exist('watermark', 'var')
        alpha = 1;%0.5;
        [m, n,~]=size(watermark);
        Sz = [50 50];
        at = 0.5;
        tmpWatermark=(1-at)*watermark + at.*OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:);
        %figure,imshow(OtherLogo);title('Test in the centre');

        %Apply watermark
        OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:)=(1-alpha)*OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:) + alpha.*tmpWatermark;
        %figure,imshow(OIm);title('Watermark in the centre');
    end
    
    %imshow(p);
    imshow(OIm);
    handles.finalImage = OIm;
    guidata(hObject, handles);
end


% --- Executes on button press in btnBrowseWatermark.
function btnBrowseWatermark_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile('*.jpg;*.png;*.bmp', 'Pick any file');
if isequal(filename,0)
    disp('User selected Cancel');
else
    %[Logo, map, alphachannel] = imread('images/logo.png');
    %image(Logo, 'AlphaData', alphachannel);
    [p, ~, alphachannel] = imread([pathname, filename]);
    image(p, 'AlphaData', alphachannel);
    p = imresize(p, [150, 150]);

    %imshow(p);
    handles.watermarkImage = p;
    guidata(hObject, handles);
    
    OIm = p;
    originalImage = 0;
    if isfield(handles, 'originalImage')
        originalImage = handles.originalImage;
        OIm = originalImage;
    end
    if exist('originalImage', 'var')
        alpha = 1;%0.5;
        [m, n,~]=size(p);
        Sz = [50 50];
        at = 0.5;
        tmpWatermark=(1-at)*p + at.*OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:);
        %figure,imshow(OtherLogo);title('Test in the centre');

        %Apply watermark
        OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:)=(1-alpha)*OIm(Sz(1):Sz(1)+m-1,Sz(2):Sz(2)+n-1,:) + alpha.*tmpWatermark;
        %figure,imshow(OIm);title('Watermark in the centre');
    end
    
    %imshow(p);
    imshow(OIm);
    
    handles.finalImage = OIm;
    guidata(hObject, handles);
end


% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
filter = {'*.png';'*.jpg';'*.bmp';'*.*'};
[file,path] = uiputfile(filter, 'Save Watermarked Image', 'watermarked.png');
if isequal(file,0)
    disp('User selected Cancel');
else
    if isfield(handles, 'finalImage')
        finalImage = handles.finalImage;
    
        imwrite(finalImage, [path, file]);
    end
    
end


% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
