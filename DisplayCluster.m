function [colorInformation] =  DisplayCluster(clusterfaces, vertices)
    c = rand(1,3);
     % Store the color information
    colorInformation = ceil(255*c(:));

    TR = triangulation(clusterfaces,vertices);
    h = trisurf(TR, 'FaceColor', c);
    axis equal;
    hold on;
end