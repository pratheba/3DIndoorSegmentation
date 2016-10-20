function [colorInformation] =  DisplayCluster(clusterfaces, vertices,clusterFaceIndex)
    c = rand(1,3);
     % Store the color information
    colorInformation = ceil(255*c(:));

    TR = triangulation(clusterfaces,vertices);
    h = trisurf(TR, 'FaceColor', c);
%     view(2);
%     centroid = GetCentroidForTriangles(clusterfaces,vertices);
% 
%     text(centroid(:,1),centroid(:,2),centroid(:,3),num2str(clusterFaceIndex));
  
    axis equal;
    hold on;
end