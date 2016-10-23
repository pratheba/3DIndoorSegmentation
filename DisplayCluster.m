function [colorInformation] =  DisplayCluster(clusterfaces, vertices,clusterFaceIndex,vertexNormals, faceNormals,isSmallGroup)
    c = rand(1,3);
    if(isSmallGroup)
        c = [1 0 0];
    end
     % Store the color information
    colorInformation = ceil(255*c(:));
   
    TR = triangulation(clusterfaces,vertices);
    h = trisurf(TR, 'FaceColor', c);
    axis equal;
    hold on;
    incenterofTriangles = incenter(TR);
	%quiver3(vertex(:,1), vertex(:,2), vertex(:,3), vertexnormals(:,1), vertexnormals(:,2), vertexnormals(:,3), 0.7, 'color', 'r');
	quiver3(incenterofTriangles(:,1), incenterofTriangles(:,2), incenterofTriangles(:,3), faceNormals(clusterFaceIndex,1), faceNormals(clusterFaceIndex,2), faceNormals(clusterFaceIndex,3), 0.8, 'color', 'g');
	%hold off
    
	%displayNormals(TR, vertices, vertexNormals, incenterofTriangles, faceNormals(clusterFaceIndex,:));
%     hold on;
%     view(2);
%     centroid = GetCentroidForTriangles(clusterfaces,vertices); 
%     text(centroid(:,1),centroid(:,2),centroid(:,3),num2str(clusterFaceIndex));
%    
%     
    axis equal;
    %hold off;
end