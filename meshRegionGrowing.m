function [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, startindex, isVisited, clusterVertices, uVector)

    smoothnessThresholdinDegree = 5;
    %isVisited = GetIsVisited();
    if(~isVisited(startindex))
        isVisited(startindex) = 1;
        %SetIsVisited(isVisited);
       % uVector = vertexNormals(startindex,:)';
        %disp(adjacencyList{startindex});
        neighbourVertices  = adjacencyList{startindex};

        for j=1:length(neighbourVertices);
            %isVisited = GetIsVisited();
            if(~isVisited(neighbourVertices(j)))
                vVector = vertexNormals(neighbourVertices(j),:)';
                %ThetaInDegrees = atan2d(norm(cross(uVector, vVector)), dot(uVector, vVector));
                ThetaInDegrees = atan2d( cross(uVector, vVector) , dot(uVector, vVector) );
                if(ThetaInDegrees < smoothnessThresholdinDegree)
                    %clusterVertices = GetGlobalClusterGroup();
                    clusterVertices = [clusterVertices neighbourVertices(j)];
                    %SetGlobalClusterGroup(clusterVertices);
                    [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, neighbourVertices(j), isVisited, clusterVertices, uVector);
                end
            end
        end
    end
        
end