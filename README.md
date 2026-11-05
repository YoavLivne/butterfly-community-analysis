# Seasonal Dynamics and Community Assembly in Disturbed Environments

[![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)](#)
[![Ecology](https://img.shields.io/badge/Ecology-Community%20Assembly-4CAF50?style=flat-square)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)](#)

## Overview
This repository contains the computational analysis pipeline for my undergraduate final-year project investigating ecological community structures across varying seasons and environmental damage gradients[cite: 1]. The project employs a rigorous approach to theoretical ecology, pairing individual- and sample-based stochastic simulations with empirical data to evaluate species richness, functional diversity, and community assembly rules[cite: 1]. 

Additionally, it incorporates Species Distribution Modeling (SDM) using BioClim variables to predict suitable habitat ranges for focal species such as *Colotis fausta* and *Maniola telmessia*[cite: 1].

## Key Features & Methodology
The analytical pipeline is structured into four core modules:

* **Community Assembly Rules**: Tests for non-random species co-occurrence and nestedness[cite: 1]. The analysis utilizes quasi-swap null models and evaluates C0 and R1 metrics across seasonal parameters to determine assembly significance[cite: 1].
* **Functional Diversity & Richness**: Quantifies ecological structures using Hill numbers, Shannon indices, and Rao's Q[cite: 1]. Includes both sample-based and individual-based rarefaction curves to standardize richness comparisons across sampling efforts[cite: 1].
* **Multivariate Environmental Analysis**: Principal Component Analysis (PCA) evaluates community-environment associations[cite: 1]. Community matrices are Hellinger-log transformed to stabilize variance before projecting against anthropogenic damage levels (badly damaged, small damage, no damage)[cite: 1].
* **Species Distribution Modeling (SDM)**: Utilizes presence-only occurrence records mapped against high-resolution `wc10` bioclimatic raster layers to predict habitat suitability[cite: 1].

## Repository Structure

```text
├── data/
│   ├── Final data updated.csv             # Cleaned and processed community dataset
│   ├── Final data wide with ID.csv        # Wide-format matrix for multivariate analysis
│   └── wc10/                              # BioClim environmental layers for SDM
├── scripts/
│   ├── Assembly rules.Rmd                 # Null models, quasi-swap algorithms, and nestedness
│   ├── Functional diversity.Rmd           # Calculation of Rao's index, evenness, and divergence
│   ├── Quantifying diversity.Rmd          # Hill numbers and Shannon diversity indices
│   ├── Quantifying richness.Rmd           # Individual- and sample-based rarefaction curves
│   └── SDM.Rmd                            # Species Distribution Modeling methodology
├── figures/
│   ├── assembly_rules/                    # C0/R1 indices and significance testing plots
│   ├── functional_diversity/              # Seasonal divergence and evenness visualizations
│   ├── pca/                               # Hellinger-transformed PCA biplots by damage level
│   └── richness_and_sdm/                  # Rarefaction curves and prediction maps
└── README.md
