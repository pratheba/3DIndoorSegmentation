function isConvexConnectedn = CheckIfConvexConnected(curr_centroid, neigh_centroid, curr_facenormal, neigh_facenormal)
        Nxy = [0 0 1];
        Nyz = [1 0 0];
        Nzx = [0 1 0];

        norm_curr_facenormal = curr_facenormal / norm(curr_facenormal);
        norm_neigh_facenormal = neigh_facenormal / norm(neigh_facenormal);

        Angle_XY = acosd(dot(cross(norm_curr_facenormal,Nxy), cross(norm_neigh_facenormal,Nxy))); %the result
        Angle_YZ = acosd(dot(cross(norm_curr_facenormal,Nyz), cross(norm_neigh_facenormal,Nyz))); %the result
        Angle_ZX = acosd(dot(cross(norm_curr_facenormal,Nzx), cross(norm_neigh_facenormal,Nzx))); %the result

        disp(Angle_XY);
        disp(Angle_YZ);
        disp(Angle_ZX);


end