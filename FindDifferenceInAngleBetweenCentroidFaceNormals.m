function [angleInRad, angleInDeg] = FindDifferenceInAngleBetweenCentroidFaceNormals(curr_centroid,neigh_centroid, curr_facenormal,neigh_facenormal)

        vectorFromCurrentToNeigh = neigh_centroid - curr_centroid;
        vectorFromCurrentToNeigh = vectorFromCurrentToNeigh/norm(vectorFromCurrentToNeigh);
        
        curr_facenormal = curr_facenormal/norm(curr_facenormal);
        neigh_facenormal = neigh_facenormal /norm(neigh_facenormal);
        vectorFromCurrentToNeigh = vectorFromCurrentToNeigh/norm(vectorFromCurrentToNeigh);
        
        angleFromCurrToDiff = acos(dot(curr_facenormal,vectorFromCurrentToNeigh));
        angleFromNeighToDiff = acos(dot(neigh_facenormal,vectorFromCurrentToNeigh));
        
        angleInRad = ((angleFromCurrToDiff) - (angleFromNeighToDiff));
        angleInDeg = rad2deg(angleInRad);
end
   