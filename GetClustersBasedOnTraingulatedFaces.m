function [clusters, colorInformationValue] = GetClustersBasedOnTraingulatedFaces(faces,vertices,adjacencyListForFaces)
    
    [triangulatedVertex, vertexNormals, faceNormals] = computeVertexAndFaceNormalAndDisplay(faces, vertices); %ComputeVertexAndFaceNormal(faces,vertices);
    
    SetGlobalValues('faceNormals', faceNormals);
    SetGlobalValues('vertexNormals', vertexNormals);

    [centroid] = GetCentroidForTriangles(faces,vertices);

    numFaces = length(faces);
    isVisitedFaces = zeros(numFaces,1);
    clusterNumber = 0;

    clusters = cell(numFaces,numFaces);
    colorInformationValue = zeros(numFaces,3);
    smallGroupSizeCluster = [];
    mapFaceToCluster = zeros(numFaces,1);
 
    figure();
    hold on;
    for i = 1:numFaces
        if(~isVisitedFaces(i))
            clusterNumber = clusterNumber+1;
            clusterFaces = i;
            
            uVector = faceNormals(i,:)';
            uVector = uVector /norm(uVector);

            [clusterFaces, isVisitedFaces] = MeshRegionGrowingByComparingFaceNormals(faces, adjacencyListForFaces, i, uVector, isVisitedFaces,faceNormals,centroid,clusterFaces);
            
            clusters{clusterNumber} = clusterFaces;
            mapFaceToCluster(clusterFaces) = clusterNumber;

            smallGroupSizeCluster = CheckIfToSmallerOrLargerClusterGroup(clusterFaces, clusterNumber, smallGroupSizeCluster, faces, vertices);
        end
    end
     
    hold off;
    clusters = clusters(~cellfun('isempty',clusters));  
    [clusters,mapFaceToCluster] = AssignSmallerClusterGroupsToBiggerClusters(clusters, smallGroupSizeCluster, mapFaceToCluster,adjacencyListForFaces,colorInformationValue,centroid);
    clusters = clusters(~cellfun('isempty',clusters)); 
    %hold off;
    hold off;
    for n = 1:length(clusters)
        %mapFaceToCluster(clusters{n}) = n;
        colorInformation = DisplayCluster(faces(clusters{n},:), vertices,clusters{n},vertexNormals, faceNormals,0); 
        for c = 1:3
            colorInformationValue(clusters{n},c) = colorInformation(c);
        end
    end
   % hold off;
    
    %% Remove the extra Values
    % clusterNumberValue = clusterNumberValue(~cellfun('isempty',clusterNumberValue)) ;

    %% Creating a struct is heavy duty.
    %clusters = struct(faceField, clusterNumberValue, colorField, colorInformationValue);

end