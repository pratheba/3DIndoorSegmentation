function [centroid, x_centroid, y_centroid, z_centroid] = GetCentroidForTriangle(vertices, faces, currentface)

            vertex1 = vertices(faces(currentface,1),:);
            vertex2 = vertices(faces(currentface,2),:);
            vertex3 = vertices(faces(currentface,3),:);
            x_centroid = mean([vertex1(1) vertex2(1) vertex3(1)]);
            y_centroid = mean([vertex1(2) vertex2(2) vertex3(2)]);
            z_centroid = mean([vertex1(3) vertex2(3) vertex3(3)]);

            field1 = 'x_centroid' ; value1 = x_centroid;
            field2 = 'y_centrold' ; value2 = y_centroid;
            field3 = 'z_centroid' ; value3 = z_centroid;

            centroid = struct(field1,value1, field2,value2, field3, value3);
end