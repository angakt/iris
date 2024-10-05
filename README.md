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
5. **Execute Chord:**
   ```bash
   # this script executes Chord for the same
   # requester and target addresses as the ones 
   # used in Iris execution
   script_ExecuteChord
   ```

## Reproducibility Instructions

Our code consists of four sets of experiments. To extract the data for each one of them
we need to execute the script_ExecuteIris.m script. This script includes some hard coded values:
the α (line 34) and the δ (line 43) parameters, the fraction of malicious nodes (line 54),
the number of the performed experiments (lines 9-18) and the number of participating nodes in the network (line 21).

 1. [Figure 6a](./experiments/results/fig_DistancesPerAlpha): For this experiment we execute Iris examining its performance for different values intially for the α parameter. To achieve that we run
 script_ExecuteIris.m setting at line 34 the α parameter equal to {0.25, 0.35, 0.5, 0.75}. In this experiment we study the convergence
 to the target, thus, we focus on the dist_N2Op variable. To save the distance data from every set of experiments we can run the command:
 
   ```bash
   # when using octave
   csvwrite("data_a1.csv", dist_N2Op)
   # when using matlab
   writematrix(dist_N2Op,['data_a1.csv'])
   ```

   The Chord distance data are aquired by executing the script_ExecuteChord script, running the last command presented in the above section.
   The script in experiments/results/fig_DistancesPerAlpha/script_PlotDistancesPerAlpha.m, plots in matlab the dist data on the same figure.

2. [Figure 6b](./experiments/results/fig_DistancesPerDelta): This exepriment follows the same logic with experiment presented above, 
however, in this case we alter the δ parameter between the Iris executions.

3. [Figure 7](./experiments/results/fig_PrivacyPerAttackers): This exepriment follows the same logic with the two experiments presented above, 
however, in this case we alter the f parameter, which controls the fraction of colluding adversaries, between the Iris executions.
To find the minimum privacy ratio we get on every step across different executions,
we run the ./experiments/results/fig_PrivacyPerAttackers/script_FindMinPrivacyRatio.m script, to plot the data on one figure in matlab
we run the ./experiments/results/fig_PrivacyPerAttackers/script_PlotMinPrivacyRatioPerAttackers.m script.

4. [Figure 8](./experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta): This experiment studies how the selected addresses of the
random point and the target are distributed across the selection interval. To execute the experiment we run the ./experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta/script_PlotDistancesNormalizedByDelta.m
script that loads a mat file aquird by runing the script_ExecuteIris.m script. The script plots the distances as histograms normalised by δ and saves them into two csv files.

5. [Figure 9](./experiments/results/fig_Probabilities/fig_DistancesNormalizedByDelta): This experiments studies the attackers advantage by calculating
the probabilities to for the target to have a specific value by knowing the random point that is picked by Iris. The probabilities are calculated and plotted
by running the matlab scrip experiments/results/fig_Probabilities/fig_ConditionalProbabilities/script_PlotProbabilities.m on the two csv files that were
generated in the previous experiment.

**Order of Execution**: The exepriments are independent, thus, the scripts can be run following a different order from the
one presented in the paper.
