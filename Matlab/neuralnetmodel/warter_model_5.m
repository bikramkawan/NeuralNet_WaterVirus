%% water treatment
% Razak Friday 13 Nov. 2015

clear all;
close all;
clc
%% load the data set
rawdata = xlsread('./Noro data.xlsx');
% remove any NAN - cleaning
rawdata =rawdata(all(~isnan(rawdata),2),:);
t = rawdata(:,1);
t_str = datestr(t,'mm','local');
t = str2num(t_str); % time in months
% convert time in seasons
% winter
t(find(t==1|t==2 |t==12)) = 1;
%spring
t(find(t==3|t==4 |t==5 )) = 0;%0 2
%Summer
t(find(t==6|t==7 |t==8 )) = 0;%0 3
%Autumin 
t(find(t==9|t==10|t==11)) = 0;%0 4

t_winter = t;

data_length = length(rawdata);

xraw = [rawdata(:,3:7) t_winter];
yraw = rawdata(:,2);   % total Noro no.particles/mL
n = 10;
ysmooth = medfilt1(yraw,n);
xraw = repmat(xraw,20,1);
%yraw = repmat(yraw,20,1);
yraw = repmat(ysmooth,20,1);
month = datenum(rawdata(:,1));
%% plot (display) data
figure
subplot(711)
hold on
plot(month, xraw(1:data_length,1),'k-')
plot([month(1) month(end)],[7 7],'r')  % add a horizontal line at 7 pH
datetick('x','mmm')
ylabel('pH','FontWeight','bold')
title('pH')
%axis([0 data_length min(xraw(1:data_length,1)) max(xraw(1:data_length,1))])
grid

subplot(712)
plot(month, xraw(1:data_length,2),'k-')
datetick('x','mmm')
ylabel('NTU','FontWeight','bold') %  Nephelometric Turbidity Units (NTU).
title('Turbidity')
%axis([0 data_length round(min(xraw(1:data_length,2))) round(max(xraw(1:data_length,2)))])
grid

subplot(713)
plot(month, xraw(1:data_length,3),'k-')
datetick('x','mmm')
title('Conductivity')
ylabel('S/m','FontWeight','bold') % siemens per meter (S/m).
%axis([0 data_length round(min(xraw(1:data_length,3))) round(max(xraw(1:data_length,3)))])
grid

subplot(714)
plot(month, xraw(1:data_length,4),'k-')
datetick('x','mmm')
title('Rain')
ylabel('mm/day','FontWeight','bold')
%axis([0 data_length round(min(xraw(1:data_length,4))) round(max(xraw(1:data_length,4)))])
grid

subplot(715)
plot(month, xraw(1:data_length,5),'k-')
datetick('x','mmm')
title('Daily Temp.')
ylabel('^oC','FontWeight','bold')
%axis([0 data_length round(min(xraw(1:data_length,5))) round(max(xraw(1:data_length,5)))])
grid

subplot(716)
plot(month, xraw(1:data_length,6),'k-')
datetick('x','mmm')
title('Winter')
%ylabel('C')
%axis([0 data_length round(min(xraw(1:data_length,6))) round(max(xraw(1:data_length,6)))])
grid

subplot(717)
plot(month, yraw(1:data_length,1),'k-')
datetick('x','mmm')
title('NoV count')
ylabel('n','FontWeight','bold')
xlabel('Time (months)')
%axis([month(1) month(end) round(min(yraw(1:data_length,1)))-2 round(max(yraw(1:data_length,1)))])
grid
%% scatter plot
figure
subplot(321)
hold on
scatter(month,yraw(1:data_length),'k.')
xlabel('Season')
ylabel('Noro')
%axis([min(x1) max(x1) min(y) max(y)])
grid

subplot(322)
hold on
scatter(x1,y,'k.')
xlabel('pH')
ylabel('Noro')
axis([min(x1) max(x1) min(y) max(y)])
grid

subplot(323)
plot(x2,y,'k.')
xlabel('Turbidity')
ylabel('Noro')
%title('scatter plot of Noro vs. Turbidity')
axis([min(x2) max(x2) min(y) max(y)])
grid

subplot(324)
plot(x3,y,'k.')
xlabel('Conductivity')
ylabel('Noro')
axis([min(x3) max(x3) min(y) max(y)])
grid

subplot(325)
plot(x4,y,'k.')
xlabel('Rain')
ylabel('mm per day')
axis([min(x4) max(x4) min(y) max(y)])
grid

