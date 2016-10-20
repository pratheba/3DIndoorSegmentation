function [clusterNumberValue, colorInformationValue] = GetClustersBasedOnTraingulatedFaces(faces,vertices,adjacencyListForFaces)
    
    [triangulatedVertex, vertexNormals, faceNormals] = computeVertexAndFaceNormalAndDisplay(faces, vertices); %ComputeVertexAndFaceNormal(faces,vertices);
    [centroid] = GetCentroidForTriangles(faces,vertices);

    numFaces = length(faces);
    isVisitedFaces = zeros(numFaces,1);
    clusterNumber = 0;

    faceField  = 'Faces';
    colorField = 'Color';
    clusterNumberValue = cell(numFaces,numFaces);
    colorInformationValue = zeros(numFaces,3);
   
    figure();
    
    for i = 1:numFaces
        if(~isVisitedFaces(i))
            clusterNumber = clusterNumber+1;

            clusterFaces = i;
            uVector = faceNormals(i,:)';
            [clusterFaces, isVisitedFaces] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, i, uVector, isVisitedFaces,faceNormals,centroid,clusterFaces);
            
%             if(length(clusterFaces) < GetGlobalClusterGroupSize)
%                 disp('cluster group size is small');
%                 disp(length(clusterFaces));
%                 % Combine the clusters with the neighbouring faces
%                 %% Store these values seperately
%                 % % Once we get all the clusters, we then take these groups and find the neighbours
%                 % % Combine with neighbours of majority OR combine them with neighbour group which is convex and had the smallest angle difference
%             end

            clusterNumberValue{clusterNumber} = clusterFaces;
            
            colorInformation = DisplayCluster(faces(clusterFaces,:), vertices,clusterFaces); 
            for c = 1:3
                colorInformationValue(clusterFaces,c) = colorInformation(c);
            end
        end
    end
    hold off;
    
    %% Remove the extra Values
    %clusterNumberValue(~cellfun('isempty',clusterNumberValue)) ;
%     ArraytoRemove = [clusterNumber+1, clusterNumberValue(end)];
%     clusterNumberValue(ArraytoRemove = [];
    
    %% Creating a struct is heavy duty.
    %clusters = struct(faceField, clusterNumberValue, colorField, colorInformationValue);

end