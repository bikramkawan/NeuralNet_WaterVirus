% Solve an Autoregression Problem with External Input with a NARX Neural Network
% Script generated by Neural Time Series app
% Created 07-Jun-2016 20:38:32
%
% This script assumes these variables are defined:
%
%   inputs_data - input time series.
%   targets_data - feedback time series.
function WaterNN()
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
%inputs_data=rawedited(13:trainingsize,:); % Inputs including targets
inputs_data=inputs(1:trainingsize,:);
targets_data=outputs(1:trainingsize,:);
training_dates=datetime(indata(1:trainingsize,1),'ConvertFrom','datenum'); % In Datetime format


%testdata_inputs=rawedited(trainingsize+1:length(rawedited),:);
testdata_inputs=inputs(trainingsize+1:length(inputs),:);
testdata_targets=outputs(trainingsize+1:length(outputs),:);
test_date=datetime(indata(trainingsize+1:length(indata),1),'ConvertFrom','datenum'); % In Datetime format


X = tonndata(inputs_data,false,false);
T = tonndata(targets_data,false,false);
test_in = tonndata(testdata_inputs,false,false);
test_target = tonndata(testdata_targets,false,false);
%%
% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Nonlinear Autoregressive Network with External Input
inputDelays = 1:2;
feedbackDelays = 1:2;
hiddenLayerSize = 10;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize,'open',trainFcn);
net.trainParam.showWindow=0;
% Prepare the Data for Training and Simulation
% The function PREPARETS prepares timeseries data for a particular network,
% shifting time by the minimum amount to fill input states and layer
% states. Using PREPARETS allows you to keep your original time series data
% unchanged, while easily customizing it for networks with differing
% numbers of delays, with open loop or closed loop feedback modes.
[x,xi,ai,t] = preparets(net,X,{},T);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t,xi,ai);

% Test the Network
y = net(x,xi,ai);
e = gsubtract(t,y);
performance_traindata = perform(net,t,y)

[x1,xi1,ai1,t1] = preparets(net,test_in,{},test_target);
yout=net(x1,xi1,ai1);
e = gsubtract(t1,yout);
performance_testdata = perform(net,t1,yout)

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotresponse(t,y)
%figure, ploterrcorr(e)
%figure, plotinerrcorr(x,e)

% Closed Loop Network
% Use this network to do multi-step prediction.
% The function CLOSELOOP replaces the feedback input with a direct
% connection from the outout layer.
% netc = closeloop(net);
% netc.name = [net.name ' - Closed Loop'];
% %view(netc)
% [xc,xic,aic,tc] = preparets(netc,X,{},T);
% yc = netc(xc,xic,aic);
% closedLoopPerformance = perform(net,tc,yc)

% Step-Ahead Prediction Network
% For some applications it helps to get the prediction a timestep early.
% The original network returns predicted y(t+1) at the same time it is
% given y(t+1). For some applications such as decision making, it would
% help to have predicted y(t+1) once y(t) is available, but before the
% actual y(t+1) occurs. The network can be made to return its output a
% timestep early by removing one delay so that its minimal tap delay is now
% 0 instead of 1. The new network returns the same outputs as the original
% network, but outputs are shifted left one timestep.
% nets = removedelay(net);
% nets.name = [net.name ' - Predict One Step Ahead'];
% %view(nets)
% [xs,xis,ais,ts] = preparets(nets,X,{},T);
% ys = nets(xs,xis,ais);
% stepAheadPerformance = perform(nets,ts,ys)

%% Plot Training and Testing 
figure(1)
y1=cell2mat(y);
y1=y1';
plot(targets_data(2:end),'r');
hold on
plot(y1,'--');
legend('Targets', 'Predicted');

%% Testing New Data Set
figure(2)
y2=cell2mat(yout);
y2=y2';
plot(testdata_targets(2:end),'r');
hold on
plot(y2,'--');
legend('Targets', 'Predicted');

%% Save Informations

% Store Plot for training data set
field1='traindate';
value1= {training_dates(3:end)'};
field2='traintargets';
value2= {targets_data(3:end)'};
field3='trainout';
value3= {y1'};

% Store Plot for testing data set

field4 = 'testdate';
value4 = {test_date(3:end)'};
field5 = 'testtargets';
value5 = {(testdata_targets(3:end))'};
field6 = 'testout';
value6 = {y2'};

neuralnetresult = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);
savejson('neuralnetresult',neuralnetresult,'neuralnetresult.json');