# Seasonal Dynamics and Community Assembly in Disturbed Environments

[![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)](#)
[![Ecology](https://img.shields.io/badge/Ecology-Community%20Assembly-4CAF50?style=flat-square)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)](#)

## Overview
This repository contains the computational analysis pipeline for my undergraduate final-year project investigating ecological community structures across varying seasons and environmental damage gradients. The project employs a rigorous approach to theoretical ecology, pairing individual- and sample-based stochastic simulations with empirical data to evaluate species richness, functional diversity, and community assembly rules. 

Additionally, it incorporates Species Distribution Modeling (SDM) using BioClim variables to predict suitable habitat ranges for focal species such as *Colotis fausta* and *Maniola telmessia*.

## Key Features & Methodology
The analytical pipeline is structured into four core modules:

* **Community Assembly Rules**: Tests for non-random species co-occurrence and nestedness. The analysis utilizes quasi-swap null models and evaluates C0 and R1 metrics across seasonal parameters to determine assembly significance.
* **Functional Diversity & Richness**: Quantifies ecological structures using Hill numbers, Shannon indices, and Rao's Q. Includes both sample-based and individual-based rarefaction curves to standardize richness comparisons across sampling efforts.
* **Multivariate Environmental Analysis**: Principal Component Analysis (PCA) evaluates community-environment associations. Community matrices are Hellinger-log transformed to stabilize variance before projecting against anthropogenic damage levels (badly damaged, small damage, no damage).
* **Species Distribution Modeling (SDM)**: Utilizes presence-only occurrence records mapped against high-resolution `wc10` bioclimatic raster layers to predict habitat suitability.
