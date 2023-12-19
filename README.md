# TrotroPaper

## Overview

This repository contains MATLAB scripts used for generating figures in our paper, "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions in Autism." Each script corresponds to a specific figure in the paper, providing detailed analyses of visual exploration patterns in children with Autism Spectrum Disorder (ASD) compared to Typically Developing (TD) children.

## Requirements

- [Proximity_Index](https://github.com/nadakojovic/Proximity_Index) for obtaining the Proximity Index values for the comparison group.
- [myPLS-1](https://github.com/valkebets/myPLS-1) for multivariate analyses between the Proximity Index, phenotype measures, and movie characteristics.
- [GBVS Saliency Toolbox](http://www.animaclock.com/harel/share/gbvs.php) for saliency analyses.

## Scripts Description

### Divergence from Typical Gazing Patterns, Its Relation to Clinical Phenotype, and Movie Properties

- **02_cs_group_difference_pi.m**: Analyzes the average Proximity Index (PI) to capture moment-to-moment gaze deployment differences in ASD children compared to the TD group while watching an animated social scene.
- **03_myPLS_main_PI_crossectional.m**: Explores divergence in visual exploration and its association with phenotype in children with ASD using multivariate analysis (Partial Least Squares).
- **04_ambient_focal_fixations.m**: Provides complementary analysis of visual behavior, characterizing attention exploration modes in ASD and TD children.

### Influence of Basic Visual Properties of an Animated Scene on Gaze Allocation in ASD and TD Children

- **06_myPLS_main_PI_movie_regressors.m**: Investigates the association of movie content with divergence in visual exploration in the ASD group.

### Developmental Patterns of Visual Exploration

- **07_myPLS_main_longi_PI.m**: Examines divergence in visual exploration and its association with unfolding autistic symptomatology a year later.
- **08_pairwise_distances_permutation.m**: Analyzes divergent developmental trajectories of visual exploration in children with ASD.

## Citation

Please cite our paper if you use these scripts in your research:

- Kojovic, N., et al. "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions in Autism." [Journal], [Year]. DOI: [Insert DOI]

For any further inquiries or assistance, please contact [Nada.Kojovic].
