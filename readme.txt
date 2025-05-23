Dataset explanation:

Data/MiniNet/ contains excitatory-only (E) or excitatory-inhibitory (E-I) neural network activity, where neuronal spiking is modelled with leaky integrate-and-fire (LIF) dynamics:

dV/dt = [(E-V)+R*(I+I_ampa+I_ahp)]/tau, (1)

where V is the neuronal membrane potential, E is the resting membrane potential, R is the membrane resistance, I is the external current, I_ampa is the synaptic current (Eq. 2), I_ahp is the hyperpolarisation-activated current (Eq. 3,4), and tau is the membrane time constant. A spike is registered when V crosses the threshold T=-55 mV, after which V resets to -70 mV.

All networks have 20 neurons, out of which only 5 receive external current. Neuron parameters were set as follows: E=-66±3 mV, R=2.25±0.75 MOhm, tau=100ms.

Simulation time = 200 ms.
Simulation time step = 0.1 ms.
ODE system solved with the 4th-order Runge-Kutta method.

External input I (Eq. 1) for the 5 input-receiving neurons had four shapes: step-pulse, ramp-and-hold, double ramp-and-hold and frozen noise. For shapes of the first three inputs, see below. The shape of the fourth input is noisy with two on-states (not shown here). See the explanation behind the frozen noise input in Zeldenrust et al (2017): https://www.frontiersin.org/journals/computational-neuroscience/articles/10.3389/fncom.2017.00049/full.

  _______
_|       |_ (step-pulse)

  _______
_/       \_ (ramp-and-hold)

  __   __
_/  \_/  \_ (double ramp-and-hold)


The three inputs from above had a maximal amplitude of 120 uA/cm2. Input onset was set to t=20 ms and offset to t=180 ms.

Neurons were randomly connected with 50% sparseness (i.e., 50% of all possible connections existed in the population, assuming 1 synapse per neuronal pair). Synaptic connectivity was modelled as: 

I_ampa(t) = g_ampa*S(t)*netcon*(V(t)-E_ampa), (2)

where I_ampa(t) is the excitatory synaptic current at time t, g_ampa (0.5 mS for EI networks, 0.32 mS for E networks) is the maximal channel conductance, S(t) is a presynaptic spike detection function, netcon is the sparse connectivity matrix, and E_ampa=0 mV is the channel reversal potential.

In E networks, all 20 neurons were excitatory. In E-I networks, 20% of the non-input receiving neurons were inhibitory. To model inhibitory connections, we reversed the sign in I_ampa (Eq. 2).

Each network condition (E, EI) was tested with the same input in 2 sets of 10 trials. In the first 10-trial set (UniformW), synapses had identical weights (W=1), but each trial had a unique netcon due to random assignment of synapses across the population (i.e., the connectivity structure was trial-specific).
In the second 10-trial set (DistributedW), different trials had both varying connectivity structures and connection weights varied within each trial. Per trial in the DistributedW set, values for connection weights were sampled from a normal distribution (W=1±0.2).  

________________________________

In Eq. 1, I_ahp was modelled after Agnes and Vogels (2024, https://doi.org/10.1038/s41593-024-01597-4) as:

I_ahp(t) = -g_ahp(V-E_ahp),(3)

and

d(g_ahp)/dt = -g_ahp/tau_ahp + A_ahp*(V==reset), (4)

where g_ahp(0)=0.01 mS is the initial condition for maximal conductance of the hyperpolarisation-activated channel, E_ahp=-80 mV is the channel's reversal potential, tau_ahp is the decay constant, and A_ahp=5 nS is the current amplitude triggered by the hyperpolarised state (when V == reset, i.e. -70 mV).