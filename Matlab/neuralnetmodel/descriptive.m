% Descriptive Analysis 
%
%function descriptive()
clear
addpath('../jsonlab');

datasetfilename=loadjson(['../datasetfilename.json']);

load('../dataclean/rawedited.mat');
indata=rawedited;
indata=indata(~any(isnan(indata),2),:);
dateseries=datetime(indata(:,1),'ConvertFrom','datenum'); % In Datetime format

%%
%%%%%%%%%%%%%%%%%%%%%% DAta with date in vector format %%%%%%%%%%%%%%%%%%%%

A= datevec(indata(:,1));
A=A(:,1:3);
A=[A,indata(:,2:end)];
month_col=2;
year_col=1;
tmpA=A;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%% Descriptive Mode Selection %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1= Monthly Basis;
% 2= Yearly Basis;
% 3= Seasonal Basis;

tmp_mode=loadjson(['decriptive_mode.json']);
featureid=str2num(tmp_mode{1,1});

decriptive_mode=str2num(tmp_mode{1,2});


%%%%%%%%%%%% Descriptive Mode Selection %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%% Calculate Monthly Basis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate Mean , Median, Standard Deviation, Min, Max
if decriptive_mode==1
    
    [avg,med,stdev,minimum,maximum]=grpstats(A(:,4:end),A(:,month_col),{'mean','median','std','min','max'});
    %month_id=unique(A(:,month_col));
    month_names={'Januarary';'February';'March';'April';'May';'June'...
        ;'July';'August';'September';'October';'November';'December'};
    %  For Mode
    G=findgroups(A(:,month_col));
    [mod,frequency]=splitapply(@mode,A(:,4:end),G);
    
%%%%%%%% For Box Plot %%%%%%%%%
clear C
C=[indata(:,featureid+1)];
C=C';
% [~,~,ix]=unique(month_data(:,1));
% 
% for i=1:max(ix)
%      B{i}=month_data(ix==i,:);
% end
% 
% C={};
% for k=1:size(B,2)
%    
%     tmp=B(k);
%     tmp=cell2mat(tmp);
%     tmp=tmp(:,2);
%     tmp=tmp(:)';
%    
%     tmp=num2cell(tmp);
%     C{k}={tmp};
% 
% end
%%%%%%% For Box Plot %%%%%%%%
    
    
    
    
end

%%
%%%%%%%%%%%%%%%%%%% For Yearly Basis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if decriptive_mode==2
    
    [avg,med,stdev,minimum,maximum]=grpstats(A(:,4:end),A(:,year_col),{'mean','median','std','min','max'});
    
    year_names=unique(A(:,year_col));
    %  For Mode
    G=findgroups(A(:,year_col));
    [mod,frequency]=splitapply(@mode,A(:,4:end),G);
    
    
    %%%%%%% For Box Plot %%%%%%%%
   % Clear C;
    C=[indata(:,featureid+1)];
    C=C';
%%%%%% For Box Plot %%%%%%%%
    
    
    
end

%%%%%%%%%%%%%%%%%%% For Yearly Basis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
if decriptive_mode==3
    %%%%%%%%%%%%%%%%%%% For Season Basis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 1 = Spring (March , April , May )
    % 2 = Summer (Jun , July , August)
    % 3 = Autumn (September , October,November)
    % 4 = Winter (December, January,February)
    
    Stemp=A(:,month_col);
    S=A(:,month_col);
    index_vector=find(Stemp==1);
    S(index_vector)=4; % Januaray is Winter
    index_vector=find(Stemp==2);
    S(index_vector)=4; % Feb is Winter
    index_vector=find(Stemp==3);
    S(index_vector)=1; % March is Spring
    index_vector=find(Stemp==4);
    S(index_vector)=1; % April is Spring
    index_vector=find(Stemp==5);
    S(index_vector)=1; % May is Spring
    index_vector=find(Stemp==6);
    S(index_vector)=2; % June is Summer
    index_vector=find(Stemp==7);
    S(index_vector)=2; % July is Summer
    index_vector=find(Stemp==8);
    S(index_vector)=2; % August is Summer
    index_vector=find(Stemp==9);
    S(index_vector)=3; % September is Autumn
    index_vector=find(Stemp==10);
    S(index_vector)=3; % October is Autumn
    index_vector=find(Stemp==11);
    S(index_vector)=3; % November is Autumn
    index_vector=find(Stemp==12);
    S(index_vector)=4; % December is Winter
    
    A(:,month_col)=S;
    
    
    [avg,med,stdev,minimum,maximum]=grpstats(A(:,4:end),A(:,2),{'mean','median','std','min','max'});
    
    seasons_names={'Spring','Summer','Autumn','Winter'};
    %  For Mode
    G=findgroups(A(:,month_col));
    [mod,frequency]=splitapply(@mode,A(:,4:end),G);
    


%%%%%%%% For BOX PLOT Data %%%%%%%%%
clear B
season_data=[A(:,month_col) indata(:,featureid+1)];

[~,~,ix]=unique(season_data(:,1));

for i=1:max(ix)
     B{i}=season_data(ix==i,:);
end

C={};
for k=1:size(B,2)
   
    tmp=B(k);
    tmp=cell2mat(tmp);
    tmp=tmp(:,2);
    tmp=tmp(:)';
   
    %tmp=num2cell(tmp);
    C{k}=tmp;
    C=C';

end
%%%%%%%% For BOX PLOT Data %%%%%%%%%
    
    
    
    
    
end
%%%%%%%%%%%%%%%%%%% For Season Basis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%bar(avg(:,1))



%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Save to JSON
field1='mean';
value1= {avg};
field2='median';
value2= {med};
field3='std';
value3= {stdev};
field4 = 'min';
value4 = {minimum};
field5 = 'max';
value5 = {maximum};
field6 = 'mode';
value6 = {mod};
field7 = 'mod_freq';
value7 = {frequency};
if decriptive_mode==1
    field8 = 'months';
    value8 = {month_names'};
end

if decriptive_mode==2
    field8 = 'years';
    value8 = {year_names'};
end

if decriptive_mode==3
    field8 = 'seasons';
    value8 = {seasons_names};
end
    % field9 = 'featuredata';
    % value9 = {indata(:,featureid+1)'};

     field9='boxplotdata';
     value9={C};
% %% Test for BOX PLOT %%
% A=[3 1 2 3
% 4 1 5 6
% 3 2 4 2
% 4 4 6 7
% 8.5 3 2 1];
% clear B
% [~,~,ix]=unique(A(:,2));
% 
% for i=1:max(ix)
%      B{i}=A(ix==i,:);
% end
% 
% C={};
% for k=1:size(B,2)
%     k
%     tmp=B(k);
%     tmp=cell2mat(tmp);
%     tmp=tmp;
%     tmp=tmp(:)';
%    
%     tmp=num2cell(tmp);
%     C{k}={tmp};
% 
% end
% 
% 
% % B=A'
% % B(:)'
% %tmp = struct('field1',C);
%savejson('tmp',C,'tmp.json');
   
desc_result = struct(field1,value1,field2,value2,field3,value3,field4,value4,...
    field5,value5,field6,value6,field7,value7,field8,value8,field9,value9);
savejson('desc_result',desc_result,'desc_result.json');
%savejson('',desc_result,'NoRowBracket',1,'Filename','desc_result.json');
