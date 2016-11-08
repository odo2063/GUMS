function [ output_args ] = act_turn_to( degree )
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'ActObj');

string = strcat({'RMA:'},{num2str(degree)});
fprintf(obj1,'%s',string{1});
%ACT_TURN_TO Summary of this function goes here
%   Detailed explanation goes here


end

