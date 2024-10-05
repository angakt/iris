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
5. **Iris vs Chord:**
   ```bash
   # this script executes Chord for the same
   # requester and target addresses as the ones 
   # used in Iris execution
   script_ExecuteIris
   ```

## Reproducibility Instructions

Our code consists of four sets of experiments:
