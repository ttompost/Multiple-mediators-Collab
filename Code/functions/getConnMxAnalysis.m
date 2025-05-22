function results = getConnMxAnalysis(connmx)
    % connmx = (N_pre, N_post)
    results = [];
    for postNeuron = 1:size(connmx,2)
        n_in = numel(find(connmx(:,postNeuron)>0));
        n_out = numel(find(connmx(postNeuron,:)>0));
        presyn = find(connmx(:,postNeuron)>0);
        postsyn = find(connmx(postNeuron,:)>0);
        [counts, edges] = histcounts(connmx(:,postNeuron), 0:0.05:20);
        weights = [counts; edges(2:end)-(diff(edges(1:2))/2)];

        results = [results; table(postNeuron,n_in,n_out,{presyn},{postsyn},{weights},...
            'VariableNames',{'NeuronIdx', 'N_in','N_out', 'PresynapticPartners', 'PostsynapticPartners', 'PresynapticWeights'})];
    end
end