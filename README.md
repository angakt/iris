# Iris: Dynamic Privacy Preserving Search in Authenticated Chord Peer-to-Peer Networks

## Code Instructions

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

Our code consists of five sets of experiments. For general instructions regarding the execution of the experiments, we refer the reader to Section D of the [Artifact Appendix](./AE_Appendix.pdf).
Below, we provide some further details regarding the execution of each experiment.

 1. [Figure 6a](experiments/results/fig_DistancesPerAlpha/data/distances_per_alpha.pdf): For this experiment we execute Iris examining its performance for different values
 for the α parameter. To achieve that we run the script_ExecuteIris.m file, setting at line 42 the α parameter equal to {0.25, 0.35, 0.5, 0.75}. In this experiment we study the convergence to the target, thus, we focus on the dist_N2Op variable. To save the distance data from the mat file with the experiment data we run the command:
 
      ```bash
      # when using octave
      csvwrite("data_a1.csv", dist_N2Op)
      # when using matlab
      writematrix(dist_N2Op,['data_a1.csv'])
      ```

   To compare Iris with the vanilla Chord, we need to execute the script_ExecuteChord script. The script loads the data of one of the previous executions of Iris (line 8),
   executes Chord for the same requester and target addresses and saves the distance data. 
   
   The script in experiments/results/fig_DistancesPerAlpha/script_PlotDistancesPerAlpha.m, plots in matlab the dist data on the same figure.

2. [Figure 6b](experiments/results/fig_DistancesPerDelta/data/distances_per_delta.pdf): This experiment follows the same logic with the experiment presented above, 
however, in this case we alter the δ parameter between the Iris executions.

3. [Figure 7](experiments/results/fig_PrivacyPerAttackers/data/PrivacyPerAttackers.pdf): This exepriment follows the same logic with the two experiments presented above, 
however, in this case we alter the f parameter, which controls the fraction of colluding adversaries, between the Iris executions. To find the minimum privacy ratio we get on every step across different executions, we run the ./experiments/results/fig_PrivacyPerAttackers/script_FindMinPrivacyRatio.m script. To plot the data on one figure in matlab we run the ./experiments/results/fig_PrivacyPerAttackers/script_PlotMinPrivacyRatioPerAttackers.m script.

5. [Figure 8](experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta/data/histogram_or.pdf): This experiment studies how the selected addresses of the
random point and the target are distributed across the selection interval. To execute the experiment we run the ./experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta/script_PlotDistancesNormalizedByDelta.m script that loads a mat file aquired by runing the script_ExecuteIris.m script. The script plots the distances as histograms normalised by δ and saves them into two csv files.

6. [Figure 9](experiments/results/fig_Probabilities/fig_ConditionalProbabilities/data/P(O=35|R=x).pdf): This experiments studies the attackers advantage by calculating
the probabilities for the target to have a specific value by knowing the random point that is picked by Iris. The probabilities are calculated and plotted
by running the matlab scrip experiments/results/fig_Probabilities/fig_ConditionalProbabilities/script_PlotProbabilities.m on the two csv files that were
generated in the previous experiment.

**Order of Execution**: Experiments in Figures 6, 7 and 8 are independent, thus, the scripts can be run following a different order from the
one presented in the paper. The experiment in Figure 9 uses the data generated by the experiment in Figure 8.