subplot(326)
plot(x5,y,'k.')
xlabel('Daily Temp.')
ylabel('Noro')
axis([min(x5) max(x5) min(y) max(y)])
grid
%% statitical analysis of sample
n = length(xraw)
%mean
data_length
xm = mean(xraw(1:data_length,1:end-1))
ym = mean(yraw(1:data_length,1))
%standard deviation
xd = std(xraw(1:data_length,1:end-1))
yd = std(yraw(1:data_length,1))
% variance
xv = var(xraw(1:data_length,1:end-1))
yv = var(yraw(1:data_length,1))
%skewness: Skewness is a measure of the asymmetry of the data around the sample mean. If skewness is negative, the data are spread out more to the left of the mean than to the right. If skewness is positive, the data are spread out more to the right. The skewness of the normal distribution (or any perfectly symmetric distribution) is zero.
xs = skewness(xraw(1:data_length,1:end-1))
ys = skewness(yraw(1:data_length,1))
% check if the data are from nornal distribution
%'norm'	Normal distribution
%'exp'	Exponential distribution
%'ev'	Extreme value distribution
%'logn'	Lognormal distribution
%'weibull'	Weibull distribution
% If h = 1, this indicates the rejection of the null hypothesis at the Alpha significance level.
% If h = 0, this indicates a failure to reject the null hypothesis at the Alpha significance level.
[h,p] = adtest(xraw(1:data_length,1),'Distribution','weibull')
[h,p] = adtest(yraw(1:data_length,1),'Distribution','norm')
vartestn([xraw(1:data_length,1:end) yraw(1:data_length,1)])
%% box plot
figure
subplot(231)
boxplot([xraw(1:data_length,1)],'notch','on','labels',{'pH'},'outliersize',6)%,'plotstyle','compact','whisker',1,
%ylabel('pH','FontWeight','bold')
set(gca,'FontSize',14)

subplot(232)
boxplot([xraw(1:data_length,2)],'notch','on','labels',{'Turbidity (NTU)'},'outliersize',6)%,'plotstyle','compact','whisker',1,
%ylabel('NTU','FontWeight','bold')
set(gca,'FontSize',14)

subplot(233)
boxplot([xraw(1:data_length,3)],'notch','on','labels',{'Conductivity (S/m)'},'outliersize',6)%,'plotstyle','compact','whisker',1,
%ylabel('S/m','FontWeight','bold')
set(gca,'FontSize',14)

subplot(234)
boxplot([xraw(1:data_length,4)],'notch','on','labels',{'Rain (mm/day)'},'outliersize',6)%,'plotstyle','compact','whisker',1,
%ylabel('mm/day','FontWeight','bold')
set(gca,'FontSize',14)

subplot(235)
boxplot([xraw(1:data_length,5)],'notch','on','labels',{'Temp. (^oC)'},'outliersize',6)%,'plotstyle','compact','whisker',1,
%ylabel('^oC','FontWeight','bold')
set(gca,'FontSize',14)

subplot(236)
boxplot([yraw(1:data_length,1)],'notch','on','labels',{'Norovirus (n)'},'outliersize',6)%,'plotstyle','compact','whisker',1,
set(gca,'FontSize',14)

%% scatter plot
figure
[S,AX,BigAx,H,HAx] = plotmatrix([xraw(1:data_length,1:end) yraw(1:data_length,1)]);
ylabel(AX(1,1),'pH')
ylabel(AX(2,1),'Turbidity')
ylabel(AX(3,1),'Conductivity')
ylabel(AX(4,1),'Rain')
ylabel(AX(5,1),'Temperature')
ylabel(AX(6,1),'Time')
ylabel(AX(7,1),'Norovirus')
xlabel(AX(7,1),'pH')
xlabel(AX(7,2),'Turbidity')
xlabel(AX(7,3),'Conductivity')
xlabel(AX(7,4),'Rain')
xlabel(AX(7,5),'Temperature')
xlabel(AX(7,6),'Time')
xlabel(AX(7,7),'Norovirus')


%figure
%[S,AX,BigAx,H,HAx] = plotmatrix([t, x,log(y)]);

