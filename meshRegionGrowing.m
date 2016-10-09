function [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, startindex, isVisited, clusterVertices, uVector)

    smoothnessThresholdinDegree = 10;

    if(~isVisited(startindex))
        isVisited(startindex) = 1;
        neighbourVertices  = adjacencyList{startindex};

        for j=1:length(neighbourVertices)

            if(~isVisited(neighbourVertices(j)))
                vVector = vertexNormals(neighbourVertices(j),:)';
                %theta = rad2deg(atan2(norm(cross(a,b)),dot(a,b)))
                ThetaInDegrees = rad2deg(atan2( norm(cross(uVector, vVector)) , dot(uVector, vVector)) );
                if(ThetaInDegrees < smoothnessThresholdinDegree)
                    clusterVertices = [clusterVertices neighbourVertices(j)];
                    [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexNormals, neighbourVertices(j), isVisited, clusterVertices, uVector);
                end
            end
        end
    end
        
end