function [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, startindex, isVisited, clusterVertices, uVector)

    smoothnessThresholdinDegree = 10;
    nuVector = uVector / norm(uVector);
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
                nvVector = vVector/norm(vVector);
              
                %ThetaInDegrees = atan2d(cross(uVector, vVector)), dot(uVector, vVector));
                ThetaInDegrees1 = atan2d( cross(uVector, vVector) , dot(uVector, vVector) );
                ThetaInDegrees = acos(dot(uVector, vVector),;
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