%% correlation to decide which variables are correlated
[RHO,PVAL] = corr([x, t],y)
[r,p] = corrcoef([x,t,y])
[i,j] = find(p<0.05);  % find significant correlations
[i,j]                  % display their (row,col) indices
printmat(r)
% x1 & x2
% x1 & x5
% x2 & x3
% x2 & y  -- y = f(x2, x3, x5)
% x3 & x4
% x3 & x5
% x3 & y
% x4 & x5
% x5 & y
%% ANN model #1
%% fit net
inputs = [xraw]';
targets = yraw';
% rng(200,'v4');
rng(0)
% Create a Fitting Network
hiddenLayerSize = 25;
net1 = fitnet(hiddenLayerSize);
% Set up Division of Data for Training, Validation, Testing
% net.divideFcn = 'dividetrain';  % No validation or test data
net1.divideParam.trainRatio = 70/100;
net1.divideParam.valRatio = 15/100;
net1.divideParam.testRatio = 15/100;
net1.trainFcn = 'trainbr';
net1.plotFcns = {'plotperform','plottrainstate','ploterrhist','plotregression', 'plotfit'};
% net = configure(net,ptrans,tn);

net1.layers{1}.transferFcn = 'logsig';
net1.layers{2}.transferFcn = 'tansig';%'purelin';%'tansig';
% Train the Network
[net1,tr] = train(net1,inputs,targets);
tr.best_epoch;
effective_param = tr.gamk;
effective_no_of_parameters = effective_param(length(effective_param));
wt_IL=net1.IW{1,1};
wt_HL= net1.LW{2,1};
bias_IL=net1.b{1};
bias_HL=net1.b{2};
% Test the Network
y1 = net1(inputs);
errors = gsubtract(y1,targets);
performance = perform(net1,targets,y1)
mse(yraw(1:data_length)-y1(1:data_length)')

%% response plot
figure
subplot(2,1,1)
hold on
plot(month, yraw(1:data_length),'b-')
plot(month, y1(1:data_length)','k','LineWidth',2)
datetick('x','mmm')
legend('Measured','Predicted')
%axis([0 data_length min([yraw(1:data_length); outputs(1:data_length)']) max([yraw(1:data_length); outputs(1:data_length)'])])
%grid
ylabel('Count','FontWeight','bold')
title('ANN Response','FontWeight','bold','FontSize', 12)
%title('Time Series NARX Feedback NN Response','FontWeight','bold','FontSize', 12)

subplot(2,1,2)
plot(month, yraw(1:data_length)-y1(1:data_length)','k-')
datetick('x','mmm')
xlabel('Time (months)','FontWeight','bold')
ylabel('Error','FontWeight','bold')
%% generate code using ntstool
%% try narxnet
% Solve an Autoregression Problem with External Input with a NARX Neural Network
% Script generated by Neural Time Series app
% Created 07-Jun-2016 12:06:44
%
% This script assumes these variables are defined:
%
%   x - input time series.
%   y - feedback time series.

X = tonndata(xraw,false,false);
T = tonndata(yraw,false,false);

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
%trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
trainFcn = 'trainbr';  % Levenberg-Marquardt backpropagation.



% Create a Nonlinear Autoregressive Network with External Input
inputDelays = 1:2;
feedbackDelays = 1:2;
hiddenLayerSize = 10;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize,'open',trainFcn);

% Prepare the Data for Training and Simulation
% The function PREPARETS prepares timeseries data for a particular network,
% shifting time by the minimum amount to fill input states and layer
% states. Using PREPARETS allows you to keep your original time series data
% unchanged, while easily customizing it for networks with differing
% numbers of delays, with open loop or closed loop feedback modes.
[x,xi,ai,t] = preparets(net,X,{},T);

% Setup Division of Data for Training, Validation, Testing
%net.divideFcn = 'divideblock';
 net.divideParam.trainRatio = 70/100;
 net.divideParam.valRatio = 15/100;
 net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t,xi,ai);

% Test the Network
y2 = net(x,xi,ai);
e = gsubtract(t,y2);
performance = perform(net,t,y2)

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t(1:data_length),y(1:data_length))
%figure, plotresponse(t(1:data_length),y(1:data_length))
%figure, ploterrcorr(e)
%figure, plotinerrcorr(x,e)

% Closed Loop Network
% Use this network to do multi-step prediction.
% The function CLOSELOOP replaces the feedback input with a direct
% connection from the outout layer.
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc)
[xc,xic,aic,tc] = preparets(netc,X,{},T);
yc = netc(xc,xic,aic);
closedLoopPerformance = perform(net,tc,yc)

