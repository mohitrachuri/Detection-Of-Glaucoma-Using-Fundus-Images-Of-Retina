function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 11-Mar-2017 14:32:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;
z=ones(256,256);
axes(handles.one);
imshow(z);
axes(handles.two);
imshow(z);
axes(handles.three);
imshow(z);
axes(handles.four);
imshow(z);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=ones(256,256);
axes(handles.one);
imshow(x);
axes(handles.two);
imshow(x);
axes(handles.three);
imshow(x);
axes(handles.four);
imshow(x);


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cd Database
[filename, pathname] = uigetfile('*.jpg;*.bmp', 'Pick an Image');
  Input=imread(filename);
  cd ..
  if isequal(filename,0) || isequal(pathname,0)
        
     warndlg('File is not selected');
       
  else
        
     
      axes(handles.one);
      imshow(Input);
      title('Input Image');
  end
  Input=imresize(Input,[512 512]);
  Image=Input(:,:,2);
  axes(handles.two);
  imshow(Image);
  title('Image In Green Plane');
 
  handles.Image=Image;
  handles.Input = Input;
  
  
  % Update handles structure
  guidata(hObject, handles);

  
  
% --- Executes on button press in Vessel.
function Vessel_Callback(hObject, eventdata, handles)
% hObject    handle to Vessel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Image=handles.Image;
A=Image;
B1 = strel('disk',2);
B2= strel('disk',6);
Dilated=imdilate(A,B1);
figure(1);imshow(Dilated,[]);
title('Dilated Image');
Eroded=imerode(A,B2);
figure(2);imshow(Eroded,[]);
title('Eroded Image');
X=imdilate(A,B2);
X1=imerode(X,B2);

Y=imdilate(A,B1);
Y1=imerode(Y,B1);

C= X1-Y1;
figure(3);imshow(C);
title('Difference Image');
% pixval on;
[r c]=size(C);
for i=1:r
    for j=1:c
        aa=C(i,j);
        if aa > 8
            C(i,j)=200;
        end
    end
end
% figure;imshow(C);

F=medfilt2(C,[3 3]);
U=medfilt2(F,[5 5]);
figure(4);imshow(U);
title('Blood Vessel Detection');
axes(handles.three);
imshow(U);
title('Vessel Detection');

%%%%%%%%%%% Morphological thinning operation%%%%%%%%%%%%%

T=(U-(imerode(U,B1)- imerode(imcomplement(U),B1)));
% figure;imshow(T);
Filtered=medfilt2(T,[2 2]);
figure(5);imshow(Filtered);
title('Thinning Operation');
axes(handles.four);
imshow(Filtered);
title('Vessel Edges');

handles.U=U;

% Update handles structure
  guidata(hObject, handles);

  
% --- Executes on button press in fovea.
function fovea_Callback(hObject, eventdata, handles)
% hObject    handle to fovea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

input = handles.Input;
input=rgb2gray(input);
input=double(input);
wd=256;
% Input   = imread('new.bmp');
Input=imresize(input,[256 256]);
[r c p]   = size(Input);
if p==3
Input =rgb2gray(Input);
end
Input   =double(Input);

Length  = r*c; 
Dataset = reshape(Input,[Length,1]);
regions=5 %k regionS
region1=zeros(Length,1);
region2=zeros(Length,1);
region3=zeros(Length,1);
region4=zeros(Length,1);
region5=zeros(Length,1);
miniv = min(min(Input));
maxiv = max(max(Input));
range = maxiv - miniv;
stepv = range/regions;
incrval = stepv;
for i = 1:regions
    K(i).centroid = incrval;
    incrval = incrval + stepv;
end

update1=0;
update2=0;
update3=0;
update4=0;
update5=0;

mean1=2;
mean2=2;
mean3=2;
mean4=2;
mean5=2;

while  ((mean1 ~= update1) & (mean2 ~= update2) & (mean3 ~= update3) & (mean4 ~= update4) & (mean5 ~= update5))

mean1=K(1).centroid;
mean2=K(2).centroid;
mean3=K(3).centroid;
mean4=K(4).centroid;
mean5=K(5).centroid;

for i=1:Length
    for j = 1:regions
        temp= Dataset(i);
        difference(j) = abs(temp-K(j).centroid);
       
    end
    [y,ind]=min(difference);
    
  if ind==1
    region1(i)   =temp;
end
if ind==2
    region2(i)   =temp;
end
if ind==3
    region3(i)   =temp;
end
if ind==4
    region4(i)   =temp;
end
if ind==5
    region5(i)   =temp;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UPDATE CENTROIDS
