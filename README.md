# TrotroPaper

## Overview

This repository contains MATLAB scripts used for generating figures in our paper, "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions in Autism". Scripts corresponds to a specific figure in the paper, providing detailed analyses of visual exploration patterns in children with Autism Spectrum Disorder (ASD) compared to Typically Developing (TD) children.

## Requirements

- [Proximity_Index](https://github.com/nadakojovic/Proximity_Index) for obtaining the Proximity index values for the coparison group
- [myPLS-1](https://github.com/valkebets/myPLS-1) for multivariate analyses between the Proximity index phenotyope measures and movie characteristics
- [GBVS saliency toolbox](http://www.animaclock.com/harel/share/gbvs.php) for saliency analyses


## Scripts Description

## Divergence from the typical gazing patterns, its relation to clinical phenotype and movie properties
Moment-by-moment divergence from the referent gazing patterns
- **02_cs_group_difference_pi.m** Uses the average Proximity Index (PI) to capture moment-to-moment gaze deployment differences in ASD children compared to the TD group while watching an animated social scene.
- **03_myPLS_main_PI_crossectional.m** Explores divergence in visual exploration and its association with phenotype in children with ASD using multivariate analysis (Partial Least Squares)
- **04_ambient_focal_fixations.m** Complementary analysis of visual behavior with standard measures, characterizing attention exploration modes in ASD and TD children.
### Influence of basic visual properties of an animated scene on gaze allocation in ASD and TD children.

-**06_myPLS_main_PI_movie_regressors.m** The association of movie content with divergence in visual exploration in ASD group

## Developmental patterns of visual exploration
-**07_myPLS_main_longi_PI.m** Divergence in visual exploration and its association with unfolding autistic symptomatology a year later


-**08_pairwise_distances_permutation.m** Divergent developmental trajectories of visual exploration in children with ASD





## Citation

Please cite our paper if you use these scripts in your research:

- Kojovic, N., et al. "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions in Autism." [Journal], [Year]. DOI: [Insert DOI]

For any further