% Step-Ahead Prediction Network
% For some applications it helps to get the prediction a timestep early.
% The original network returns predicted y(t+1) at the same time it is
% given y(t+1). For some applications such as decision making, it would
% help to have predicted y(t+1) once y(t) is available, but before the
% actual y(t+1) occurs. The network can be made to return its output a
% timestep early by removing one delay so that its minimal tap delay is now
% 0 instead of 1. The new network returns the same outputs as the original
% network, but outputs are shifted left one timestep.
nets = removedelay(net);
nets.name = [net.name ' - Predict One Step Ahead'];
view(nets)
[xs,xis,ais,ts] = preparets(nets,X,{},T);
ys = nets(xs,xis,ais);
stepAheadPerformance = perform(nets,ts,ys)

% for plotting
y2 = cell2mat(y2);

%% response plot
figure
subplot(2,1,1)
hold on
plot(month, yraw(1:data_length),'b-')
plot(month, y2(1:data_length)','k','LineWidth',2)
datetick('x','mmm')
legend('Measured','Predicted')
%axis([0 data_length min([yraw(1:data_length); outputs(1:data_length)']) max([yraw(1:data_length); outputs(1:data_length)'])])
%grid
ylabel('Count','FontWeight','bold')
title('ANN Response','FontWeight','bold','FontSize', 12)
%title('Time Series NARX Feedback NN Response','FontWeight','bold','FontSize', 12)

subplot(2,1,2)
plot(month, yraw(1:data_length)-y2(1:data_length)','k-')
datetick('x','mmm')
xlabel('Time (months)','FontWeight','bold')
ylabel('Error','FontWeight','bold')
mse(yraw(1:data_length)-y2(1:data_length)')
%% ANFIS
%ANFIS setup
%tb1 = table(x1, x2, x3, x4, x5, t, y,'VariableNames',{'pH' 'Turbidity' 'Conductivity' 'Rain' 'Temperature' 'Time' 'Norovirus'});

trnData = [xraw yraw];
numMFs = 2*[1 1 1 1 1 1];
mfType = 'gbellmf'; % char('pimf','trimf')
fis = genfis1(trnData,numMFs,mfType);
%fis = genfis1(tb1,numMFs,mfType);

ruleview(fis)
surfview(fis)
figure
gensurf(fis,[2 3],1)
%%
figure(2)
%title('gbellmf of inputs')

[xx,mf] = plotmf(fis,'input',1);
subplot(3,2,1), plot(xx,mf);
xlabel('pH','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

[xx,mf] = plotmf(fis,'input',2);
subplot(3,2,2), plot(xx,mf);
xlabel('Turbidity','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

[xx,mf] = plotmf(fis,'input',3);
subplot(3,2,3), plot(xx,mf);
xlabel('Conductivity','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

[xx,mf] = plotmf(fis,'input',4);
subplot(3,2,4), plot(xx,mf);
xlabel('Rain','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

[xx,mf] = plotmf(fis,'input',5);
subplot(3,2,5), plot(xx,mf);
xlabel('Temperature','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

[xx,mf] = plotmf(fis,'input',6);
subplot(3,2,6), plot(xx,mf);
xlabel('Time (season)','FontWeight','bold');
ylabel('\mu','FontWeight','bold');
grid

%% 
% training
epoch_n = 250;
dispOpt = zeros(1,4);
fis = anfis(trnData,fis,epoch_n,dispOpt);
ruleview(fis)
% you can see for example, output mf
fis.output.mf.params

%mse
y3 = evalfis(xraw,fis)
e  = yraw-y3;
perf = mse(e)
plotfis(fis)
%% response plot
figure
subplot(2,1,1)
hold on
plot(month, yraw(1:data_length),'b-')
plot(month, y3(1:data_length)','k','LineWidth',2)
datetick('x','mmm')
legend('Measured','Predicted')
%axis([0 data_length min([yraw(1:data_length); outputs(1:data_length)']) max([yraw(1:data_length); outputs(1:data_length)'])])
%grid
ylabel('Count','FontWeight','bold')
title('ANFIS Response','FontWeight','bold','FontSize', 12)
%title('Time Series NARX Feedback NN Response','FontWeight','bold','FontSize', 12)

subplot(2,1,2)
plot(month, yraw(1:data_length)-y3(1:data_length),'k-')
datetick('x','mmm')
xlabel('Time (months)','FontWeight','bold')
ylabel('Error','FontWeight','bold')
%% surf view
figure(3)
subplot(5,3,1)
gensurf(fis,[1 2],1) %1
xlabel('pH')
ylabel('Turb')
zlabel('NoV')

subplot(5,3,2)
gensurf(fis,[1 3],1) %2
xlabel('pH')
ylabel('Cond')
zlabel('NoV')

subplot(5,3,3)
gensurf(fis,[1 4],1) %3
xlabel('pH')
ylabel('Rain')
zlabel('NoV')

subplot(5,3,4)
gensurf(fis,[1 5],1) %4
xlabel('pH')
ylabel('Temp')
zlabel('NoV')

subplot(5,3,5)
gensurf(fis,[1 6],1) %5
xlabel('pH')
ylabel('Time')
zlabel('NoV')

subplot(5,3,6)
gensurf(fis,[2 3],1) %6
xlabel('Turb')
ylabel('Cond')
zlabel('NoV')

subplot(5,3,7)
gensurf(fis,[2 4],1) %7
xlabel('Turb')
ylabel('Rain')
zlabel('NoV')

subplot(5,3,8)
gensurf(fis,[2 5],1) %8
xlabel('Turb')
ylabel('Temp')
zlabel('NoV')

subplot(5,3,9)
gensurf(fis,[2 6],1) %9
xlabel('Turb')
ylabel('Time')
zlabel('Noro')

subplot(5,3,10)
gensurf(fis,[3 4],1) %10
xlabel('Cond')
ylabel('Rain')
zlabel('Noro')

subplot(5,3,11)
gensurf(fis,[3 5],1) %11
xlabel('Cond')
ylabel('Temp')
zlabel('Noro')

subplot(5,3,12)
gensurf(fis,[3 6],1) %12
xlabel('Cond')
ylabel('Time')
zlabel('Noro')

subplot(5,3,13)
gensurf(fis,[4 5],1) %13
xlabel('Rain')
ylabel('Temp')
zlabel('Noro')

subplot(5,3,14)
gensurf(fis,[4 6],1) %14
xlabel('Rain')
ylabel('Time')
zlabel('Noro')

subplot(5,3,15)
gensurf(fis,[5 6],1) %15
xlabel('Temp')
ylabel('Time')
zlabel('Noro')
%% correlation to decide which variables are correlated
[RHO,PVAL] = corr(xraw,yraw)
[r,p] = corrcoef([xraw,yraw], 'rows','pairwise')
[i,j] = find(p<0.05);  % find significant correlations
[i,j]                  % display their (row,col) indices
printmat(r)
%% correlation matrix plot
[R,PValue] = corrplot([xraw,yraw],'varNames',{'pH','Turbidity','Conductivity','Rain','Temperature','Time','NoV'});

%% Multiple linear regression
[B,BINT,R,RINT,STATS] = regress(yraw(1:data_length),xraw(1:data_length,:))
mse(R)
%% Generalized linear Poisson regression model (glmfit)
% poisson distrubution regression model
mdl1 =  fitglm(xraw(1:data_length,:),yraw(1:data_length),'linear','Distribution','poisson');%binomial,poisson
r1 = mdl1.Residuals.Raw
mse(r1)
% adding interaction to the model
mdl2 =  fitglm(xraw(1:data_length,:),yraw(1:data_length),'quadratic','Distribution','poisson');%binomial,poisson
r2 = mdl2.Residuals.Raw
mse(r2)
% fit model specification
modelspec = 'y ~ x2 + x3 + x4 + x5 + t + x3:t + x3^2';
modelspec = 'Var7 ~ Var6 + Var1:Var4 + Var1:Var6 + Var2:Var3 + Var4:Var5 + Var5:Var6 + Var2^2';
modelspec = 'Var7 ~ Var1 + Var2 + Var3 + Var4 + Var5 + Var1:Var2 + Var1:Var3 + Var1:Var5 + Var2:Var5 + Var2:Var6 + Var3:Var4 + Var3:Var5 + Var3:Var6 + Var4:Var6  + Var1^2 + Var3^2 + Var4^2 + Var5^2';
modelspec = 'Var7 ~ Var1 + Var2 + Var3 + Var4 + Var5 + Var1:Var2 + Var1:Var3 + Var1:Var5 + Var3:Var4 + Var3:Var5 + Var3:Var6 + Var4:Var6  + Var1^2 + Var3^2 + Var4^2 + Var5^2';
tbl = table(xraw(1:data_length,1), xraw(1:data_length,2),xraw(1:data_length,3),xraw(1:data_length,4),xraw(1:data_length,5),xraw(1:data_length,6),yraw(1:data_length));
%mdl =  fitglm(tbl,'ResponseVar','Var8');
%mdl =  fitglm(tbl,modelspec, 'ResponseVar','Var7','Distribution','poisson');
mdl3 =  fitglm(tbl,modelspec,'Distribution','poisson');
%mdl3 =  fitglm(tbl,modelspec);
r3 = mdl3.Residuals.Raw
mse(r3)

disp(mdl2)
yreg = mdl2.Fitted.Response;

% Dubin-Watson test
[p,d] = dwtest(r2,xraw(1:data_length,:))
%% response plot
figure
subplot(2,1,1)
hold on
plot(month, yraw(1:data_length),'b-')
plot(month, yreg(1:data_length)','k','LineWidth',2)
datetick('x','mmm')
legend('Measured','Predicted')
%axis([0 data_length min([yraw(1:data_length); outputs(1:data_length)']) max([yraw(1:data_length); outputs(1:data_length)'])])
%grid
ylabel('Count','FontWeight','bold')
title('GLPRM Response','FontWeight','bold','FontSize', 12) % GLPRM = Generalized linear Poisson regression model
%title('Time Series NARX Feedback NN Response','FontWeight','bold','FontSize', 12)

subplot(2,1,2)
plot(month, yraw(1:data_length)-yreg(1:data_length),'k-')
datetick('x','mmm')
xlabel('Time (months)','FontWeight','bold')
ylabel('Error','FontWeight','bold')

%% Comparseson between model responses
figure
hold on
plot(month, yraw(1:data_length),'k-')
plot(month, yreg(1:data_length)','g-.','LineWidth',1)
plot(month, y1(1:data_length)','b:','LineWidth',1)
plot(month, y2(1:data_length)','r-','LineWidth',1)
datetick('x','mmm')
legend('Measured','Reg','ANN','ANFIS')
%axis([0 data_length min([yraw(1:data_length); outputs(1:data_length)']) max([yraw(1:data_length); outputs(1:data_length)'])])
%grid
ylabel('NoV (n)','FontWeight','bold')
title('Comparson between model Responses','FontWeight','bold','FontSize', 12) % GLPRM = Generalized linear Poisson regression model
xlabel('Time (months)','FontWeight','bold')
grid

%END 
%% Multiple linear regression
[b,bint] = regress(yraw,xraw)
mdl = fitlm(xraw,yraw)
mdl1 = fitlm(xraw,yraw,'quadratic'); % 'interactions'
disp(mdl1)
f = mdl1.Fitted
r = mdl1.Residuals.Raw

% poisson distrubution regression model
mdl =  fitglm(xraw(),yraw(),'linear','Distribution','poisson');%binomial,poisson
r = mdl.Residuals.Raw

yy = smooth(y);
figure
plot(y,'k')
hold on
plot(yy,'r')
% Residuals vs. fitted values
figure
plotResiduals(mdl,'fitted')



mdl =  fitglm([x t],y,'quadratic','Distribution','poisson');
modelspec = 'y ~ x1 + x2 + x3 + x4 + x5 + t + x1:x2 + x1:x3 + x1:x5 + x1:t + x2:x3 + x2:x4 + x2:t + x3:x4 + x3:x5 + x3:t + x4:t +x5:t + x1^2 + x3^2 + x5^2';
modelspec = 'y ~ x1+x2+x3+x4+x5+t + x1:x2:x3:x4:x5:t + x1^3 + x3^2 + x5^3';

modelspec = 'y ~ x1 + x2 + x3 + x4 + x5 + t + x3:t +x5:t + x1^3 + x3^2 + x5^3';
modelspec = 'y ~ x2 + x3 + x4 + x5 + t + x3:t +x5:t + x1^3 + x3^2 + x5^3 -x1^2';
modelspec = 'y ~ x2 + x3 + x4 + x5 + t + x3:t + x3^2';

tb1 = table(x1,x2,x3,x4,x5,t,y);
mdl =  fitglm(tb1,modelspec,'Distribution','poisson');

mdl1 =  fitglm(tb1,'quadratic','Distribution','poisson');

mdl =  fitglm([t x(:,2) x(:,3) x(:,5)],yy,'quadratic','Distribution','poisson'); %'poisson', 'binomial','normal'
mdl =  fitglm([t x(:,2) x(:,3) x(:,5)],yy,'quadratic','Distribution','normal'); %'poisson', 'binomial','normal'

xx = [x2 x5 x2.*x3 x3.*x5 x3.^2];% x3.^2];

disp(mdl)
yfit = mdl.Fitted.Response;
yreg = mdl.Fitted.Response;
r = mdl.Residuals.Raw
mse(r)
plot(r)
plot(y, yfit,'k+')

%% comparison between regression model and ANN
figure
hold on
plot(targets,'-', 'Color',[0.75,0.75,0.75],'LineWidth',2)
plot(outputs','k','LineWidth',2)
plot(yfit,'b','LineWidth',2)

%plot(errors,'-', 'Color',[0.75,0.75,0.75])
legend('target', 'ANN','Regres')
axis([0 length(targets) -100 400])
grid


% centering and standardization 
%[x,mu_x,std_x] = zscore(x);
%[y,mu_y,std_y] = zscore(y);
figure
hold on
plot(x)
plot(y)
% to get inverse zscore: x = Z*std + mu

x1 = x(:,1);       % pH
x2 = x(:,2);       % Turbidity NTU/mL
x3 = x(:,3);       % Conductivity EC/mL
x4 = x(:,4);       % Rain mm/hr
x5 = x(:,5);       % Daily temperature oC
clear('rawdata','t_str');

%% Multiple linear regression
[B,BINT,R,RINT,STATS] = regress(yraw,xraw);

mdl = fitlm(xraw,yraw)
mdl1 = fitlm([x t],y,'quadratic'); % 'interactions'
disp(mdl1)
f = mdl1.Fitted
r = mdl1.Residuals.Raw

% poisson distrubution regression model
mdl =  fitglm([x t],y,'linear','Distribution','poisson');%binomial,poisson
r = mdl.Residuals.Raw

yy = smooth(y);
figure
plot(y,'k')
hold on
plot(yy,'r')
% Residuals vs. fitted values
figure
plotResiduals(mdl,'fitted')
% Dubin-Watson test
[p,d] = dwtest(r,[x t])


mdl =  fitglm([x t],y,'quadratic','Distribution','poisson');
modelspec = 'y ~ x1 + x2 + x3 + x4 + x5 + t + x1:x2 + x1:x3 + x1:x5 + x1:t + x2:x3 + x2:x4 + x2:t + x3:x4 + x3:x5 + x3:t + x4:t +x5:t + x1^2 + x3^2 + x5^2';
modelspec = 'y ~ x1+x2+x3+x4+x5+t + x1:x2:x3:x4:x5:t + x1^3 + x3^2 + x5^3';

modelspec = 'y ~ x1 + x2 + x3 + x4 + x5 + t + x3:t +x5:t + x1^3 + x3^2 + x5^3';
modelspec = 'y ~ x2 + x3 + x4 + x5 + t + x3:t +x5:t + x1^3 + x3^2 + x5^3 -x1^2';
modelspec = 'y ~ x2 + x3 + x4 + x5 + t + x3:t + x3^2';

tb1 = table(x1,x2,x3,x4,x5,t,y);
mdl =  fitglm(tb1,modelspec,'Distribution','poisson');

mdl1 =  fitglm(tb1,'quadratic','Distribution','poisson');

mdl =  fitglm([t x(:,2) x(:,3) x(:,5)],yy,'quadratic','Distribution','poisson'); %'poisson', 'binomial','normal'
mdl =  fitglm([t x(:,2) x(:,3) x(:,5)],yy,'quadratic','Distribution','normal'); %'poisson', 'binomial','normal'

xx = [x2 x5 x2.*x3 x3.*x5 x3.^2];% x3.^2];

disp(mdl)
yfit = mdl.Fitted.Response;
yreg = mdl.Fitted.Response;
r = mdl.Residuals.Raw
mse(r)
plot(r)
plot(y, yfit,'k+')





ano = anova(mdl)
plotAdded(mdl)
plotResiduals(mdl,'probability')
plotResiduals(mdl)
plotResiduals(mdl,'fitted')
fdata = feval(mdl1,[t x]);
I = abs(fdata - ydata) > 1.5*std(ydata);
outliers = excludedata(xdata,ydata,'indices',I);

fit2 = fit(xdata,ydata,f,'StartPoint',[1 1],...
           'Exclude',outliers);


NewMPG = feval(mdl,Xnew)
%xx = [ones(size(x1)) x2.*x3 x3.*x5];% x3.^2];
xx = [x2 x3 x5];% x3.^2];
xx = [x2.*x3 x3.*x5];% x3.^2];

xx = [x2.*x3 x3.*x5 x3.^2];% x3.^2];
xx = [x2 x5 x2.*x3 x3.*x5 x3.^2];% x3.^2];

[b,bint] = regress(y,xx)
mdl2 = fitlm(xx,y)
yfit = -188.3+137.41*x2-33.27*x2.*x3-0.47*x3.*x5+11.50*x3.*x3;
yfit = -209.39+116.45*x2+34.07*x5-29.02*x2.*x3-7.36*x3.*x5+11.71*x3.*x3;
yfit = -2.18 + 0.98*x2+0.29*x5-0.24*x2.*x3-0.06*x3.*x5+0.10*x3.*x3;

ano = anova(mdl2)
plotAdded(mdl2)
plotResiduals(mdl2,'probability')
plotResiduals(mdl2)
plotResiduals(mdl2,'fitted')


errors = gsubtract(yfit,y);
e = y-yfit;

yfit = feval(mdl2,xx);
I = abs(yfit - y) > 1.5*std(y);
xx_new = xx(~I,:)
y_new = y(~I,:)
mdl3 = fitlm(xx_new,y_new)
yfit = feval(mdl3,xx_new);
e = y_new-yfit;



figure
hold on
%plot(y,'b')
%plot(yfit,'k')
plot(y_new, yfit,'k.')
%plot(e,'g')
legend('targets','outputs','errors')
grid

figure
hold on
plot(y,'-', 'Color',[0.125,0.125,0.125])
plot(yfit,'b','LineWidth',2)
%plot(e,'-', 'Color',[0.75,0.75,0.75])
legend('y','yfit')%,'error')
axis([0 length(y) min([y; yfit]) max([y; yfit])])
grid

%% MRM (multivariable regression model)modeling
% may be plot scatter plot to check linearity
scatter(x(:,1),t)

size(x)
[beta,Sigma] = mvregress(x,t);
%% ANN modeling
% Create a Nonlinear Autoregressive Network with External Input
inputDelays = 1:4;
feedbackDelays = 1:4;
hiddenLayerSize = 10;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);


% Prepare the Data for Training and Simulation
% The function PREPARETS prepares time series data 
% for a particular network, shifting time by the minimum 
% amount to fill input states and layer states.
% Using PREPARETS allows you to keep your original 
% time series data unchanged, while easily customizing it 
% for networks with differing numbers of delays, with
% open loop or closed loop feedback modes.
[inputs,inputStates,layerStates,targets] = preparets(net,x,{},t);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets,inputStates,layerStates);

% Test the Network
outputs = net(inputs,inputStates,layerStates);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotregression(targets,outputs)
% figure, plotresponse(targets,outputs)
% figure, ploterrcorr(errors)
% figure, plotinerrcorr(inputs,errors)

% Closed Loop Network
% Use this network to do multi-step prediction.
% The function CLOSELOOP replaces the feedback input with a direct
% connection from the output layer.
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc)
[xc,xic,aic,tc] = preparets(netc,inputSeries,{},targetSeries);
yc = netc(xc,xic,aic);
closedLoopPerformance = perform(netc,tc,yc)

% Early Prediction Network
% For some applications it helps to get the prediction a 
% timestep early.
% The original network returns predicted y(t+1) at the same 
% time it is given y(t+1).
% For some applications such as decision making, it would 
% help to have predicted y(t+1) once y(t) is available, but 
% before the actual y(t+1) occurs.
% The network can be made to return its output a timestep early 
% by removing one delay so that its minimal tap delay is now 
% 0 instead of 1.  The new network returns the same outputs as 
% the original network, but outputs are shifted left one timestep.
nets = removedelay(net);
nets.name = [net.name ' - Predict One Step Ahead'];
view(nets)
[xs,xis,ais,ts] = preparets(nets,inputSeries,{},targetSeries);
ys = nets(xs,xis,ais);
earlyPredictPerformance = perform(nets,ts,ys)


%%
% compare
figure
hold on
plot(y,'-','Color',[0.75,0.75,0.75],'LineWidth',2)
plot(yreg,'-','Color','b','LineWidth',2)
plot(outputs','-','Color','r','LineWidth',2)
plot(evalfis([x t],fis),'-','Color','g','LineWidth',2)
legend('Training Data','Regression','ANN','ANFIS')
grid
xlabel('Time')
ylabel('Norovirus count')
%%



