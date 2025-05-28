Dataset explanation:

Data/MiniNet/ contains excitatory-only (E) or excitatory-inhibitory (E-I) neural network activity, where neuronal spiking is modelled with leaky integrate-and-fire (LIF) dynamics:

dV_i/dt = [(E-V_i)+R*(I+I_ampa+I_ahp+I_n)]/tau, (1)

where V is the membrane potential for neuron i, E is the resting membrane potential, R is the membrane resistance, I is the external current, I_ampa is the synaptic current (Eq. 2), I_ahp is the hyperpolarisation-activated current (Eq. 3,4), I_n is the time-varying noise (random values drawn from a Gaussian distrubutin at each time point; mu=0, sigma=60/dt), and tau is the membrane time constant. A spike is registered when V_i crosses the threshold T=-55 mV, after which V_i resets to -70 mV.

All networks have 20 neurons, out of which only 5 receive external current. Neuron parameters were set as follows: E=-66±3 mV, R=2.25±0.75 MOhm, tau=100ms.

Simulation time = 250 ms.
Simulation time step (dt) = 0.1 ms.
ODE system solved with the 4th-order Runge-Kutta method.

External input I (Eq. 1) for the 5 input-receiving neurons had four shapes: step-pulse, ramp-and-hold, double ramp-and-hold and frozen noise. For shapes of the first three inputs, see below. The shape of the fourth input is noisy with two on-states (not shown here). See the explanation behind the frozen noise input in Zeldenrust et al (2017): https://www.frontiersin.org/journals/computational-neuroscience/articles/10.3389/fncom.2017.00049/full.

  _______
_|       |_ (step-pulse)

  _______
_/       \_ (ramp-and-hold)

  __   __
_/  \_/  \_ (double ramp-and-hold)


The three inputs from above had a maximal amplitude of 60 uA/cm2. Input onset was set to t=20 ms and offset to t=180 ms.

Neurons were randomly connected with 50% sparseness (i.e., 50% of all possible connections existed in the population, assuming 1 synapse per neuronal pair, excluding self-connections). Synaptic connectivity was modelled as: 

I_ampa(t) = g_ampa*S(t)*netcon*(V(t)-E_ampa), (2)

where I_ampa(t) is the excitatory synaptic current at time t, g_ampa (0.5 mS for EI networks, 0.32 mS for E networks) is the maximal channel conductance, S(t) is a presynaptic spike detection function, netcon is the sparse connectivity matrix (or ground truth), and E_ampa=0 mV is the channel reversal potential.

In E networks, all 20 neurons were excitatory. In E-I networks, 20% of the non-input receiving neurons were inhibitory. To model inhibitory connections, we reversed the sign in I_ampa (Eq. 2).

Each network condition (E, EI) was tested with four inputs in 2 sets of 10 trials per input. In the first 10-trial set (UniformW), synapses had identical weights (W=1) and connectivity structure, but neurons exhibited trial-specific spike-timing due to the noise term (I_n) in Eq. 1. Hence, each trial has a unique functional signature (activity) but identical network structure (connectivity matrix).

In the second 10-trial set (DistributedW), the connectivity matrix from before was used as a structural template, but each existing synapse was assigned a weight sampled from a normal distribution (W=1±0.2). Across 10 trials, the weighted matrix was identical (ground truth), and variance between trials was ensured by the neuron-specific noise term (I_n) in Eq. 1. Same as in UniformW, trials were functionally distinct but had identical underlying structure.

________________________________

In Eq. 1, I_ahp was modelled after Agnes and Vogels (2024, https://doi.org/10.1038/s41593-024-01597-4) as:

I_ahp(t) = -g_ahp(V-E_ahp),(3)

and

d(g_ahp)/dt = -g_ahp/tau_ahp + A_ahp*(V==reset), (4)

where g_ahp(0)=0.01 mS is the initial condition for maximal conductance of the hyperpolarisation-activated channel, E_ahp=-80 mV is the channel's reversal potential, tau_ahp is the decay constant, and A_ahp=5 nS is the current amplitude triggered by the hyperpolarised state (when V == reset, i.e. -70 mV).