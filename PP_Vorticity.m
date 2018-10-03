%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                             POST-PROCESSING                             %
%                                VORTICITY                                %
%                                                                         %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% Giuseppe Di Labbio                                                      %
% Department of Mechanical, Industrial & Aerospace Engineering            %
% Concordia University Montr�al, Canada                                   %
%                                                                         %
% Last Update: October 3rd, 2018 by Giuseppe Di Labbio                    %
%                                                                         %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% SYNTAX                                                                  %
%                                                                         %
% VRT = PP_Vorticity(VGT);                                                %
%                                                                         %
% DESCRIPTION                                                             %
%                                                                         %
% This function computes the vorticity of a velocity field given its      %
% velocity gradient tensor. The function detects if the calculation is    %
% two or three dimensional.                                               %
%                                                                         %
% References:                                                             %
% N/A                                                                     %
%                                                                         %
% ----------------------------------------------------------------------- %
% Variables:                                                              %
% ----------------------------------------------------------------------- %
% 'VGT'        - STRUCT                                                   %
%              - Velocity gradient tensor containing the four components  %
%                'UX', 'UY', 'VX' and 'VY' in 2D or the nine components   %
%                'UX', 'UY', 'UZ', 'VX', 'VY', 'VZ', 'WX', 'WY' and 'WZ'  %
%                in 3D.                                                   %
% ----------------------------------------------------------------------- %
% 'VRT'        - 2D DOUBLE ARRAY OR STRUCT                                %
%              - Vorticity vector either containing a single component in %
%                2D (in which case it will no be a struct) or three       %
%                components in 3D.                                        %
% ----------------------------------------------------------------------- %
%                                                                         %
% EXAMPLE                                                                 %
%                                                                         %
% Calculate the vorticity of a time-dependent double gyre on the domain   %
% (x,y) = [0,2]x[0,1] with a constant grid spacing of 0.01 over the time  %
% interval [0,20] with time-step size 0.1. Use A = 0.1, epsilon = 0.25,   %
% and omega = 2*pi/10.                                                    %
%                                                                         %
% >> x = linspace(0, 2, 201).';                                           %
% >> y = linspace(0, 1, 101).';                                           %
% >> t = linspace(0, 20, 21).';                                           %
% >> A = 0.1;                                                             %
% >> epsn = 0.25;                                                         %
% >> omga = 2*pi/10;                                                      %
% >> [VEC, VGT] = GEN_DoubleGyre(x, y, t, A, epsn, omga);                 %
% >> VRT = cell(length(t),1);                                             %
% >> for k = 1:length(t)                                                  %
% VRT{k} = PP_Vorticity(VGT{k});                                          %
% end                                                                     %
% >> for k = 1:length(t)                                                  %
% contourf(VEC{k}.X, VEC{k}.Y, VRT{k}, 'EdgeColor', 'None');              %
% colormap jet;                                                           %
% hold on;                                                                %
% quiver(VEC{k}.X(1:4:end,1:4:end), VEC{k}.Y(1:4:end,1:4:end), ...        %
%        VEC{k}.U(1:4:end,1:4:end), VEC{k}.V(1:4:end,1:4:end), 'k');      %
% hold off;                                                               %
% pause(0.25);                                                            %
% end                                                                     %
% >> clear k;                                                             %
%                                                                         %
% DEPENDENCIES                                                            %
%                                                                         %
% Requires:                                                               %
% N/A                                                                     %
%                                                                         %
% Called in:                                                              %
% N/A                                                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PP_Vorticity
function [VRT] = PP_Vorticity(VGT)

if length(fieldnames(VGT)) == 4
    
    VRT = VGT.VX - VGT.UY;
    
elseif length(fieldnames(VGT)) == 9
    
    VRT = struct('X', 0, 'Y', 0, 'Z', 0);
    
    VRT.x = VGT.WY - VGT.VZ;
    VRT.y = VGT.UZ - VGT.WX;
    VRT.z = VGT.VX - VGT.UY;
    
end

%% %%%%%%%%%%%%%%%%%%%%%%%%% SUPPRESS MESSAGES %%%%%%%%%%%%%%%%%%%%%%%%% %%

%#ok<*N/A>
% Line(s) N/A
% Message(s)
% * N/A
% Reason(s)
% * N/A

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% Line(s) N/A                                                             %
% * N/A.                                                                  %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
