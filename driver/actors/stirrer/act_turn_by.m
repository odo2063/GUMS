function [ output_args ] = act_turn_by(degree )
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'ActObj');

string = strcat({'RMR:'},{num2str(degree)});
fprintf(obj1,'%s',string{1});
%ACT_TURN B Summary of this function goes here
%   Detailed explanation goes here


end