cout1=0;
cout2=0;
cout3=0;
cout4=0;
cout5=0;

for i=1:Length
    Load1=region1(i);
    Load2=region2(i);
    Load3=region3(i);
    Load4=region4(i);
    Load5=region5(i);
    
    if Load1 ~= 0
        cout1=cout1+1;
    end
    
    if Load2 ~= 0
        cout2=cout2+1;
    end
%     
    if Load3 ~= 0
        cout3=cout3+1;
    end
    
    if Load4 ~= 0
        cout4=cout4+1;
    end
    
    if Load5 ~= 0
        cout5=cout5+1;
    end
end

Mean_region(1)=sum(region1)/cout1;
Mean_region(2)=sum(region2)/cout2;
Mean_region(3)=sum(region3)/cout3;
Mean_region(4)=sum(region4)/cout4;
Mean_region(5)=sum(region5)/cout5;
%reload
for i = 1:regions
    K(i).centroid = Mean_region(i);

end

update1=K(1).centroid;
update2=K(2).centroid;
update3=K(3).centroid;
update4=K(4).centroid;
update5=K(5).centroid;

end

AA1=reshape(region1,[wd wd]);
AA2=reshape(region2,[wd wd]);
AA3=reshape(region3,[wd wd]);
AA4=reshape(region4,[wd wd]);
AA5=reshape(region5,[wd wd]);
% figure;
% imshow(AA1,[]);
figure(7);
subplot(1,2,1);
imshow(AA2,[]);
title('Fovea Region1');
subplot(1,2,2);
imshow(AA3,[]);
title('Fovea Region2');
% subplot(1,3,3);
% imshow(AA4,[]);
% figure;
% imshow(AA5,[]);
handles.AA2=AA2;
handles.AA3=AA3;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Out.
function Out_Callback(hObject, eventdata, handles)
% hObject    handle to Out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
out=handles.Image;
out1=handles.U;
out2=handles.AA2;
out3=handles.AA3;
axes(handles.one);
imshow(out);
title('Input Image');
axes(handles.two);
imshow(out1,[]);
title('Retina Vessels');
axes(handles.three);
imshow(out2,[]);
title('Fovea Region1');
axes(handles.four);
imshow(out3,[]);
title('Fovea Region2');


% --- Executes on button press in Features.
function Features_Callback(hObject, eventdata, handles)
% hObject    handle to Features (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

U=handles.U;
AA2=handles.AA2;
AA3=handles.AA3;

[Contrast,Correlation, Energy,Homogeneity ] = GLCM(U);
Feat1 = [Contrast,Correlation, Energy,Homogeneity ];
M_AA2 = mean(mean(AA2));
E_AA2 = entropy(AA2);

M_AA3 = mean(mean(AA3));
E_AA3 = entropy(AA3);

Qfeat = [Feat1,M_AA2,E_AA2,M_AA3,E_AA3]';
save Qfeat Qfeat
display(Qfeat);


helpdlg('Input Features extracted');
handles.Qfeat = Qfeat;

%%update handles structure
guidata(hObject, handles);


% --- Executes on button press in Database_load.
function Database_load_Callback(hObject, eventdata, handles)
% hObject    handle to Database_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% nnlearn;
helpdlg('Database loaded successfully');


% --- Executes on button press in Training.
function Training_Callback(hObject, eventdata, handles)
% hObject    handle to Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load dBfeat;

%%%%%Neural network creation and training 

%%%%Assigning target to each class features
Nc = 5; T=1;
for dfi=1:size(dBfeat,2)
   
    if Nc<1
      T = T+1;
      Nc =4;
      acti(:,dfi) = T; 
    else
      acti(:,dfi) = T;  
      Nc = Nc-1;  
    end
end
       
actv = ind2vec(acti);   %%%%%Indices to vector creation

netp = newrnn(dBfeat,actv);   %%%%network training

save netp netp;

helpdlg('Training Process Completed');


% --- Executes on button press in Classification.
function Classification_Callback(hObject, eventdata, handles)
% hObject    handle to Classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load netp;
Q = handles.Qfeat;

%%%%%%% Image Classification
    out = sim(netp,Q);
    out = round(vec2ind(out));

    if out ==1
        
        set(handles.text3,'String','DECISION');
        set(handles.text4,'String','Normal');
        
    elseif out ==2
     
        set(handles.text3,'String','DECISION');
        set(handles.text4,'String','Low affect'); 
        
    elseif out ==3
        
        set(handles.text3,'String','DECISION');
        set(handles.text4,'String','High affect');
    
    else

        set(handles.text3,'String','DB Updation Required');
       
    end    
    
    
    



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
