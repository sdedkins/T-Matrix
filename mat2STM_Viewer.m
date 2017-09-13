function [obj] = mat2STM_Viewer(mat,E_start,E_end,n_E)
%Function to view a matrix data in STM Viewer 2
%INPUT: the matrix
s = size(mat);
if length(s)==3
    n_layers = s(3);
else
    n_layers = 1;
end
new_data = make_struct;
new_data.map = mat;
new_data.r = 1:s(1);
new_data.e = linspace(E_start,E_end,n_E);
new_data.name = 'matrix';
new_data.type = 3;
new_data.var = '';
obj = new_data;
img_obj_viewer2(new_data);