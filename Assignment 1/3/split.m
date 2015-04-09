function [attributes, target] = split(boston)

attributes = boston(:,1:13);
target = boston(:,14);
