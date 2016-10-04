function [] = startProcess(vertex, faces)
        [faceVertices, indexfaces] = getFacesForEachVertex(vertex, faces);
%         r = randi(1000,1,1000);
%         r = r';
        
		[triangulatedVertex, vertexnormals, facenormals] = computeVertexAndFaceNormalAndDisplay(vertex, faces);
		adjacencyMatrix = triangulation2adjacency(faces,vertex);
        %adjacencyMatrix = triangulation2adjacency(faces(r,:),vertex(r,:));
		
		adjacencyList = adjacencyMatrix2List(adjacencyMatrix);
    
        numVertices = length(adjacencyList');
        isVisited = zeros(1, numVertices);
        clusterNumber = 0;
        colorInformation = zeros(length(faces),3);
        %SetIsVisited(isVisited);
        figure();
        %trisurf(triangulatedVertex, 'FaceColor', [0.8 0.8 1.0]);
        %axis equal;
        %hold on;
        for i = 1: numVertices
            %isVisited = GetIsVisited();
            if(~isVisited(i))
                clusterNumber = clusterNumber+1;
               % SetGlobalClusterGroup(i);
                clusterVertices = i;
                uVector = vertexnormals(i,:)';
                [clusterVertices, isVisited] = meshRegionGrowing(adjacencyList, vertexnormals, i, isVisited, clusterVertices, vertexnormals(i,:)');
          
                [numberOfClusterVertices, finalClusterVertices, isVisited] = CheckForValidityoftheComponent(clusterVertices, isVisited, adjacencyList, vertexnormals);
%                 for k=1:length(clusterVertices)
%                     disp(vertexnormals(clusterVertices(k),:));
%                 end;
                %disp(strcat('cluster seed',num2str(i),':'));
                %clustergroup = GetGlobalClusterGroup();
                %clustergroup = unique(clustergroup);
                %figure();
                valueSet = values(faceVertices,num2cell(finalClusterVertices));
                clustergroupfaces=[];
                for v=1:length(valueSet)
                    clustergroupfaces = [clustergroupfaces; valueSet{v}];
                end
                %TR = triangulation(clustergroupfaces,vertex(clustergroupfaces));%(:,1)), vertex(clustergroupfaces(:,2)), vertex(clustergroupfaces(:,3)));
               % disp(clustergroupfaces(1,:));
%                 vertex1 = clustergroupfaces(:,1);
%                 disp(vertex(vertex1(1),:));
%                 disp(vertex(vertex1(2,:)));
%                 DT = delaunayTriangulation(vertex(clustergroupfaces(:,1)),vertex(clustergroupfaces(:,2)),vertex(clustergroupfaces(:,3)));
%                 hullFacets = convexHull(DT);
%                 
%                 modify_cm = colormap('winter');
%                 trisurf(hullFacets, DT.Points(:,1), DT.Points(:,2), DT.Points(:,3))
% 
%                 % Use the entirely custom color mapping
%                 colormap(modify_cm)


                %patch('Vertices', vertex, 'Faces', clustergroupfaces, 'FaceColor','flat','EdgeColor','flat', 'Marker','o','MarkerFaceColor','flat');
                c = rand(1,3);
                tri = triangulation(clustergroupfaces, vertex);
                
                clustergroupfaces=[];
                faceindexValueset = values(indexfaces,num2cell(finalClusterVertices));
                for v=1:length(faceindexValueset)
                    clustergroupfaces = [clustergroupfaces; faceindexValueset{v}];
                end
                for k=1:length(clustergroupfaces)
                    %index = values(indexfaces,num2cell(clusterVertices(k)));
                    colorInformation(clustergroupfaces(k),:) = ceil(255*c(:));
                end

               % colorInformation(clustergroupfaces,:) = ceil(255*c(:));
                
%                 for k=1:length(clustergroupfaces)
%                     index = values(indexfaces,num2cell(clusterVertices(k)));
%                     colorInformation(index{1},:) = ceil(255*c(:));
%                 end
                h = trisurf(tri, 'FaceColor', c);%, vertex(clustergroupfaces(:,1)), vertex(clustergroupfaces(:,2)), vertex(clustergroupfaces(:,3)),'FaceColor',[1.0 0.0 0.0]);
                axis equal;
                hold on;
                %facesForVertices = faceVertices(clustergroup);
                %trimesh(valueSet, vertex(clustergroup,1), vertex(clustergroup,2), vertex(clustergroup,3), [1.0 0 0]);
                
                %surface(vertex(clustergroup,1),vertex(clustergroup,2),vertex(clustergroup,3));
                %view(3);
                %patch(vertex(clustergroup,1),vertex(clustergroup,2),vertex(clustergroup,3),'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
                %colorbar;
            end
            %disp(clustergroup);
        end
        hold off;
        write_ply(vertex,faces,colorInformation, 'test.ply');
end