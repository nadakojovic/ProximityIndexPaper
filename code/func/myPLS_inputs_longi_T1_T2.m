%% Define all inputs for PLS in Medical Image Processing Toolbox

% Parameters include:
%   - input: Struct with input data
%   - pls_opts: Options for PLS analysis
%   - save_opts: Options for saving results and plotting

%% Input data preparation
clear all; clc;

% Load data
load('phen_longi.mat');
names_phen_l = phen_baseline.Properties.VariableNames;
phen_baseline=table2array(phen_baseline);
phen_followup=table2array(phen_followup);

% Define output path and create directory
output_path = fullfile(filesep, 'Volumes', 'CODE_development', 'Nada', 'PROXIMITY', 'GIT_HUB_Proximity');
mkdir(output_path);
cd(output_path);

% Prepare phenotype data
phen_bf = [phen_baseline, phen_followup];
phen_bf(any(isnan(phen_bf), 2), :) = [];

% Regress out age 
phen_baseline = phen_bf(:, 1:5);
phen_followup = phen_bf(:, 6:end);
phen_baseline_r = regress_out(phen_baseline(:, 2:end), phen_baseline(:, 1), []);
phen_followup_r = regress_out(phen_followup(:, 2:end), phen_followup(:, 1), []);

% Create variables for baseline and follow-up
for i = 1:size(phen_baseline, 2)
    eval([strcat(names_phen_l{i}, '_b') '=  phen_baseline(:, i)']);
    eval([strcat(names_phen_l{i}, '_f') '=  phen_followup(:, i)']);
end

%% Variables setup



dx_cov = ones(length(Age_b), 1); % Diagnosis or group

Y0behav=[ADOS_TOT_f,PEP_CVP_DQ_f, VABS_TOT_f];
% if you want to regress nuisance variables, do it here
% --- brain data ---
% Matrix X0 is typically a matrix with brain imaging data,
% of size subjects (rows) x imaging features (columns)
X0=PI_longi_b;
input.brain_data=X0;

% --- behavior data ---
% Matrix Y0 is a a matrix containing behavior data,
% of size subjects (rows) x behavior features (columns)
% Y0 will be constructed depending on the pls_opts.behav_type:
%   * if behav_type = 'contrast': behavData can be empty, Y0 will only depend
%     on the grouping information
%   * if behav_type = 'behavior': Y0 will be identical to behavData 
%   * if behav_type = 'contrastBehav', or 'contrastBehavInteract': 
%     Y0 will be constructed based on the grouping information and behavData
input.behav_data = Y0behav; 

% --- grouping data ---
% subj_grouping: group assignment vector
% binary variable indicating the group, can contain multiple groups


input.grouping = ones(size(X0,1),1);
% --- Names of the groups ---
% here you can specify the names of the groups for the plots
input.group_names={'ASD'}; %% the first name is the smallest number in your groups

% --- Names of the behavior data ---

input.behav_names = {'Total Symptom Severity ADOS-2',...
    'Verbal & Preverbal Cognition PEP-3',...
'Adaptive Behavior Composite Score VABS-II'}

% --- Names of the imaging data ---
% will only be used if save_opts.img_type='barPlot'
% for ii = 1:3; input.img_names{ii,1} = ['img ' num2str(ii)]; end
input.img_names={'Proximity Index '}

%clear agecov dxcov gendercov dataMat2Dmasked idcov

%% ---------- Options for PLS ----------

% --- Permutations & Bootstrapping ---
pls_opts.nPerms = 1000;
pls_opts.nBootstraps = 1000;

% --- Data normalization options ---
% 0: no normalization
% 1: zscore across all subjects (default)
% 2: zscore within groups
% 3: std normalization across subjects (no centering)
% 4: std normalization within groups (no centering)
pls_opts.normalization_img = 1;
pls_opts.normalization_behav =1;

% --- PLS grouping option ---
% 0: PLS will computed over all subjects
% 1: R will be constructed by concatenating group-wise covariance matrices
%     (as in conventional behavior PLS, see Krishnan et al., 2011)
pls_opts.grouped_PLS =0; 

% --- Permutations grouping option ---
% 0: permutations ignoring grouping
% 1: permutations within group
pls_opts.grouped_perm =0;

% --- Bootstrapping grouping option ---
% 0: bootstrapping ignoring grouping
% 1: bootstrapping within group
pls_opts.grouped_boot = 0;

% --- Mode for bootstrapping procrustes transform ---
% in some cases, rotation only depending on U results in extremely low
% standard errors and bootstrap ratios close to infinity
% in mode 2, we therefore compute the transformation matrix both on U and V
% 1: standard
% 2: average rotation of U and V
pls_opts.boot_procrustes_mod = 2;

% --- Save bootstrap resampling data? ---
% select whether bootstrapping resampling data should be saved (only
% recommended for few imaging dimensions)
pls_opts.save_boot_resampling=1;

% --- Type of behavioral analysis ---
% 'behavior' for standard behavior PLS
% 'contrast' to simply compute contrast between two groups
% 'contrastBehav' to combine contrast and behavioral measures
% 'contrastBehavInteract' to also consider group-by-behavior interaction effects
pls_opts.behav_type = 'behavior';
%pls_opts.behav_type = 'contrast';
%% ---------- Options for result saving and plotting ----------
% --- path where to save the results ---
save_opts.output_path = output_path;

% --- prefix of all results files ---
% this is also the default prefix of the toolbox if you don't define
% anything
save_opts.prefix = sprintf('myPLS_%s_norm%d-%d',pls_opts.behav_type,...
    pls_opts.normalization_img, pls_opts.normalization_behav);

% --- Plotting grouping option ---
% 0: Plots ignoring grouping
% 1: Plots considering grouping
save_opts.grouped_plots = 0;

% --- Significance level for latent components ---
save_opts.alpha = 0.05; % for the sake of the example data

% --- Type of brain data ---
% Specify how to plot the results
% 'volume'  for voxel-based data in nifti Format - results will be 
%           displayed as bootstrap ratios in a brain map
% 'corrMat' for ROI-to-ROI correlation matrix - results will be displayed
%           as bootstrap ratios in a correlation matrix
% 'barPlot' for any type of brain data in already vectorized form - results 
%           will be displayed as barplots

% % uncomment the following to see example for volumetric plotting:
save_opts.img_type = 'barPlot';


% uncomment the following to see example for barplot figures:
input.brain_data = input.brain_data;

save_opts.fig_pos_img = [100   100   800   400];
% --- Brain visualization thresholds ---
% (thresholds for bootstrap scores and loadings, only required if imagingType='volume' or imagingType='corrMat')
save_opts.BSR_thres = [-3 3]; % negative and positive threshold for visualization of bootstrap ratios
save_opts.load_thres = [-0.23 0.23]; % negative and positive threshold for visualization of loadings


% --- Bar plot options ---
save_opts.plot_boot_samples = 1; % binary variable indicating if bootstrap samples should be plotted in bar plots
save_opts.errorbar_mode = 'CI'; % 'std' = plotting standard deviations; 'CI' = plotting 95% confidence intervals
save_opts.hl_stable = 1; % binary variable indicating if stable bootstrap scores should be highlighted

% --- Customized figure size for behavior bar plots ---
save_opts.fig_pos_behav = [100   100   800   400];
