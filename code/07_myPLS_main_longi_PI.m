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
%uncomment lines to run :

% 1.Prediction PLS-C: PI obtained at T1 and phenotype measures contained a year later (T2)
myPLS_inputs_longi_T1_T2

%2.Simultaneous PLS-C: both PI and phenotype at T2
% myPLS_inputs_longi_T2_T2

% %3.Simultaneous PLS-C: both PI and phenotype at T1
% myPLS_inputs_longi_T1_T1


%% Check all inputs for validity
% !!! always run this function to check your setup before running PLS !!!

[input,pls_opts,save_opts] = myPLS_initialize(input,pls_opts,save_opts);

%% Save & plot input data

%myPLS_plot_inputs(input,pls_opts,save_opts)

%% Run PLS analysis (including permutation testing and bootstrapping)

res = myPLS_analysis(input,pls_opts);

close all
myPLS_plot_results(res,save_opts);
