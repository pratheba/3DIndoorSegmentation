function [] = convexConnectivity(blackFaceIndex, faces, vertices, vertexnormals, facenormals, faceindexforvertex)

    %  Get the neighbour faces
    %  check for convex or concave connectivity
    
    for i = 1:length(blackFaceIndex)

        % get centroid of the current face
        [curr_centroid, curr_x_cen, curr_y_cen, curr_z_cen] = GetCentroidForTriangle(vertices, faces, blackFaceIndex(i));

        neighbourFaces = GetNeighbouringFaces(faces(blackFaceIndex(i),:),faceindexforvertex);
        neighbourFaces = neighbourFaces(find(neighbourFaces~=blackFaceIndex(i)));
        neighbourFaces = unique(neighbourFaces, 'rows');
        
        for j = 1:length(neighbourFaces)
            % vertex1 = vertices(faces(neighbourFaces(j),1),:);
            % vertex2 = vertices(faces(neighbourFaces(j),2),:);
            % vertex3 = vertices(faces(neighbourFaces(j),3),:);
            % x_centroid = mean([vertex1(1) vertex2(1) vertex3(1)]);
            % y_centroid = mean([vertex1(2) vertex2(2) vertex3(2)]);
            % z_centroid = mean([vertex1(3) vertex2(3) vertex3(3)]);

            [neigh_centroid, neigh_x_cen, neigh_y_cen, neigh_z_cen] = GetCentroidForTriangle(vertices,faces, neighbourFaces(j));

            IsConvexConnected = CheckIfConvexConnected(curr_centroid, neigh_centroid, facenormals(blackFaceIndex(i)), facenormals(neighbourFaces(j)));

        end
    end
end