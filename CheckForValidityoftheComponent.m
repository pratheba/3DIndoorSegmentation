function [numberOfVertices, finalClusterVertices, isVisited] = CheckForValidityoftheComponent(clusterVertices, isVisited, adjacencyList, vertexnormals)

    n = length(clusterVertices);
    isVisited = resetIsVisitedNodes(clusterVertices,isVisited);
    numberOfVertices = n;
    finalClusterVertices = clusterVertices;
    if (n >= 20)
    for i=1:20
        r = randi(n);
        newclusterVertices = clusterVertices(i);
        uVector = vertexnormals(clusterVertices(i),:)';
        [newclusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexnormals, clusterVertices(i), isVisited, newclusterVertices, vertexnormals(clusterVertices(i),:)');          
        %numberOfVertices = length(newclusterVertices);
        if( length(newclusterVertices) > numberOfVertices)
            numberOfVertices = length(newclusterVertices);
            finalClusterVertices = newclusterVertices;
        end
        isVisited = resetIsVisitedNodes(newclusterVertices,isVisited);
    end
    end
    
    for i=1:numberOfVertices
        isVisited(finalClusterVertices(i)) = 1;
    end
end