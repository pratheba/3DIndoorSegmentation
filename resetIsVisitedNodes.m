function [isVisited] = resetIsVisitedNodes(clusterVertices, isVisited)
    n = length(clusterVertices);
    for i = 1:n
        isVisited(clusterVertices(i)) = 0;
    end
end