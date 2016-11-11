function [] = startProcess(vertices, faces, outputFileName)

   faceIndexForEachVertex = GetFacesForEachVertex(faces);
    adjacencyListForFaces = GetFaceAdjacencyList(faces,vertices, faceIndexForEachVertex);
    
    %% If you want a cluster as struct then uncomment this
    [clusterNumberValue, colorInformationValue] = GetClustersBasedOnTraingulatedFaces(faces,vertices, adjacencyListForFaces);
     write_ply(vertices,faces,colorInformationValue, outputFileName);
end