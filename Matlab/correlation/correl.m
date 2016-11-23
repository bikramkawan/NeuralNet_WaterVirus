
function correl()
clear
addpath('../jsonlab');

datasetfilename=loadjson(['../datasetfilename.json']);

load('../dataclean/rawedited.mat');
indata=rawedited(:,2:end);
indata=indata(~any(isnan(indata),2),:);
[R,P] = corrcoef(indata);
%{
R(R==1)=[];
R = reshape(R,9,10);
R=R';

P(P==1)=[];
P = reshape(P,9,10);
P=P';
%}


field1 = 'R';
value1 = {R};
field2 = 'P';
value2 = {P};
corrdatajson = struct(field1,value1,field2,value2);
savejson('corrdata',corrdatajson,'corrdata.json');
