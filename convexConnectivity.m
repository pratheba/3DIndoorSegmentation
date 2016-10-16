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

            [neigh_centroid, neigh_x_cen, neigh_y_cen, neigh_z_cen] = GetCentroidForTriangle(vertices,faces, neighbourFaces(j));

            IsConvexConnected = CheckIfConvexConnected(curr_centroid, neigh_centroid, facenormals(blackFaceIndex(i)), facenormals(neighbourFaces(j)));

        end
    end
end