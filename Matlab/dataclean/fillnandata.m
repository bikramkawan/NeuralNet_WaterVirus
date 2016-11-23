 %function  fillnandata()
%% Load Data
clear 
addpath('../jsonlab');
 
datasetfilename=loadjson(['../datasetfilename.json']);

[indata,labels]=xlsread(strcat('../',datasetfilename{1,1}));

%%
dateindex=1;
matlabdate=x2mdate(indata(:,dateindex)); % Convert from Excel date to Matlab Date
indata=[matlabdate indata(:,dateindex+1:end)];

dateseries=datetime(matlabdate,'ConvertFrom','datenum'); % In Datetime format
index_target=3;

rawwater=[indata(:,dateindex) indata(:,dateindex+1:end)];

timeseries=[1:1:length(rawwater)]';
x=timeseries;
rawedited=[];

for i=(dateindex+1):size(rawwater,2)
y=rawwater(:,i);
xi=x(find(~isnan(y)));
yi=y(find(~isnan(y)));
rawedited=[rawedited interp1(xi,yi,x,'linear')];
end
rawedited = [rawwater(:,1) rawedited];

%% Save Information
save('rawedited.mat','rawedited');

field1='dateseries';
value1= {dateseries'};
field2 = 'rawdata';
value2 = {(rawwater)'};
field3 = 'cleandata';
value3 = {(rawedited)'};
field4 = 'timeseries';
value4 = {timeseries'};
cleandata = struct(field1,value1,field2,value2,field3,value3,field4,value4);
savejson('cleandata',cleandata,'cleandata.json');
savejson('labels',labels,'labels.json');