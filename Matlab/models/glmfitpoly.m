clear
addpath('../jsonlab');

datasetfilename=loadjson(['../datasetfilename.json']);

load('../dataclean/rawedited.mat');
indata=rawedited;
indata=indata(~any(isnan(indata),2),:);
%dateseries=datetime(indata(:,1),'ConvertFrom','datenum'); % In Datetime format
trainingsize=1100;
index_target=3;


%% Reading JSON files 
%JSON File with settings for inputs and outpus.
datajson=loadjson(['' filesep 'neuraljsonObj.json']);

inputfromjson = datajson{1,1}.inputdata_ids;
modelingid = datajson{1,1}.modelingid;
outputfromjson = datajson{1,1}.outputdata_ids;

%% Data Setup For Neural Network.
%% Data Setup For Neural Network.
%Preparing for Inputs and Outputs for NEural network
inputs=[];
for i=1:length(inputfromjson)
    
 indexforcol = inputfromjson{1,i} ;  
 inputs = [inputs indata(:,str2num(indexforcol)+1)];

end


% Output
outputs=[];
for i=1:length(outputfromjson)
    
 indexforcol1 = outputfromjson{1,i};   
 outputs = [outputs indata(:,str2num(indexforcol1)+1)];

end
%%
xraw=inputs;
yraw=outputs;
timeseries=datetime(indata(1:end,1),'ConvertFrom','datenum'); % In Datetime format



%%
mdl2 =  fitglm(xraw(1:end,:),yraw(1:end),'quadratic','Distribution','poisson');%binomial,poisson
r2 = mdl2.Residuals.Raw
mse(r2)
 
disp(mdl2)
yreg = mdl2.Fitted.Response;

%%% to plot the target with the predictions

figure

hold on
plot(1:1:length(yraw), yraw(1:end),'b-')
plot(1:1:length(yreg), yreg(1:end)','k','LineWidth',2)

%% Save Informations

% Store Plot for training data set
field1='yraw';
value1= {yraw'};
field2= 'yreg';
value2= {yreg'};
field3='timeseries';
value3= {timeseries'};


modelingresults = struct(field1,value1,field2,value2,field3,value3);
savejson('modelingresults',modelingresults,'modelingresults.json');