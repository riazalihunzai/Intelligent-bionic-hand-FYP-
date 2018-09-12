clc; 
clear all; close all;
fclose('all');
instrreset;
loc = 'E:\8TH SEMESTER\CS482\Dataset\';
flist = dir([loc '*.txt']);

vec = zeros([250 40*4]); vctr = 1;
labels = zeros([4 40*4]);

for counter = 1:1:length(flist)
  
    fid = fopen([loc flist(counter).name]);
    while (~feof(fid))
        cl = fgetl(fid);
        cc = strsplit(cl, ',');
        temp = cc{1, 1};
        idx = strfind(temp, '[');
    %% vec(1, vctr) = str2double(temp(idx+1:end));
        x= str2double(temp(idx+1:end));
        vec(1, vctr)=x/1023;
        for jj = 2:1:length(cc)-1
            vec(jj, vctr) = str2double(cc{jj})/1023;
        end
        
        fname = flist(counter).name;
        [~, fxt, ~] = fileparts(fname);
        clabel = str2double(fxt(end));        
        labels(clabel, vctr) = 1;
        vctr = vctr + 1;
    end
    %vctr
end

% Create a neural network for pattern Recognition
hiddenLayerSize = [20 20];
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};

net.layers{1}.transferFcn = 'poslin';
net.layers{2}.transferFcn = 'poslin';

[net,tr] = train(net,vec,labels);


