# Wildfire Effects on Butterfly Community Ecology

[![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)](#)
[![Ecology](https://img.shields.io/badge/Ecology-Community%20Assembly-4CAF50?style=flat-square)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)](#)

This repository contains the analysis scripts and figures produced for my community ecology final project, "The effect of wildfire on the butterfly community in Kfira nature reserve (Jerusalem mountains, Israel)". 

Using three years of citizen-science monitoring data (2019–2021) from the Israel Lepidopterists’ Society, this project investigates how varying degrees of fire damage influence ecosystem recovery, species richness, and community structure.

## Key Analyses
* **Alpha & Beta Diversity:** Individual-based rarefaction curves, diversity profiles (Hill numbers), and Bray-Curtis dissimilarity indices to compare "no damage", "small damage", and "badly damaged" sites across seasons.
* **Ordination:** Principal Component Analysis (PCA) incorporating Log10 and Hellinger transformations to map community variance and identify dominant species.
* **Functional Diversity:** Functional evenness assessments based on organismal traits, specifically wingspan and larval host range (specialist, generalist, or ant mutualist).
* **Null Models & Assembly Rules:** Standardized Effect Size (SES) evaluations using R1, C0, and Quasiswap models to test for patterns of nestedness and species aggregation.
* **Species Distribution Modeling (SDM):** Generalized Additive Models (GAM) utilizing temperature, precipitation, and GBIF data to predict the large-scale climatic vulnerability of dominant species like *Colotis fausta*.

## Core Findings
The analyses indicate that seasonal shifts exert a far more dominant effect on the butterfly community than the habitat destruction caused by the fire. While differences in species richness between damaged and non-damaged sites were significant during the spring, likely driven by the blooming of annual plants, most functional diversity and beta diversity metrics showed high similarity across fire damage classifications within each season.
