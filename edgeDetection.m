function [] = edgeDetection(vertex, faces)
		[triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertex, faces);
		adjacencyMatrix = triangulation2adjacency(faces,vertex);
		adjacencyList = adjacencyMatrix2List(adjacencyMatrix);
    
        numVertices = length(adjacencyList');
        clusterNumber = 0;
        SetIsVisited(isVisited);
        
        for i = 1: numVertices
            isVisited = GetIsVisited();
            if(~isVisited(i))
                clusterNumber = clusterNumber+1;
                SetGlobalClusterGroup(i);
                meshRegionGrowing(adjacencyList, vertexnormals, faces, i);
            
                disp(strcat('cluster seed',num2str(i),':'));
                clustergroup = GetGlobalClusterGroup();
                clustergroup = unique(clustergroup);
                %figure();
                trisurf(triangulatedVertex, 'FaceColor', [0.8 0.8 1.0]);
                axis equal;
                hold on;
                trimesh(faces, vertex(clustergroup,1), vertex(clustergroup,2), vertex(clustergroup,3), [1.0 0 0]);
                
                %surface(vertex(clustergroup,1),vertex(clustergroup,2),vertex(clustergroup,3));
                %view(3);
                %patch(vertex(clustergroup,1),vertex(clustergroup,2),vertex(clustergroup,3),'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
                %colorbar;

end