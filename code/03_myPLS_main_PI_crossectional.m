%% This is the main script to run myPLS Toolbox
%
% ------------------------------STEPS-------------------------------------
%
% The script includes:
%   1. Call of a script with PLS inputs and their description
%   2. Call of the functions to run PLS and plot the results

clc; clear all; close all;

addpath(genpath('./myPLS-master'));
addpath(genpath('./code'))


%% Define all the inputs
% Modify this script to setup your PLS analysis

myPLS_inputs_PI_crossectional

%% Check all inputs for validity
% !!! always run this function to check your setup before running PLS !!!

[input,pls_opts,save_opts] = myPLS_initialize(input,pls_opts,save_opts);

%% Save & plot input data

%myPLS_plot_inputs(input,pls_opts,save_opts)

%% Run PLS analysis (including permutation testing and bootstrapping)


res = myPLS_analysis(input,pls_opts);

%% save_opts.BSR_thres = [-2 2]; % negative and positive threshold for visualization of bootstrap ratios

%%
% PLScoder;
%Mach.Lx_s = X_s * V; IS WHAT YOU GET HERE
%% Save & plot results
% If you run multiple PLS analyses, correct the resulting p-values for
% % multiple comparisons before executing the following function

close all
myPLS_plot_results(res,save_opts);
