function smallGroupSizeCluster = CheckIfToSmallerOrLargerClusterGroup(clusterFaces, clusterNumber,smallGroupSizeCluster,faces,vertices)
  
    vertexNormals = GetGlobalValues('vertexNormals');
    faceNormals = GetGlobalValues('faceNormals');
         
    if(length(clusterFaces) <= GetGlobalClusterGroupSize())
        disp('cluster group size is small');
        disp(length(clusterFaces));

        % % Combine the clusters with the neighbouring faces
        %% Store these values seperately
        % % Once we get all the clusters, we then take these groups and find the neighbours
        % % Combine with neighbours of majority OR combine them with neighbour group which is convex and had the smallest angle difference
        smallGroupSizeCluster = [smallGroupSizeCluster; clusterNumber];
        DisplayCluster(faces(clusterFaces,:), vertices,clusterFaces,vertexNormals, faceNormals,1); 
    else
         
         DisplayCluster(faces(clusterFaces,:), vertices,clusterFaces,vertexNormals, faceNormals,0); 
    end

end