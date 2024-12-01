# Iris: Dynamic Privacy Preserving Search in Authenticated Chord Peer-to-Peer Networks

This repository contains the code and the data used in the paper *Iris: Dynamic Privacy Preserving Search in Authenticated Chord Peer-to-Peer Networks* appear at [NDSS Symposium 2025](https://www.ndss-symposium.org/ndss2025/). Initially, we provide the instructions to set up and run our code. We then elaborate further on the experiments we have performed.

## Dependencies

1. **Hardware Dependencies:**
Any computer that can run Matlab or GNU Octave.
For our implementation we use a computer with
an Intel Core i7-4820K processor and 16 GB installed RAM memory.

2. **OS & Software Dependencies:**
The code can be executed on any operation system that supports Matlab or Octave, e.g., Windows, MacOS, or Ubuntu. 
We test our code on Windows 10, Education edition, version 22H2,
running the Matlab version R2023a with an academic licence.
However, as the code does not use any special libraries, GNU Octave,
an open-source alternative to Matlab, is also sufficient to run the scripts.
A GNU Octave docker image can be downloaded from [this](https://github.com/gnu-octave/docker) link.

## Code Instructions

Below, we provide the commands to run the code on a Linux-based machine.

1. **Clone the Repository:**
   ```bash
   # git clone the repo
   git clone https://github.com/angakt/iris
   # go to directory
   cd iris-main
   ```
2. **Install & Run Octave software:** 
    ```bash
    # for Debian-based systems
    sudo apt install octave
    # to run octave cli
    octave
    # to add the current directory to search path
    addpath(genpath(pwd))
    ```
3. **Create the Address Spaces:**
    ```bash
    # the script saves the generated id spaces
    # under the /experiments folder
    script_CreateIdSpaces
    ```   
4. **Execute Iris:**
   ```bash
   # this script invokes Iris for a set of experiments
   # and saves the data of every set at a mat file
   # the requester and the target address are chosen uniformly at random
   script_ExecuteIris
   ```

## Reproducibility Instructions

Our code consists of five sets of experiments. For general instructions regarding the execution of the experiments, we refer the reader to Section D of the [Artifact Appendix](./AE_Appendix.pdf). Below, we provide an overview of the experiments performed. 

 1. [Figure 6a](experiments/results/fig_DistancesPerAlpha/data/distances_per_alpha.pdf) [1 human-minute + 1 compute-minute]: For this experiment we execute Iris examining its performance for different values
for the α parameter. To achieve that we run the script_ExecuteIris.m file, setting the α parameter equal to {0.25, 0.35, 0.5, 0.75}. In this experiment we study the convergence to the target, thus, we focus on the dist_N2Op variable. To compare Iris with the vanilla Chord, we need to execute the script_ExecuteChord script. The script loads the data of one of the previous executions of Iris (line 8), executes Chord for the same requester and target addresses and saves the distance data. The script in experiments/results/fig_DistancesPerAlpha/script_PlotDistancesPerAlpha.m, plots in matlab the dist data on the same figure.

3. [Figure 6b](experiments/results/fig_DistancesPerDelta/data/distances_per_delta.pdf) [1 human-minute + 1 compute-minute]: This experiment follows the same logic with the experiment presented above, 
however, in this case we alter the δ parameter between the Iris executions.

4. [Figure 7](experiments/results/fig_PrivacyPerAttackers/data/PrivacyPerAttackers.pdf) [1 human-minute + 5 compute-minute]: This exepriment follows the same logic with the two experiments presented above, 
however, in this case we alter the f parameter, which controls the fraction of colluding adversaries, between the Iris executions. To find the minimum privacy ratio we get on every step across different executions, we run the ./experiments/results/fig_PrivacyPerAttackers/script_FindMinPrivacyRatio.m script. To plot the data on one figure in matlab we run the ./experiments/results/fig_PrivacyPerAttackers/script_PlotMinPrivacyRatioPerAttackers.m script.

5. [Figure 8](experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta/data/histogram_or.pdf) [1 human-minute + 1 compute-minute]: This experiment studies how the selected addresses of the
random point and the target are distributed across the selection interval. To execute the experiment we run the ./experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta/script_PlotDistancesNormalizedByDelta.m script that loads a mat file aquired by runing the script_ExecuteIris.m script. The script plots the distances as histograms normalised by δ and saves them into two csv files.

6. [Figure 9](experiments/results/fig_Probabilities/fig_ConditionalProbabilities/data/P(O=35|R=x).pdf) [1 human-minute + 1 compute-minute]: This experiments studies the attackers advantage by calculating
the probabilities for the target to have a specific value by knowing the random point that is picked by Iris. The probabilities are calculated and plotted
by running the matlab scrip experiments/results/fig_Probabilities/fig_ConditionalProbabilities/script_PlotProbabilities.m on the two csv files that were
generated in the previous experiment.

**Order of Execution**: 

1. Experiments in Figures 6, 7 and 8 are independent, thus, the scripts can be run following a different order from the
one presented in the paper. The experiment in Figure 9 uses the data generated by the experiment in Figure 8.

2. For the experiments in Figures 7, 8 and 9 we alter IRIS so as to focus solely on the nodes that have a correct estimation regarding the target.
Thus, we need to comment lines 27-31 and uncomment lines 35-40 in Iris.m file.

>[!NOTE]
>Detailed instructions for the reproducibility of the figures can be found in Section E of the [Artifact Appendix](./AE_Appendix.pdf). The plotting scripts are written in either Matlab or R. We include them for completeness but we do not consider them part of our contribution

## Citation

If you use Iris or our code, please consider citing our paper.

```
@InProceedings{aktypi2025iris,
  title = {Iris: Dynamic Privacy Preserving Search in Authenticated Chord Peer-to-Peer Networks},
  author = {Aktypi, Angeliki and Rasmussen, Kasper},
  year = {2025},
  booktitle = {Proceedings of the 32nd Annual Network and Distributed System Security Symposium (NDSS '25)},
  isbn = {979-8-9894372-8-3},
  keywords = {p2p; chord; privacy; authentication},
  month = {February},
  doi = {10.14722/ndss.2025.240392},
}
```
