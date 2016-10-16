
function [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, startindex, isVisited, clusterVertices, uVector)
  
    smoothnessThresholdinDegree = 10;
    nuVector = uVector / norm(uVector);

    if(~isVisited(startindex))
        isVisited(startindex) = 1;
        neighbourVertices  = adjacencyList{startindex};

        for j=1:length(neighbourVertices)
            if(~isVisited(neighbourVertices(j)))
                vVector = vertexNormals(neighbourVertices(j),:)';
                nvVector = vVector/norm(vVector);
              
                ThetaInDegrees = atan2d( cross(nuVector, nvVector) , dot(nuVector, nvVector) );
                if(ThetaInDegrees < smoothnessThresholdinDegree)
                    clusterVertices = [clusterVertices neighbourVertices(j)];
                    [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, neighbourVertices(j), isVisited, clusterVertices, uVector);
                end
            end
        end
    end
        
end