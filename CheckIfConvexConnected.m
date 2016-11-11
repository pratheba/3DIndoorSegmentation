function isConvexConnected = CheckIfConvexConnected(curr_centroid, neigh_centroid, curr_facenormal, neigh_facenormal)

        epsilon = 0.001;
        
        [angleInRad, angleInDeg] = FindDifferenceInAngleBetweenCentroidFaceNormals(curr_centroid, neigh_centroid, curr_facenormal, neigh_facenormal);
        
%         if((angleInRad >= 0) && (dot(curr_facenormal,neigh_facenormal)>=0))
%             isConvexConnected = 1;
%         else
%             isConvexConnected = 0;
%         end
        
        if((angleInDeg >= 0) && (dot(curr_facenormal,neigh_facenormal)>=0))
            isConvexConnected = 1;
        else
            isConvexConnected = 0;
        end
               
end
    